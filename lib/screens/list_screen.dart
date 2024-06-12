import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'transaction_detail_screen.dart';
import 'package:intl/intl.dart';
import '../widgets/item_form.dart';

class ListScreen extends StatefulWidget {
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final ApiService apiService =
      ApiService(baseUrl: 'https://api-credit-card-fraud.onrender.com');
  List<Map<String, dynamic>> transactions = [];
  bool isLoading = true;
  String? errorMessage;
  final TextEditingController _transactionIdController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }

  Future<void> fetchTransactions() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      List<Map<String, dynamic>> fetchedTransactions =
          await apiService.fetchTransactions();
      setState(() {
        transactions = fetchedTransactions;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
        errorMessage = 'Erro ao buscar transações: $error';
      });
    }
  }

  Future<void> fetchTransactionById(String id) async {
    if (id.isEmpty) {
      fetchTransactions();
      return;
    }
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final transaction = await apiService.fetchTransactionById(id);
      if (transaction.isEmpty) {
        setState(() {
          transactions = [];
          isLoading = false;
          errorMessage =
              'Não foi encontrada nenhuma transação com o ID informado, favor verificar.';
        });
        return;
      }
      setState(() {
        transactions = [transaction];
        isLoading = false;
        errorMessage = null;
      });
    } catch (error) {
      setState(() {
        transactions = [];
        isLoading = false;
        errorMessage =
            'Não foi encontrada nenhuma transação com o ID informado, favor verificar.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.vermelho,
        centerTitle: true,
        title: Text(
          'Análise de transação',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.branco,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.branco),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.branco,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Filtro por ID da transação',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: ItemForm(
                    controller: _transactionIdController,
                    hintText: 'Digite o ID da transação',
                    fillColor: Colors.cinza,
                    borderColor: Colors.cinza,
                    textColor: Colors.black,
                    hintColor: Colors.black54,
                  ),
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 60,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () =>
                        fetchTransactionById(_transactionIdController.text),
                    child: Icon(Icons.search, color: Colors.branco, size: 30),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(16.0),
                      backgroundColor: Colors.preto,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Transações',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : transactions.isEmpty && errorMessage != null
                      ? Center(
                          child: Text(
                              'Não foi encontrada nenhuma transação com o ID informado, favor verificar.'))
                      : ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (BuildContext context, int index) {
                            final transaction = transactions[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        TransactionDetailScreen(
                                            transaction: transaction),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.vermelho,
                                margin: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '${transaction['city'] ?? ''}, ${transaction['state'] ?? ''}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.branco),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            transaction['category'] ?? '',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.branco),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'R\$ ${transaction['amt'] != null ? NumberFormat('#,##0.00', 'pt_BR').format(transaction['amt']) : ''}',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.branco),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

class TransactionDetailScreen extends StatefulWidget {
  final Map<String, dynamic> transaction;

  TransactionDetailScreen({required this.transaction});

  @override
  _TransactionDetailScreenState createState() =>
      _TransactionDetailScreenState();
}

class _TransactionDetailScreenState extends State<TransactionDetailScreen> {
  bool isLoading = true;
  bool isFraud = false;

  @override
  void initState() {
    super.initState();
    fetchFraudStatus();
  }

  Future<void> fetchFraudStatus() async {
    final response = await http.get(Uri.parse(
        'https://api-credit-card-fraud.onrender.com/api/is-fraud/${widget.transaction['id']}'));
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        isFraud = responseData['is_fraud'] == 1;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar status de fraude')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 100, 10, 10),
        centerTitle: true,
        title: Text(
          'Detalhes da transação',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color.fromARGB(255, 250, 249, 246),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 250, 249, 246)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 250, 249, 246),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: <Widget>[
                  Text(
                      'Categoria da transação: ${widget.transaction['category']}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text(
                      'Valor da transação: R\$ ${widget.transaction['amt'] != null ? NumberFormat('#,##0.00', 'pt_BR').format(widget.transaction['amt']) : ''}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Gênero: ${widget.transaction['gender']}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Cidade: ${widget.transaction['city']}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Estado: ${widget.transaction['state']}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Latitude do titular: ${widget.transaction['lat']}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Longitude do titular: ${widget.transaction['long']}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text(
                      'População da cidade do titular: ${widget.transaction['city_pop']}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text('Cargo: ${widget.transaction['job']}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text(
                      'Unix_time da transação: ${widget.transaction['unix_time']}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text(
                      'Latitude do estabelecimento: ${widget.transaction['merch_lat']}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text(
                      'Longitude do estabelecimento: ${widget.transaction['merch_long']}',
                      style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: 'Resultado da análise: ',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                      children: <TextSpan>[
                        TextSpan(
                          text: isFraud ? 'É FRAUDE!' : 'NÃO É FRAUDE!',
                          style: TextStyle(
                            fontSize: 18,
                            color: isFraud ? Colors.red : Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

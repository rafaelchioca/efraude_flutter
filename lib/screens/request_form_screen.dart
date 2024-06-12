import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/item_form.dart';

class RequestFormScreen extends StatefulWidget {
  @override
  _RequestFormScreenState createState() => _RequestFormScreenState();
}

class _RequestFormScreenState extends State<RequestFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _amtController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  final TextEditingController _cityPopController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  final TextEditingController _unixTimeController = TextEditingController();
  final TextEditingController _merchLatController = TextEditingController();
  final TextEditingController _merchLongController = TextEditingController();

  final ApiService apiService =
      ApiService(baseUrl: 'https://api-credit-card-fraud.onrender.com');

  @override
  void initState() {
    super.initState();
    _amtController.addListener(_replaceCommaWithDot);
  }

  @override
  void dispose() {
    _amtController.removeListener(_replaceCommaWithDot);
    _amtController.dispose();
    super.dispose();
  }

  void _replaceCommaWithDot() {
    String text = _amtController.text;
    if (text.contains(',')) {
      _amtController.text = text.replaceAll(',', '.');
      _amtController.selection = TextSelection.fromPosition(
          TextPosition(offset: _amtController.text.length));
    }
  }

void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    try {
      final transaction = {
        'category': _categoryController.text,
        'amt': (double.tryParse(_amtController.text.replaceAll(',', '.'))?.round() ?? 0),
        'gender': _genderController.text,
        'city': _cityController.text,
        'state': _stateController.text,
        'lat': double.tryParse(_latController.text.replaceAll(',', '.')) ?? 0.0,
        'long': double.tryParse(_longController.text.replaceAll(',', '.')) ?? 0.0,
        'city_pop': int.tryParse(_cityPopController.text.replaceAll(',', '.')) ?? 0,
        'job': _jobController.text,
        'unix_time': int.tryParse(_unixTimeController.text.replaceAll(',', '.')) ?? 0,
        'merch_lat': double.tryParse(_merchLatController.text.replaceAll(',', '.')) ?? 0.0,
        'merch_long': double.tryParse(_merchLongController.text.replaceAll(',', '.')) ?? 0.0,
      };

      print('Transaction data: $transaction');

      final response = await apiService.createTransaction(transaction);

      print('Create transaction response: $response');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Transação criada com sucesso')),
      );
      Navigator.pop(context, response);
    } catch (error) {
      print('Error: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao criar transação: $error')),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.vermelho,
        centerTitle: true,
        title: Text(
          'Cadastrar uma nova transação',
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Text(
                'Categoria da transação',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ItemForm(
                controller: _categoryController,
                hintText: 'Digite a categoria',
                fillColor: Colors.cinza,
                borderColor: Colors.cinza,
                textColor: Colors.black,
                hintColor: Colors.black54,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a categoria';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Valor da transação',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ItemForm(
                controller: _amtController,
                hintText: 'Digite o valor',
                fillColor: Colors.cinza,
                borderColor: Colors.cinza,
                textColor: Colors.black,
                hintColor: Colors.black54,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o valor';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Gênero',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ItemForm(
                controller: _genderController,
                hintText: 'Digite o gênero',
                fillColor: Colors.cinza,
                borderColor: Colors.cinza,
                textColor: Colors.black,
                hintColor: Colors.black54,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o gênero';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Cidade',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ItemForm(
                controller: _cityController,
                hintText: 'Digite a cidade',
                fillColor: Colors.cinza,
                borderColor: Colors.cinza,
                textColor: Colors.black,
                hintColor: Colors.black54,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a cidade';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Estado (UF)',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ItemForm(
                controller: _stateController,
                hintText: 'Digite o estado (UF)',
                fillColor: Colors.cinza,
                borderColor: Colors.cinza,
                textColor: Colors.black,
                hintColor: Colors.black54,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o estado';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Latitude',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ItemForm(
                controller: _latController,
                hintText: 'Digite a latitude',
                fillColor: Colors.cinza,
                borderColor: Colors.cinza,
                textColor: Colors.black,
                hintColor: Colors.black54,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a latitude';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Longitude',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ItemForm(
                controller: _longController,
                hintText: 'Digite a longitude',
                fillColor: Colors.cinza,
                borderColor: Colors.cinza,
                textColor: Colors.black,
                hintColor: Colors.black54,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a longitude';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'População da cidade',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ItemForm(
                controller: _cityPopController,
                hintText: 'Digite a população da cidade',
                fillColor: Colors.cinza,
                borderColor: Colors.cinza,
                textColor: Colors.black,
                hintColor: Colors.black54,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a população da cidade';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Cargo',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ItemForm(
                controller: _jobController,
                hintText: 'Digite o cargo',
                fillColor: Colors.cinza,
                borderColor: Colors.cinza,
                textColor: Colors.black,
                hintColor: Colors.black54,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o cargo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Unix Time',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ItemForm(
                controller: _unixTimeController,
                hintText: 'Digite o Unix Time',
                fillColor: Colors.cinza,
                borderColor: Colors.cinza,
                textColor: Colors.black,
                hintColor: Colors.black54,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o Unix Time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Latitude do Estabelecimento',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ItemForm(
                controller: _merchLatController,
                hintText: 'Digite a latitude do estabelecimento',
                fillColor: Colors.cinza,
                borderColor: Colors.cinza,
                textColor: Colors.black,
                hintColor: Colors.black54,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a latitude do estabelecimento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Text(
                'Longitude do Estabelecimento',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.preto,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              ItemForm(
                controller: _merchLongController,
                hintText: 'Digite a longitude do estabelecimento',
                fillColor: Colors.cinza,
                borderColor: Colors.cinza,
                textColor: Colors.black,
                hintColor: Colors.black54,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a longitude do estabelecimento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  child: Text(
                    'CADASTRAR',
                    style: TextStyle(
                      color: Colors.branco,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.preto,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

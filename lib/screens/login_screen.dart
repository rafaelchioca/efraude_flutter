import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/item_form.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final ApiService apiService =
      ApiService(baseUrl: 'https://api-credit-card-fraud.onrender.com');

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        final response = await apiService.login(
            _emailController.text, _passwordController.text);
        if (response.containsKey('access_token')) {
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erro ao fazer login')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao fazer login: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 100, 10, 10),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/images/logo_e_fraude_branco.png',
                      width: 200,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'LOGIN',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Color.fromARGB(255, 250, 249, 246),
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'E-mail',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 250, 249, 246),
                    ),
                  ),
                  SizedBox(height: 8),
                  ItemForm(
                    controller: _emailController,
                    hintText: 'Digite o e-mail',
                    fillColor: Color.fromARGB(255, 82, 24, 24),
                    borderColor: Color.fromARGB(255, 82, 24, 24),
                    textColor: Color.fromARGB(255, 250, 249, 246),
                    hintColor: Colors.white70,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira o e-mail';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Senha',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 250, 249, 246),
                    ),
                  ),
                  SizedBox(height: 8),
                  ItemForm(
                    controller: _passwordController,
                    hintText: 'Digite a senha',
                    fillColor: Color.fromARGB(255, 82, 24, 24),
                    borderColor: Color.fromARGB(255, 82, 24, 24),
                    textColor: Color.fromARGB(255, 250, 249, 246),
                    hintColor: Colors.white70,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira a senha';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: Text(
                        'ENTRAR',
                        style: TextStyle(
                          color: Color.fromARGB(255, 250, 249, 246),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 30, 30, 30),
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:e_fraude/widgets/item_home_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 100, 10, 10),
        centerTitle: true,
        title: Text(
          'Início',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color.fromARGB(255, 250, 249, 246),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            padding: EdgeInsets.only(right: 16),
            color: Color.fromARGB(255, 250, 249, 246),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      backgroundColor: Color.fromARGB(255, 250, 249, 246),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                itemHomeScreen(
                  text: 'Análise de transação',
                  routeName: '/list',
                ),
                SizedBox(height: 8),
                itemHomeScreen(
                  text: 'Cadastro de transação',
                  routeName: '/request_form',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

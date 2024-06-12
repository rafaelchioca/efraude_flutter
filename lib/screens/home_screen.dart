import 'package:flutter/material.dart';
import 'package:e_fraude/widgets/item_home_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.vermelho,
        centerTitle: true,
        title: Text(
          'Início',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.branco,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            padding: EdgeInsets.only(right: 16),
            color: Colors.branco,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      backgroundColor: Colors.branco,
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

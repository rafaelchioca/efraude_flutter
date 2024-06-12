import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/list_screen.dart';
import 'screens/request_form_screen.dart';

void main() {
  runApp(EFraudeApp());
}

class EFraudeApp extends StatelessWidget {
  const EFraudeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Requisições App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: InputDecorationTheme(
          errorStyle: TextStyle(color: Color.fromARGB(255, 250, 249, 246)),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/list': (context) => ListScreen(),
        '/request_form': (context) => RequestFormScreen(),
      },
    );
  }
}

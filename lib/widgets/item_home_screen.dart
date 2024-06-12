import 'package:flutter/material.dart';

class itemHomeScreen extends StatelessWidget {
  final String text;
  final String routeName;

  const itemHomeScreen({
    required this.text,
    required this.routeName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double buttonWidth = screenWidth * 0.4;

    return Container(
      width: buttonWidth,
      height: buttonWidth,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, routeName);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.vermelho,
          foregroundColor: Colors.branco,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

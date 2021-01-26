import 'package:flutter/material.dart';

class Questao extends StatelessWidget {
  final String texto;

  Questao(this.texto);

  @override
  Widget build(BuildContext context) {
    return Container(
   //   color: Colors.red,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: 
       Text(
        texto,
        style: TextStyle(
          fontSize: 25,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

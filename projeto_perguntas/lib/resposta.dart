import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String texto;
  final void Function() quandoSelecionado;

  Resposta(this.texto, {this.quandoSelecionado});

  @override
  Widget build(BuildContext context) {
    return Container(

      width: double.infinity,
      height: 50,
      margin: EdgeInsets.only(bottom: 5, right: 10, left: 10, top: 5),
        color: Colors.red,
      child: RaisedButton(
        textColor: Colors.white,
        color: Colors.blue,
        onPressed: quandoSelecionado,
        child: Text(
          texto,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}

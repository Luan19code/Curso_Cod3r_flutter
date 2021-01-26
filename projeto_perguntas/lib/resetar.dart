import 'package:flutter/material.dart';

class Resetar extends StatelessWidget {
  final void Function() iniciar;

  Resetar(this.iniciar);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.refresh, size: 20,),
      onPressed: iniciar,
      color: Colors.white,
    );
  }
}

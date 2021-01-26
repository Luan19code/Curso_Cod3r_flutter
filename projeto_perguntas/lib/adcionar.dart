import 'package:flutter/material.dart';

class AdicionarResposta extends StatelessWidget {
  final void Function() add;

  AdicionarResposta(this.add);
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add),
      onPressed: add,
      color: Colors.white,
    );
  }
}

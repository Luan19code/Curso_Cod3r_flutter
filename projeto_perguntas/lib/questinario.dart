import 'package:flutter/material.dart';

import 'questoes.dart';
import 'resposta.dart';

class Questionario extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function() responder;

  Questionario({
    @required this.perguntas,
    @required this.perguntaSelecionada,
    @required this.responder,
  });


  bool get temPerguntasSelecionadas {
    return perguntaSelecionada < perguntas.length;
  }
  @override
  Widget build(BuildContext context) {


    
final List<String> respostas = temPerguntasSelecionadas
        ? perguntas[perguntaSelecionada]["resposta"]
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        //
        //
        Questao(perguntas[perguntaSelecionada]["texto"]),
        //
        //
        ...respostas
            .map((t) => Resposta(t, quandoSelecionado: responder))
            .toList(),
        //
        //
      ],
    );
  }
}

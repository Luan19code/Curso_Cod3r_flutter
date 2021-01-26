import 'package:flutter/material.dart';
import 'package:projeto_perguntas/adcionar.dart';
import 'package:projeto_perguntas/questinario.dart';
import 'package:projeto_perguntas/questoes.dart';
import 'package:projeto_perguntas/resetar.dart';
import 'package:projeto_perguntas/resposta.dart';
import 'package:projeto_perguntas/resultado.dart';

main() => runApp(PerguntaApp());

class PerguntaApp extends StatefulWidget {
  @override
  _PerguntaAppState createState() => _PerguntaAppState();
}

class _PerguntaAppState extends State<PerguntaApp> {
  int _perguntaSelecionada = 0;

  final List<Map<String, Object>> _perguntas = const [
    {
      "texto": "Qual é o seu animal favorito?",
      "resposta": [
        "Urso",
        "Galinha",
        "Leão",
        "Erlon",
      ]
    },
    {
      "texto": "Qual é a sua Cor favorito?",
      "resposta": [
        "Azul",
        "Verde",
        "Rosa",
        "Limão",
      ]
    },
    {
      "texto": "Qual é sua estação favorita?",
      "resposta": [
        "Primavera",
        "Verão",
        "Outono",
        "Inverno",
      ]
    },
    {
      "texto": "Qual é o seu Amigo favorito?",
      "resposta": [
        "Luan",
        "Luan Dantas",
        "Luan Andrade",
        "EU",
      ]
    },
  ];

  void _responder() {
    setState(() {
      _perguntaSelecionada++;
    });
    print(_perguntaSelecionada);
  }

  void _zerarVariavel() {
    setState(() {
      _perguntaSelecionada = 0;
    });
  }

  bool get temPerguntasSelecionadas {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Perguntas"),
          centerTitle: true,
          actions: <Widget>[
            //
            //
            Resetar(_zerarVariavel),
            //
            //
            //AdicionarResposta(_adiconarRespostaLista),
          ],
        ),
        body: temPerguntasSelecionadas
            ? Questionario(
                perguntas: _perguntas,
                perguntaSelecionada: _perguntaSelecionada,
                responder: _responder)
            //
            //
            : Resultado(),
        //
        //
        backgroundColor: Colors.blueGrey[300],
      ),
    );
  }
}

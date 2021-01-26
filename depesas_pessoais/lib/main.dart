import 'dart:io';
import 'dart:math';

import 'package:depesas_pessoais/components/chart.dart';
import 'package:depesas_pessoais/components/transaction_form.dart';
import 'package:flutter/material.dart';

import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() {
  runApp(
    ExpensesApp(),
  );
}

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        primaryColor: Colors.grey,
        accentColor: Colors.grey,
        fontFamily: 'Roboto',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //
  //
  bool _showChart = false;
  //
  //
  final List<Transaction> _transaction = [
    Transaction(
      id: Random().nextDouble().toString(),
      title: "Bola",
      value: 50.66,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "carro",
      value: 500.66,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "Bila",
      value: 00.66,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "Folhas",
      value: 50.00,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "Frutas",
      value: 150.66,
      date: DateTime.now(),
    ),
    Transaction(
      id: Random().nextDouble().toString(),
      title: "Carne",
      value: 80.66,
      date: DateTime.now(),
    ),
  ];
  //
  //

  List<Transaction> get _recentTransaction {
    return _transaction.where((tr) {
      return tr.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }
  //
  //

  void _addTransaction(String text, double number, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: text,
      value: number,
      date: date,
    );
    // print(newTransaction.id);
    setState(
      () {
        _transaction.add(newTransaction);
      },
    );
    Navigator.of(context).pop();
  }

  //
  //
  void _removeTransaction(int index) {
    setState(() {
      _transaction.removeAt(index);
    });
  }
  //
  //

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }
  //
  //

  @override
  Widget build(BuildContext context) {
    //
    //
    bool _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    //
    //
    if (!_isLandscape) {
      _showChart = false;
    }

    //
    //
    double escalaTexto = MediaQuery.of(context).textScaleFactor;
    //
    //
    final appBar = AppBar(
      actions: <Widget>[
        if (_isLandscape)
          IconButton(
            tooltip: "Alternar",
            icon: Icon(
              _showChart ? Icons.list : Icons.show_chart,
              color: Colors.white,
              textDirection: TextDirection.ltr,
            ),
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
          ),
        if (!_isLandscape)
          IconButton(
            icon: Icon(
              Icons.add_box,
              color: Colors.white,
            ),
            onPressed: () {
              _openTransactionFormModal(context);
            },
          ),
      ],
      //
      title: FittedBox(
        child: Text(
          "Despesas Pessoais",
          style: TextStyle(fontSize: 25 * escalaTexto),
        ),
      ),
      centerTitle: true,
      titleSpacing: 50,
    );
    //
    //
    double width = MediaQuery.of(context).size.width;
    //
    //
    double height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    //
    //
    return SafeArea(
      child: Scaffold(
        //
        //
        appBar: appBar,
        //
        //
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //
              // //
              // if (_isLandscape)
              //   SizedBox(
              //     height: height * 0.025,
              //   ),

              // FlatButton(
              //               onPressed: _newScreen,
              //               child: imagens[index],
              //             ),

              // //
              // //
              // if (_isLandscape)
              //   Container(
              //     height: height * 0.1,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceAround,
              //       children: <Widget>[
              //         Text("Exibir Gráfico"),
              //         Switch(
              //             value: _showChart,
              //             onChanged: (value) {
              //               setState(() {
              //                 _showChart = value;
              //               });
              //             }),
              //       ],
              //     ),
              //   ),
              // //
              // //
              // if (_isLandscape)
              //   SizedBox(
              //     height: height * 0.025,
              //   ),

              // //
              // //

              if (_showChart || !_isLandscape)
                Container(
                  height: height * (_isLandscape ? 0.8 : 0.3),
                  child: Chart(
                    _recentTransaction,
                  ),
                ),

              //
              //
              if (!_showChart || !_isLandscape)
                Container(
                  height: height * (_isLandscape ? 1 : 0.7),
                  child: TransactionList(
                    _transaction,
                    _removeTransaction,
                  ),
                ),
              //
              //
            ],
          ),
        ),
        //
        //

        floatingActionButton: _isLandscape
            ? null
            : FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  _openTransactionFormModal(context);
                },
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}




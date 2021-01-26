import 'package:depesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final void Function(int) onRemove;

  TransactionList(
    this.transaction,
    this.onRemove,
  );

  @override
  Widget build(BuildContext context) {
    bool _isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    if (transaction.isEmpty) {
      
      return LayoutBuilder(
        builder: (context, constraints) {
          double height = constraints.maxHeight;
          double width = constraints.maxWidth;
          return Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: height * 0.1,
                child: FittedBox(
                  child: Text(
                    "Nem uma Transação Cadastrada!",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Container(
                height: height * 0.7,
                child: Image.asset(
                  "assets/images/waiting.png",
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        },
      );
    } else {
      return ListView.builder(
        itemCount: transaction.length,
        itemBuilder: (constraints, index) {
          build(context);

          final tr = transaction[index];

          return Card(
            elevation: 2,
            child: Container(
              padding: EdgeInsets.only(left: 10),
              // color: Colors.red,
              height: 100,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double height = constraints.maxHeight;
                  double width = constraints.maxWidth;

                  return Row(
                    children: <Widget>[
                      //
                      //
                      Container(
                        width: _isLandscape ? width * 0.2 : width * 0.3,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey[500],
                            width: 2,
                          ),
                        ),
                        padding: EdgeInsets.all(5),
                        child: FittedBox(
                          child: Text(
                            "R\$ ${tr.value.toStringAsFixed(2)}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.grey[700]),
                          ),
                        ),
                      ),
                      //
                      //
                      Container(
                        // color: Colors.blue,
                        height: height,
                        width: _isLandscape ? width * 0.65 : width * 0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: height * 0.5,
                              child: FittedBox(
                                child: Text(
                                  "${tr.title}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                            Container(
                              height: height * 0.2,
                              child: FittedBox(
                                child: Text(
                                  DateFormat('dd/MM/y').format(tr.date),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Colors.grey),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //
                      //
                      Container(
                      // color: Colors.red,
                        height: height,
                        width: _isLandscape ? width * 0.125 : width * 0.125,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            IconButton(
                              iconSize: height * 0.3,
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                onRemove(index);
                              },
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      );
    }
  }
}

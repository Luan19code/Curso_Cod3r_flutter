import 'package:depesas_pessoais/components/chart_bar.dart';
import 'package:depesas_pessoais/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get grumpedTransactions {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        double totalSum = 0.0;

        for (var i = 0; i < recentTransaction.length; i++) {
          bool sameDay = recentTransaction[i].date.day == weekDay.day;
          bool sameMonth = recentTransaction[i].date.month == weekDay.month;
          bool sameYear = recentTransaction[i].date.year == weekDay.year;

          if (sameDay && sameMonth && sameYear) {
            totalSum += recentTransaction[i].value;
          }
        }

        // print(DateFormat.E().format(weekDay)[0]);
        // print(totalSum);

        return {
          'day': DateFormat.E().format(weekDay)[0],
          "value": totalSum,
        };
      },
    ).reversed.toList();
  }

  double get _weekTotalValue {
    return grumpedTransactions.fold(0.0, (sum, tr) {
      return sum + tr['value'];
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: grumpedTransactions.map((tr) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                label: tr["day"],
                value: tr["value"],
                percentage: _weekTotalValue == 0
                    ? 0
                    : (tr["value"] as double) / _weekTotalValue,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

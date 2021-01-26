import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  ChartBar({
    this.label,
    this.value,
    this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;

        return Column(
          children: <Widget>[
            Container(
              height: height * 0.1,
              child: FittedBox(
                child: Text(
                  "${value.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              height: height * 0.7,
              width: width * 0.3,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              height: height * 0.1,
              child: FittedBox(
                child: Text(
                  label,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

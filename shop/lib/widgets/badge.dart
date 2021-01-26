import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  //Bolinha com valor em cima do carrinho
  final Widget child;
  final String value;
  final Color color;
  final double positionedRight;
  final double positionedTop;

  const Badge({
    Key key,
    this.value,
    this.color,
    this.positionedRight,
    this.positionedTop,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: positionedRight == null ? 8 : positionedRight,
          top: positionedTop == null ? 8 : positionedTop,
          child: Container(
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color != null ? color : Theme.of(context).accentColor,
            ),
            constraints: BoxConstraints(minHeight: 16, minWidth: 16),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ),
      ],
    );
  }
}

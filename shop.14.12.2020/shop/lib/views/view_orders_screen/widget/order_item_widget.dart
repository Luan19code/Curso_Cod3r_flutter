import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop/providers/orders.dart';

class OrderWidget extends StatefulWidget {
  final Order order;

  const OrderWidget({Key key, this.order}) : super(key: key);

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text("R\$ ${widget.order.total}"),
            subtitle: Text(
              DateFormat(
                'dd /mm /yyyy hh:mm',
              ).format(
                widget.order.date,
              ),
            ),
            trailing: IconButton(
              icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
          ),
          if (_expanded)
            Container(
              height: (widget.order.products.length * 40.0) + 10,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: ListView(
                children: widget.order.products.map(
                  (product) {
                    return Column(
                      children: [
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              product.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              product.quantidade.toString() +
                                  "x R\$ " +
                                  product.price.toString(),
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ).toList(),
              ),
            )
        ],
      ),
    );
  }
}

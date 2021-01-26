import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/views/view_orders_screen/widget/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Orders orders = Provider.of(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meus Pedidos"),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: orders.itensCount,
          itemBuilder: (context, index) => OrderWidget(
            order: orders.ordersList[index],
          ),
        ),
        drawer: AppDrawer(),
      ),
    );
  }
}

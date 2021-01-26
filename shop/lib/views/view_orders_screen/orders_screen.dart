import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/views/view_orders_screen/widget/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Meus Pedidos"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).loadOrders(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Consumer<Orders>(
                builder: (context, orders, child) {
                  return ListView.builder(
                    itemCount: orders.itensCount,
                    itemBuilder: (context, index) => OrderWidget(
                      order: orders.ordersList[index],
                    ),
                  );
                },
              );
            }
          },
        ),
        //  isLoading
        //     ? Center(
        //         child: CircularProgressIndicator(),
        //       )
        //     : ListView.builder(
        //         itemCount: orders.itensCount,
        //         itemBuilder: (context, index) => OrderWidget(
        //           order: orders.ordersList[index],
        //         ),
        //       ),
        drawer: AppDrawer(),
      ),
    );
  }
}

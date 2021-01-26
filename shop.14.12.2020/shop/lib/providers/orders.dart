import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/providers/cart.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    this.id,
    this.total,
    this.products,
    this.date,
  });
}

class Orders with ChangeNotifier {
  List<Order> _listOrders = [];

  List<Order> get ordersList {
    return [..._listOrders];
  }

  int get itensCount {
    return _listOrders.length;
  }

  void addOrder(Cart cart) {
    _listOrders.insert(
      0,
      Order(
        id: Random().nextDouble().toString(),
        total: double.parse(cart.totalAmount.toStringAsFixed(2)),
        date: DateTime.now(),
        products: cart.itemsList.values.toList(),
      ),
    );
    notifyListeners();
  }
}

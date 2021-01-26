import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/utils/constants.dart';

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
  final String _baseUrl =
      "${Constants.Base_API_URL}//orders";

  List<Order> _listOrders = [];

  List<Order> get ordersList {
    return [..._listOrders];
  }

  int get itensCount {
    return _listOrders.length;
  }

  Future<String> addOrder(Cart cart) async {
    final date = DateTime.now();
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        //
        //
        final response = await http.post(
          "$_baseUrl.json",
          body: json.encode(
            {
              "total": double.parse(cart.totalAmount.toStringAsFixed(2)),
              "date": date.toIso8601String(),
              "products": cart.itemsList.values
                  .map((item) => {
                        "id": item.id,
                        "productId": item.product.id,
                        "title": item.title,
                        "quantidade": item.quantidade,
                        "price": item.price,
                      })
                  .toList(),
            },
          ),
        );

        //
        //

        _listOrders.insert(
          0,
          Order(
            id: jsonDecode(response.body)['name'],
            total: double.parse(cart.totalAmount.toStringAsFixed(2)),
            date: date,
            products: cart.itemsList.values.toList(),
          ),
        );

        notifyListeners();
      }
    } on SocketException catch (_) {
      return "Sem Conexão";
    }
    cart.clear();
  }

  Future<bool> loadOrders() async {
    List<Order> loadedItems = [];

    http.Response response;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
        response = await http.get(
          "$_baseUrl.json",
        );
        Map<String, dynamic> data = json.decode(response.body);

        loadedItems.clear();
        if (data != null) {
          data.forEach(
            (orderId, orderData) {
              loadedItems.add(
                Order(
                  id: orderId,
                  total: orderData["total"],
                  date: DateTime.parse(orderData["date"]),
                  products: (orderData["products"] as List<dynamic>).map(
                    (items) {
                      return CartItem(
                        id: items["id"],
                        title: items["title"],
                        quantidade: items["quantidade"],
                        price: items["price"],
                      );
                    },
                  ).toList(),
                ),
              );
            },
          );
          notifyListeners();
          _listOrders = loadedItems.reversed.toList();
        }
        return true;
      }
    } on SocketException catch (_) {
      // print('not connected');
      return false;
    }
  }
}

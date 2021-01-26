import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/providers/product.dart';

class CartItem {
  final String id;
  final Product product;
  final String title;
  final int quantidade;
  final double price;

  CartItem({
    @required this.id,
    @required this.product,
    @required this.title,
    @required this.quantidade,
    @required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get itemsList {
    return {..._items};
  }

  int get itemsCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantidade;
    });
    return total;
  }

  int contItem(Product product) {
    if (_items.containsKey(product.id)) {
      return _items[product.id].quantidade;
    }
  }

  void removeQuant(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingItem) {
        CartItem cart;

        cart = CartItem(
          id: existingItem.id,
          product: product,
          title: existingItem.title,
          quantidade:
              existingItem.quantidade <= 0 ? 0 : existingItem.quantidade - 1,
          price: existingItem.price,
        );

        return cart;
      });
      if (_items.containsKey(product.id) &&
          _items[product.id].quantidade <= 0) {
        _items.remove(product.id);
      }
    }
    notifyListeners();
  }

  void removeList(Product product) {
    if (_items.containsKey(product.id)) {
      _items.remove(product.id);
    }
    notifyListeners();
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(product.id, (existingItem) {
        return CartItem(
          id: existingItem.id,
          product: product,
          title: existingItem.title,
          quantidade: existingItem.quantidade + 1,
          price: existingItem.price,
        );
      });
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextDouble().toString(),
          title: product.title,
          product: product,
          quantidade: 1,
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

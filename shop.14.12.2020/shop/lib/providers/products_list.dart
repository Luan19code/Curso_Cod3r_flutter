import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = DUMMY_PRODUCTS;
  //
  //
  List<Product> get itemsList => [..._items];
  //
  //
  int get itemsCount {
    return _items.length;
  }

  //
  //
  List<Product> get itemsFavorite {
    return _items.where((pro) => pro.isFavorite).toList();
  }

  //
  //
  void showAll(Product product) {
    itemsFavorite.remove(product);
    notifyListeners();
  }

  //
  //
  void addProduct(Product newProduct) {
    _items.add(
      Product(
        id: Random().nextDouble().toString(),
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl,
      ),
    );
    notifyListeners();
  }

  void updateProduct(Product newProduct) {
    if (newProduct == null || newProduct.id == null) {
      return;
    }
    final index = _items.indexWhere((prod) => prod.id == newProduct.id);
    if (index >= 0) {
      _items[index] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items.removeWhere((proId) => proId.id == id);
      notifyListeners();
    }
  }

  //
  //
  void removeProduct(Product product) {
    _items.remove(product);
    notifyListeners();
  }
  //
  //
}
// bool _showFavoriteOnly = false;

// List<Product> get items {
//   if (_showFavoriteOnly) {
//     return _items.where((prod) => prod.isFavorite).toList();
//   }
//   return [..._items];
// }

// void showFavoriteOnly() {
//   _showFavoriteOnly = true;
//   notifyListeners();
// }

// void showAll() {
//   _showFavoriteOnly = false;
//   notifyListeners();
// }

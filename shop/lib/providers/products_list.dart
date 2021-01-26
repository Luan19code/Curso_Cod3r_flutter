import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/utils/constants.dart';

class Products with ChangeNotifier {
  final String _baseUrl = "${Constants.Base_API_URL}/products";
  //
  //
  List<Product> _items = [];
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
  Future<void> addProduct(Product newProduct) async {
    return http
        .post(
      "$_baseUrl.json",
      body: json.encode({
        "title": newProduct.title,
        "description": newProduct.description,
        "price": newProduct.price,
        "imageUrl": newProduct.imageUrl,
        "isFavorite": newProduct.isFavorite,
      }),
    )
        .then(
      (response) {
        _items.add(
          Product(
            id: jsonDecode(response.body)['name'],
            title: newProduct.title,
            description: newProduct.description,
            price: newProduct.price,
            imageUrl: newProduct.imageUrl,
          ),
        );
        notifyListeners();
      },
    );
  }

  Future<bool> loadProducts() async {
    http.Response response;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
        response = await http.get(
          "$_baseUrl.json",
        );

        Map<String, dynamic> data = json.decode(response.body);
        _items.clear();
        if (data != null) {
          data.forEach((productId, productData) {
            _items.add(
              Product(
                  id: productId,
                  title: productData['title'],
                  description: productData['description'],
                  price: productData['price'],
                  imageUrl: productData['imageUrl'],
                  isFavorite: productData['isFavorite']),
            );
          });
          notifyListeners();
        }
      }
      return true;
    } on SocketException catch (_) {
      // print('not connected');
      return false;
    }
  }

  Future<void> updateProduct(Product newProduct) async {
    if (newProduct == null || newProduct.id == null) {
      return;
    }
    final index = _items.indexWhere((prod) => prod.id == newProduct.id);
    if (index >= 0) {
      await http.patch(
        "$_baseUrl/${newProduct.id}.json",
        body: json.encode({
          "title": newProduct.title,
          "description": newProduct.description,
          "price": newProduct.price,
          "imageUrl": newProduct.imageUrl,
        }),
      );
      _items[index] = newProduct;
      notifyListeners();
    }
  }

  Future<String> deleteProduct(String id) async {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        "$_baseUrl/${product.id}.json",
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException("Ocorreu um erro na exclusão do produto");
      } else {
        return "Excluído com sucesso";
      }
    }
    return "";
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

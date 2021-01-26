import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop/utils/constants.dart';

class Product with ChangeNotifier {
  //
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<String> toggleFavorite() async {
    final String _baseUrl =
        "${Constants.Base_API_URL}/products";
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');

        this.isFavorite = !isFavorite;
        notifyListeners();

        try {} catch (e) {}

        final response = await http.patch(
          "$_baseUrl/${this.id}.json",
          body: json.encode({
            "isFavorite": this.isFavorite,
          }),
        );

        if (response.statusCode >= 400) {
          this.isFavorite = !isFavorite;
          notifyListeners();
          return "Ops... Houve algum problema";
        } else {
          if (this.isFavorite) {
            return "Marcado como favorito";
          } else {
            return "Desmarcado";
          }
        }
      }
    } on SocketException catch (_) {
      // print('not connected');
      return "Sem Conexão com Internet";
    }
    return "";
  }
}

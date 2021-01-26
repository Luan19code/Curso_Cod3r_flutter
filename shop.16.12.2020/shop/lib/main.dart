// import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/providers/products_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/views/view_cart/cart_screen.dart';
import 'package:shop/views/view_form_screen/product_form_screen.dart';
import 'package:shop/views/view_orders_screen/orders_screen.dart';
import 'package:shop/views/view_product_detail/product_detail_screen.dart';
import 'package:shop/views/view_home/products_overview_screen.dart';
import 'package:shop/views/view_products_screen/products_screen.dart';
// import 'package:http/http.dart' as http;

void main() {
  // http.post(
  //   "https://flutter-cod3r-972c7-default-rtdb.firebaseio.com/products.json",
  //   body: json.encode({
  //     "title": "Bola",
  //     "description": "bola de Futebol",
  //     "price": 100.68,
  //     "imageUrl":
  //         "https://cdn.pixabay.com/photo/2016/05/16/21/07/football-1396740__340.jpg",
  //     "isFavorite": true,
  //   }),
  // );
  //
  //
  // http.post(
  //   "https://flutter-cod3r-972c7-default-rtdb.firebaseio.com/products.json",
  //   body: json.encode({
  //     "title": "Kit Periféricos",
  //     "description": "Kit Periféricos Feminino",
  //     "price": 400.99,
  //     "imageUrl": "https://cdn.pixabay.com/photo/2017/05/11/11/15/workplace-2303851__340.jpg",
  //     "isFavorite": false,
  //   }),
  // );
  // //
  // //
  // http.post(
  //   "https://flutter-cod3r-972c7-default-rtdb.firebaseio.com/products.json",
  //   body: json.encode({
  //     "title": "Fone",
  //     "description": "Fone com fio",
  //     "price": 200.00,
  //     "imageUrl": "https://cdn.pixabay.com/photo/2016/11/29/09/08/headphone-1868612__340.jpg",
  //     "isFavorite": false,
  //   }),
  // );
  // //
  // //
  // http.post(
  //   "https://flutter-cod3r-972c7-default-rtdb.firebaseio.com/products.json",
  //   body: json.encode({
  //     "title": "mochila",
  //     "description": "mochila marron com preto",
  //     "price": 150.25,
  //     "imageUrl": "https://cdn.pixabay.com/photo/2016/11/19/14/56/backpack-1839705__340.jpg",
  //     "isFavorite": true,
  //   }),
  // );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => new Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => new Cart(),
        ),
        ChangeNotifierProvider(
          create: (context) => new Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato'),
        routes: {
          AppRoutes.HOME: (context) => ProductsOverviewScreen(),
          AppRoutes.PRODUCT_DETAIL: (context) => ProductDetailScreen(),
          AppRoutes.CART: (context) => CartScreen(),
          AppRoutes.ORDERS_SCREEN: (context) => OrdersScreen(),
          AppRoutes.PRODUCTS: (context) => ProductsScreen(),
          AppRoutes.PRODUCT_FORM: (context) => ProductFormScreen(),
        },
      ),
    );
  }
}

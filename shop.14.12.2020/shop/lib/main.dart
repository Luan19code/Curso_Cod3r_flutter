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

void main() => runApp(MyApp());

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

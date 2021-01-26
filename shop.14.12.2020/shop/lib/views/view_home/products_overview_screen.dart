import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/widgets/badge.dart';

import 'package:shop/views/view_home/widgets/product_grid.dart';

enum FilterOptions {
  Favorite,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Minha Loja"),
          centerTitle: true,
          
          actions: [
            
            PopupMenuButton(
              onSelected: (FilterOptions value) {
                if (value == FilterOptions.Favorite) {
                  setState(() {
                    _showFavoriteOnly = true;
                  });
                } else {
                  setState(() {
                    _showFavoriteOnly = false;
                  });
                }
              },
              itemBuilder: (_) => [
                PopupMenuItem(
                  child: Text("Somente Favoritos"),
                  value: FilterOptions.Favorite,
                ),
                PopupMenuItem(
                  child: Text("Todos"),
                  value: FilterOptions.All,
                ),
              ],
            ),
            Consumer<Cart>(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.CART,
                  );
                },
              ),
              builder: (context, cartValue, child) => Badge(
                value: cartValue.itemsCount.toString(),
                child: child,
              ),
            )
          ],
        ),
        body: ProductGrid(
          _showFavoriteOnly,
        ),
        drawer: AppDrawer(),
      ),
    );
  }
}

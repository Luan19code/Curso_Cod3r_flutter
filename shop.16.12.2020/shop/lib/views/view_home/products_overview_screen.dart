import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/products_list.dart';
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
  bool _isLoading = true;
  bool _isOnOff = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _refreshProducts(BuildContext context) async {
    return Provider.of<Products>(context, listen: false)
        .loadProducts()
        .then((value) {
      setState(() {
        _isOnOff = value;
        _isLoading = false;

        // _isLoading = false;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<Products>(context, listen: false).loadProducts().then((value) {
      setState(() {
        _isOnOff = value;
        print(value);
        print("Finalizai o _isLoading");
        _isLoading = false;
      });
    });

    //Carregar dados do back
  }

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
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _isOnOff
                ? ProductGrid(
                    _showFavoriteOnly,
                  )
                : AlertDialog(
                    title: Text("Aviso"),
                    content: Text("Sem Conexão com a internet"),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                            _refreshProducts(context);
                          });
                        },
                        child: Text("Tentar Novamente"),
                      ),
                    ],
                  ),
        drawer: AppDrawer(),
      ),
    );
  }
}


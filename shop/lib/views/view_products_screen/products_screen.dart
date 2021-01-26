import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/app_drawer.dart';
import 'package:shop/views/view_products_screen/widget/product_item.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    return Provider.of<Products>(context, listen: false).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final Products products = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Gerenciar Produtos"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(
              AppRoutes.PRODUCT_FORM,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: products.itemsCount,
              itemBuilder: (context, index) => Column(
                    children: [
                      ProductItem(
                        product: products.itemsList[index],
                      ),
                      Divider(),
                    ],
                  )),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}

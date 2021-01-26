import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products_list.dart';
import 'package:shop/utils/screen_size.dart';
import 'package:shop/views/view_home/widgets/product_grid_item.dart';

class ProductGrid extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProductGrid(this.showFavoriteOnly);

  @override
  Widget build(BuildContext context) {
    print(screenHeightAndWidth(context));
    //
    //
    // final List<Product> leadedProducts =
    //   Provider.of<Products>(context).items;
    final productsProvider = Provider.of<Products>(context);

    final products = showFavoriteOnly
        ? productsProvider.itemsFavorite
        : productsProvider.itemsList;
    //
    //
    return GridView.builder(
      padding: EdgeInsets.all(screenHeightAndWidth(context) * 0.01),
      itemCount: products.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: products[index],
          child: ProductGridItem(),
        );
      },
    );
  }
}

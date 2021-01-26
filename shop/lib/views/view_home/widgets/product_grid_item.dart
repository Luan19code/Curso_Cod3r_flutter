import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/screen_size.dart';
import 'package:shop/widgets/badge.dart';
import 'package:shop/widgets/snack_bar_widget.dart';

class ProductGridItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    final Products products = Provider.of(context, listen: false);
    final Cart cart = Provider.of(context, listen: true);
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        screenHeightAndWidth(context) * 0.01,
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.blueAccent,
          ),
        ),
        child: GridTile(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.PRODUCT_DETAIL,
                arguments: product,
              );
              //
              //
              // Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => ProductDetailScreen(
              //     product: product,
              //   ),
              // ));
            },
            child:
                // Column(
                //   children: <Widget>[
                //     SizedBox(
                //       height: 30,
                //     ),
                //     Text(
                //       "25,88",
                //       style: TextStyle(
                //         fontSize: 40,
                //       ),
                //     ),
                //   ],
                // ),
                Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
              semanticLabel: product.title,
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : Column(
                        children: <Widget>[
                          Text("Carregando..."),
                          Divider(),
                          Center(
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      );
              },
            ),
          ),
          //
          //
          footer: GridTileBar(
            subtitle: Expanded(
              child: FittedBox(
                child: Text(
                  "R\$ ${product.price}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            //
            //
            backgroundColor: Colors.black87,
            //
            //
            leading: Consumer<Product>(
              child: Text("Nunca Muda"),
              builder: (context, product, _) => IconButton(
                tooltip: "Favoritar",
                iconSize: screenHeightAndWidth(context) * 0.02,
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                ),
                onPressed: () {
                  product.toggleFavorite().then((value) {
                    scaffold.hideCurrentSnackBar();
                    scaffold.showSnackBar(
                      SnackBar(
                        content: Text(
                          value.toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  });

                  products.showAll(product);
                },
                color: Theme.of(context).accentColor,
              ),
            ),
            //
            //
            title: Expanded(
              child: FittedBox(
                child: Text(
                  product.title,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
            //
            //
            trailing: Badge(
              positionedRight: 5,
              positionedTop: 5,
              value: cart.contItem(product) != null
                  ? cart.contItem(product).toString()
                  : "0",
              color: Colors.white,
              child: InkWell(
                onLongPress: () {
                  if (cart.itemsCount > 0) {
                    showToast(context,
                        function: cart.addItem,
                        product: product,
                        text: "Item removido do carrinho");
                  }
                  cart.removeQuant(product);
                },
                child: IconButton(
                  iconSize: screenHeightAndWidth(context) * 0.02,
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    //
                    cart.addItem(product);
                    //
                    showToast(context,
                        function: cart.removeQuant,
                        product: product,
                        text: "Item adicionado do carrinho");
                  },
                  color: Theme.of(context).accentColor,
                ),
              ),
            ),
            //
            //
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products_list.dart';
import 'package:shop/utils/app_routes.dart';
// import 'package:shop/widgets/snack_bar_widget.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);

    return Container(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(
            product.imageUrl,
          ),
        ),
        title: Text(product.title),
        trailing: Container(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.PRODUCT_FORM,
                    arguments: product,
                  );
                },
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  return showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Apagar"),
                      content: Text("Deseja realmente apagar esse Produto?"),
                      actions: [
                        FlatButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(
                              "Não",
                              style: TextStyle(fontSize: 20),
                            )),
                        FlatButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: Text(
                              "Sim",
                              style: TextStyle(fontSize: 20),
                            )),
                      ],
                    ),
                  ).then((value) async {
                    if (value) {
                      try {
                        await Provider.of<Products>(context, listen: false)
                            .deleteProduct(product.id)
                            .then((value) {
                          scaffold.showSnackBar(
                            SnackBar(
                              content: Text(
                                value,
                              ),
                            ),
                          );
                        });
                      } catch (erro) {
                        scaffold.showSnackBar(
                          SnackBar(
                            content: Text(
                              erro.toString(),
                            ),
                          ),
                        );
                      }
                    }
                  });
                },
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

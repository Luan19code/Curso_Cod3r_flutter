import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/product.dart';
import 'package:shop/providers/products_list.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/show_dialog_global.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  showDialogGlobal(context, "Apagar",
                      "Deseja realmente apagar esse Produto?", [
                    FlatButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: Text("Não")),
                    FlatButton(
                        onPressed: () =>  Navigator.of(context).pop(true),
                        child: Text("Sim")),
                  ]).then((value) {
                    if (value) {
                      Provider.of<Products>(context, listen: false)
                          .deleteProduct(product.id);
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

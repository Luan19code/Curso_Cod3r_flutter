import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  //Gerar desliza em um container, usado para aqui para apagar algo
  final CartItem cartItem;

  const CartItemWidget({Key key, this.cartItem}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);

    return Container(
      child: Dismissible(
        key: ValueKey(cartItem.id),
        background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete_forever,
            color: Colors.white,
            size: 40,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
        ),
        direction: DismissDirection.endToStart,
        confirmDismiss: (_) {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Tem certeza?"),
                content: Text("Quer remover o item do carrinho?"),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                    child: Text("Não"),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text("Sim"),
                  ),
                ],
              );
            },
          );
        },
        onDismissed: (_) => cart.removeList(cartItem.product),
        child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: FittedBox(
                    child: Text("${cartItem.price.toStringAsFixed(2)} "),
                  ),
                ),
              ),
              title: Text(
                cartItem.title,
              ),
              subtitle: Text(
                "Total: R\$${(cartItem.price * cartItem.quantidade).toStringAsFixed(2)}",
              ),
              trailing: Container(
                width: 115,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => cart.removeQuant(cartItem.product),
                      child: Text(
                        "-",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    CircleAvatar(child: Text("${cartItem.quantidade}")),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () => cart.addItem(cartItem.product),
                      child: Text(
                        "+",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

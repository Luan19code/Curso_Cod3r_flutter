import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/utils/screen_size.dart';
import 'package:shop/views/view_cart/widget/cart_item_widget.dart';
import 'package:shop/widgets/show_dialog_global.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final Orders orders = Provider.of(context);
    final cartItems = cart.itemsList.values.toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              cart.clear();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(12),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      "R\$ ${cart.totalAmount.toStringAsFixed(2)}",
                      style: TextStyle(
                        color: Theme.of(context).primaryTextTheme.button.color,
                      ),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  Spacer(),
                  FlatButton(
                    child: Text("COMPRAR"),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: () {
                      if (cart.totalAmount > 0) {
                        orders.addOrder(cart);
                        cart.clear();
                      } else {
                        showDialogGlobal(
                          context,
                          "Aviso",
                          "Adicione 1 item ao carrinho",
                          [
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                "Ok",
                                style: TextStyle(
                                  fontSize: screenHeight(context) * 0.025,
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cart.itemsCount,
            itemBuilder: (context, index) => CartItemWidget(
              cartItem: cartItems[index],
            ),
          )),
        ],
      ),
    );
  }
}

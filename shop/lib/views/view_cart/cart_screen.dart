import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart.dart';
import 'package:shop/providers/orders.dart';
import 'package:shop/views/view_cart/widget/cart_item_widget.dart';

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
                  OrderButton(cart: cart, orders: orders),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
    @required this.orders,
  }) : super(key: key);

  final Cart cart;
  final Orders orders;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: CircularProgressIndicator(),
        )
        : FlatButton(
            child: Text("COMPRAR"),
            textColor: Theme.of(context).primaryColor,
            onPressed: widget.cart.totalAmount <= 0
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });

                    await widget.orders.addOrder(widget.cart);

                    setState(() {
                      _isLoading = false;
                    });
                    // cart.clear();
                  },
          );
  }
}

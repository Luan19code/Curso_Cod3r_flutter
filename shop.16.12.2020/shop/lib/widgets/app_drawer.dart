import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  //Barra lateral conhecida como drawer
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("Bem vindo Usuário"),
            centerTitle: true,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text("Loja"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text("Pedidos"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.ORDERS_SCREEN);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.edit),
            title: Text("Gerenciar Produtos"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.PRODUCTS);
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}

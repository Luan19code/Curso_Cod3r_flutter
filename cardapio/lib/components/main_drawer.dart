import 'package:cardapio/screens/settings_screen.dart';
import 'package:cardapio/utils/app_routes.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  Widget _createItem(IconData icon, String label, Function onTap) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        label,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold),
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              height: 56,
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: FittedBox(
                child: Center(
                  child: Container(
                    child: Text(
                      "Vamos Cozinhar",
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 30,
                          color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
              color: Theme.of(context).accentColor,
            ),
            SizedBox(
              height: 10,
            ),
            _createItem(
              Icons.restaurant,
              "Refeições",
              () => Navigator.of(context).pushReplacementNamed(AppRoutes.HOME),
            ),
            _createItem(
              Icons.settings,
              "Configurações",
              () => Navigator.of(context)
                  .pushReplacementNamed(AppRoutes.SETTINGS),
            ),
          ],
        ),
      ),
    );
  }
}

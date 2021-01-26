import 'package:flutter/material.dart';
import 'package:shop/providers/product.dart';

void showToast(BuildContext context, void Function(Product) function,
    {Product product, String text}) {
  //Evitar que a snack fique uma em cima da outra
  Scaffold.of(context).hideCurrentSnackBar();
  //
  //
  Scaffold.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 1),
      content: Text(
        text,
        textAlign: TextAlign.center,
      ),
      action: SnackBarAction(
          label: 'Desfazer',
          onPressed: () {
            // caffold.hideCurrentSnackBar;
            function(product);
          }),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:shop/utils/screen_size.dart';

Future<bool> showDialogGlobal(
  BuildContext context,
  String textTitle,
  String textContent,
  List<Widget> textActions,
) {
 return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      // retorna um objeto do tipo Dialog
      return AlertDialog(
        title: Text(
          textTitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: screenHeight(context) * 0.03),
        ),
        content: Text(
          textContent,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: screenHeight(context) * 0.02),
        ),
        actions: [
          Container(
              width: screenWidth(context),
              height: screenHeight(context) * 0.05,
              // color: Colors.blue,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: textActions))
        ],
        elevation: 24.0,
      );
    },
  );
}

import 'package:flutter/material.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double screenHeightAndWidth(BuildContext context) {
  return MediaQuery.of(context).size.height + MediaQuery.of(context).size.width;
}

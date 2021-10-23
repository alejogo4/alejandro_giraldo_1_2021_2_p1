import 'package:flutter/cupertino.dart';

class GlobalSize {
  static double width = 0;
  static double heigth = 0;
  static initSize(BuildContext context) {
    heigth = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScreenSizeHelper {
  static double mobileScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double mobileScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}

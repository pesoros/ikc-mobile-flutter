import 'package:flutter/material.dart';

class CustomColor {
  static Color whiteColor = Color(0xffFCFCFC);
  static Color blackColor = Color(0xff101010);
}

class CustomSize {
  static double defaultTextSize = 24;
}

class CustomFont {
  static TextStyle notificationTextStyle = TextStyle(
    fontSize: 24,
    color: CustomColor.whiteColor,
  );
  static TextStyle contentTextStyle = TextStyle(
    fontSize: 16,
    color: CustomColor.blackColor,
  );
  static TextStyle boldTextStyle = TextStyle(
    fontSize: 16,
    color: CustomColor.blackColor,
    fontWeight: FontWeight.bold,
  );
}

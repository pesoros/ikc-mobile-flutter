import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomColor {
  static Color whiteColor = Color(0xffEDF2F6);
  static Color blackColor = Color(0xff494953);
  static Color redColor = Color(0xffFF5656);
  static Color blueColor = Color(0xff6A7EFC);
  static Color greenColor = Color.fromARGB(255, 31, 214, 31);
}

class CustomData {
  static String adUnitId = (Platform.isAndroid && kDebugMode)
      ? 'ca-app-pub-3940256099942544/5224354917'
      : (Platform.isIOS && kDebugMode)
          ? 'ca-app-pub-3940256099942544/1712485313'
          : (Platform.isAndroid && !kDebugMode)
              ? "ca-app-pub-8287187411389593/9871616356"
              : (Platform.isIOS && !kDebugMode)
                  ? "ca-app-pub-8287187411389593/4688159169"
                  : "";
  static String geoCode = '74096582084952121916x15584';
}

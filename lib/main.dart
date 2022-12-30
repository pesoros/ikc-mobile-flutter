import 'package:flutter/material.dart';
import 'package:ikc_mobile_flutter/home.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
        child: MaterialApp(
      title: 'Indonesian KTP Checker',
      home: Home(),
    ));
  }
}

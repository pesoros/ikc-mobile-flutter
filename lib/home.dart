import 'package:flutter/material.dart';
import 'package:ikc_mobile_flutter/detail.dart';
import 'package:ikc_mobile_flutter/global.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:overlay_support/overlay_support.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController identityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: CustomColor.whiteColor,
        body: SingleChildScrollView(
          reverse: true,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          "Cek KTP!",
                          style: TextStyle(
                            fontSize: CustomSize.defaultTextSize * 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: identityController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          fontSize: CustomSize.defaultTextSize,
                          color: CustomColor.blackColor),
                      decoration: InputDecoration(
                        hintText: "Nomor KTP",
                        contentPadding: EdgeInsets.symmetric(horizontal: 40),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.blackColor),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CustomColor.blackColor),
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 40),
                          height: 60,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "CEK",
                                style: TextStyle(
                                    fontSize: CustomSize.defaultTextSize,
                                    color: CustomColor.blackColor),
                              ),
                            ],
                          )),
                      hoverColor: CustomColor.blackColor,
                      onTap: () async {
                        if (identityController.text.isEmpty) {
                          showSimpleNotification(
                            Text(
                              "Isi nomor KTP terlebih dahulu!",
                              style: CustomFont.notificationTextStyle,
                            ),
                            background: CustomColor.blackColor,
                            elevation: 0,
                          );
                        } else {
                          FocusManager.instance.primaryFocus?.unfocus();
                          goToDetail();
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToDetail() async {
    var x = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail(
          id: identityController.text,
        ),
      ),
    );
    if (x != null) {
      showSimpleNotification(
        Text(
          "Data tidak ditemukan.",
          style: CustomFont.notificationTextStyle,
        ),
        background: CustomColor.blackColor,
        elevation: 0,
      );
    }
  }
}

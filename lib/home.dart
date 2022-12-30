import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glass/glass.dart';
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
  bool _passwordVisible = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController identityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.height,
                //   width: MediaQuery.of(context).size.width,
                //   child: Image.asset(
                //     "assets/background.jpeg",
                //     fit: BoxFit.cover,
                //   ),
                // ),
                Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: CustomColor.blackColor),
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                ).asGlass(
                  tintColor: Colors.transparent,
                  frosted: false,
                  blurX: 2,
                  blurY: 2,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Indonesia\nKTP\nChecker",
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                              color: CustomColor.whiteColor,
                            ),
                          ),
                          SizedBox(height: 20),
                          CupertinoTextField(
                            controller: nameController,
                            placeholder: "Name (Optional)",
                            placeholderStyle:
                                TextStyle(color: CustomColor.blackColor),
                            padding: EdgeInsets.all(20),
                            style: TextStyle(color: CustomColor.blackColor),
                            prefix: Padding(
                                padding: EdgeInsets.only(left: 20),
                                child: Icon(Icons.person)),
                            keyboardType: TextInputType.text,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: CustomColor.whiteColor),
                          ),
                          SizedBox(height: 20),
                          CupertinoTextField(
                            controller: identityController,
                            placeholder: "Identity Number",
                            placeholderStyle:
                                TextStyle(color: CustomColor.blackColor),
                            padding: EdgeInsets.all(20),
                            style: TextStyle(color: CustomColor.blackColor),
                            prefix: Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(Icons.credit_card),
                            ),
                            keyboardType: TextInputType.text,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: CustomColor.whiteColor),
                            obscureText: !_passwordVisible,
                            suffix: InkWell(
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                ),
                                onTap: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                }),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            height: 55,
                            width: MediaQuery.of(context).size.width,
                            child: CupertinoButton(
                              child: Text("Login"),
                              color: CustomColor.redColor,
                              borderRadius: BorderRadius.circular(20),
                              onPressed: () async {
                                if (identityController.text.isEmpty) {
                                  showSimpleNotification(
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      margin: EdgeInsets.only(
                                          top: 10, left: 5, right: 5),
                                      decoration: BoxDecoration(
                                        color: CustomColor.redColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text("Fill Identity First!"),
                                    ),
                                    background: Colors.transparent,
                                    elevation: 0,
                                    slideDismissDirection:
                                        DismissDirection.horizontal,
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Detail(
                                        id: identityController.text,
                                        name: (nameController.text.isEmpty)
                                            ? "Untitled"
                                            : nameController.text,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

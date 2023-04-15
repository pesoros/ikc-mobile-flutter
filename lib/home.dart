import 'package:flutter/cupertino.dart';
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
  bool _passwordVisible = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController identityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: Scaffold(
        body: SingleChildScrollView(
          reverse: true,
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).viewInsets.bottom,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      alignment: Alignment.topCenter,
                      image: AssetImage("assets/gradient-background.png"),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      (MediaQuery.of(context).viewInsets.bottom == 0)
                          ? Column(
                              children: [
                                SizedBox(height: 40),
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color:
                                        CustomColor.whiteColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Image.asset(
                                    "assets/ktp-checker-transparent-background.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  "Cek KTP!",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Cek Kartu Tanda Penduduk (KTP)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                SizedBox(height: 40),
                                Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: CustomColor.whiteColor
                                            .withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      child: Image.asset(
                                        "assets/ktp-checker-transparent-background.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Cek KTP!",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            "Cek Kartu Tanda Penduduk (KTP)",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoTextField(
                            controller: nameController,
                            placeholder: "Nama (Opsional)",
                            placeholderStyle: TextStyle(color: Colors.grey),
                            padding: EdgeInsets.all(20),
                            style: TextStyle(color: Colors.grey),
                            keyboardType: TextInputType.text,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: CustomColor.whiteColor),
                          ),
                          SizedBox(height: 20),
                          CupertinoTextField(
                            controller: identityController,
                            placeholder: "Nomor KTP",
                            placeholderStyle: TextStyle(color: Colors.grey),
                            padding: EdgeInsets.all(20),
                            style: TextStyle(color: Colors.grey),
                            keyboardType: TextInputType.number,
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
                              child: Text("Cek"),
                              color: Colors.black,
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
                                      child: Text(
                                          "Isi nomor KTP terlebih dahulu!"),
                                    ),
                                    background: Colors.transparent,
                                    elevation: 0,
                                    slideDismissDirection:
                                        DismissDirection.horizontal,
                                  );
                                } else {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  goToDetail();
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

  void goToDetail() async {
    var x = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Detail(
          id: identityController.text,
          name: (nameController.text.isEmpty)
              ? "Tanpa Nama"
              : nameController.text,
        ),
      ),
    );
    if (x != null) {
      showSimpleNotification(
        Container(
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.only(top: 10, left: 5, right: 5),
          decoration: BoxDecoration(
            color: CustomColor.redColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text("Data tidak ditemukan."),
        ),
        background: Colors.transparent,
        elevation: 0,
        slideDismissDirection: DismissDirection.horizontal,
      );
    }
  }
}

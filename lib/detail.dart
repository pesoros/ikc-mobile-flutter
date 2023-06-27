// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikc_mobile_flutter/global.dart';
import 'package:nik_validator/nik_validator.dart';

class Detail extends StatefulWidget {
  Detail({Key? key, required this.id}) : super(key: key);
  String id;

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  bool isLoad = true;
  String? nik;
  String? uniqueCode;
  String? gender;
  String? bornDate;
  int? age;
  String? nextBirthday;
  String? zodiac;
  String? province;
  String? city;
  String? subdistrict;
  String? postalCode;

  getData(wid) async {
    NIKModel result = await NIKValidator.instance.parse(nik: wid);
    if (result.valid!) {
      if (!mounted) return;
      setState(() {
        nik = result.nik;
        uniqueCode = result.uniqueCode;
        gender = result.gender;
        bornDate = result.bornDate;
        age = result.ageYear;
        nextBirthday = result.nextBirthday;
        zodiac = result.zodiac;
        province = result.province;
        city = result.city;
        subdistrict = result.subdistrict;
        postalCode = result.postalCode;
      });
      if (!mounted) return;
      setState(() {
        isLoad = false;
      });
    } else {
      Navigator.pop(context, "xxx");
    }
  }

  @override
  void initState() {
    getData(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isLoad)
          ? Center(child: CupertinoActivityIndicator())
          : SafeArea(
              child: Column(
                children: [
                  InkWell(
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "KEMBALI",
                              style: TextStyle(
                                  fontSize: CustomSize.defaultTextSize,
                                  color: CustomColor.blackColor),
                            ),
                          ],
                        )),
                    hoverColor: CustomColor.blackColor,
                    onTap: () => Navigator.pop(context),
                  ),
                  Divider(
                    color: Colors.black,
                    height: 1,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        row('NO. KTP ', '$nik'),
                        row('KELAMIN ', '$gender'),
                        row('TGL. LAHIR ', '$bornDate'),
                        row('UMUR ', '$age'),
                        row('ZODIAK ', '$zodiac'),
                        row('PROVINSI ', '$province'),
                        row('KOTA ', '$city'),
                        row('KECAMATAN ', '$subdistrict'),
                        row('KODE POS ', '$postalCode'),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }

  row(String title, content) {
    return Column(
      children: [
        SizedBox(height: 20),
        Row(
          children: [
            Text(
              title,
              style: CustomFont.contentTextStyle,
            ),
            Text(
              content,
              style: CustomFont.boldTextStyle,
            ),
          ],
        ),
      ],
    );
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

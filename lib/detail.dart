// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ikc_mobile_flutter/global.dart';
import 'package:latlng/latlng.dart';
import 'package:nik_validator/nik_validator.dart';
import 'package:map/map.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  Detail({Key? key, required this.id, required this.name}) : super(key: key);
  String id;
  String name;

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
  var controller;

  getData(wid) async {
    if (!mounted) return;
    NIKModel result = await NIKValidator.instance.parse(nik: wid);
    if (result.valid!) {
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
      String web = "https://geocode.xyz";
      Uri url = Uri.parse(web);
      var request = await http.post(url, body: {
        "scantext": city,
        "json": "1",
        "auth": "837135782256818673161x88653",
      });
      var res = jsonDecode(request.body);
      setState(() {
        controller = MapController(
          location:
              LatLng(double.parse(res['latt']), double.parse(res['longt'])),
          zoom: 10,
        );
        isLoad = false;
      });
    } else {
      Navigator.pop(context);
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
          : Padding(
              padding: EdgeInsets.only(top: 60, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10, right: 10),
                            height: MediaQuery.of(context).size.width / 3.5,
                            width: MediaQuery.of(context).size.width / 3.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.red,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                  color: CustomColor.blueColor),
                              child: Icon(
                                Icons.done,
                                color: CustomColor.whiteColor,
                                size: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.grey[100],
                          ),
                          child: Icon(
                            Icons.clear,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                          child: Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 38,
                          color: CustomColor.blackColor,
                          fontWeight: FontWeight.w900,
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "$bornDate | $age Years",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          province!.toTitleCase() +
                              ", " +
                              city!.toTitleCase() +
                              ", " +
                              subdistrict!.toTitleCase() +
                              ", " +
                              postalCode!.toTitleCase(),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                          // maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: CustomColor.blueColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              zodiac.toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: CustomColor.whiteColor,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Text(
                              age.toString() + " Years",
                              style: TextStyle(
                                fontSize: 14,
                                color: CustomColor.blackColor,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: MapLayout(
                        controller: controller,
                        builder: (context, transformer) {
                          return TileLayer(
                            builder: (context, x, y, z) {
                              final tilesInZoom = pow(2.0, z).floor();

                              while (x < 0) {
                                x += tilesInZoom;
                              }
                              while (y < 0) {
                                y += tilesInZoom;
                              }

                              x %= tilesInZoom;
                              y %= tilesInZoom;

                              //Google Maps
                              final url =
                                  'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';

                              return Image.network(
                                url,
                                fit: BoxFit.cover,
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
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

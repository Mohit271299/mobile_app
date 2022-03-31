import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaishnav_parivar/screen/Auth/login.dart';
import 'package:vaishnav_parivar/utils/back_image.dart';
import 'package:vaishnav_parivar/utils/color_utils.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);

  @override
  _SelectLanguageState createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  updateLanguage(Locale locale) {
    Get.updateLocale(locale);
  }

  String english_body = 'Choose Language';
  String hindi_body = "भाषा पसंद करे";
  String gujarati_body = 'ભાષા પસંદ કરો';
  String hindi_button = 'आगल वधो';
  String gujarati_button = 'આગળ વધો';
  String english_button = 'Next';

  final List locale = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'हिंदी', 'locale': Locale('hi', 'IN')},
    {'name': 'ગુજરાતી', 'locale': Locale('gu', 'IN')},
  ];
  late double screenHeight, screenWidth;
  bool isEnglishSelect = false;
  bool isGujaratiSelect = false;
  bool isHindiSelect = false;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return back_image(
      body_container: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: screenHeight * 0.1,
            ),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0),
                child: Text(
                  (isEnglishSelect)
                      ? english_body.toString()
                      : (isGujaratiSelect)
                          ? gujarati_body
                          : (isHindiSelect)
                              ? hindi_body
                              : english_body,
                  style: TextStyle(
                    fontFamily: 'sf_normal',
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            InkWell(
              onTap: () {
                // updateLanguage(locale[0]['locale']);
                setState(() {
                  isEnglishSelect = true;
                  isHindiSelect = false;
                  isGujaratiSelect = false;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 100.0, right: 100.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  border: (isEnglishSelect == true)
                      ? Border.all(color: ColorUtils.primary)
                      : Border.all(color: Colors.white),
                ),
                height: screenHeight * 0.1,
                width: double.infinity,
                child: Text(
                  'English',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorUtils.primary,
                    fontSize: 20.0,
                    fontFamily: 'sf_normal',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            InkWell(
              onTap: () {
                // updateLanguage(locale[2]['locale']);
                setState(() {
                  isEnglishSelect = false;
                  isHindiSelect = false;
                  isGujaratiSelect = true;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 100.0, right: 100.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  border: (isGujaratiSelect == true)
                      ? Border.all(color: ColorUtils.primary)
                      : Border.all(color: Colors.white),
                ),
                height: screenHeight * 0.1,
                width: double.infinity,
                child: Text(
                  'Gujarati',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorUtils.primary,
                    fontSize: 20.0,
                    fontFamily: 'sf_normal',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            InkWell(
              onTap: () {
                // updateLanguage(locale[1]['locale']);
                setState(() {
                  isEnglishSelect = false;
                  isHindiSelect = true;
                  isGujaratiSelect = false;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 100.0, right: 100.0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  color: Colors.white,
                  border: (isHindiSelect == true)
                      ? Border.all(color: ColorUtils.primary)
                      : Border.all(color: Colors.white),
                ),
                height: screenHeight * 0.1,
                width: double.infinity,
                child: Text(
                  'Hindi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorUtils.primary,
                    fontSize: 20.0,
                    fontFamily: 'sf_normal',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.1,
            ),
            InkWell(
              onTap: () {
                if (isHindiSelect == true ||
                    isEnglishSelect == true ||
                    isGujaratiSelect == true) {
                  if (isHindiSelect == true) {
                    updateLanguage(locale[1]['locale']);
                  } else if (isGujaratiSelect == true) {
                    updateLanguage(locale[2]['locale']);
                  } else if (isEnglishSelect == true) {
                    updateLanguage(locale[0]['locale']);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const login_screen(),
                    ),
                  );
                }
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  height: 50.0,
                  width: 120,
                  decoration: BoxDecoration(
                    color: ColorUtils.primary,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        (isEnglishSelect)
                            ? english_button.toString()
                            : (isGujaratiSelect)
                                ? gujarati_button
                                : (isHindiSelect)
                                    ? hindi_button
                                    : english_button,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'sf_normal',
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Icon(
                        Icons.arrow_forward_sharp,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

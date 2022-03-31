import 'package:encrypted_app/appdetails.dart';
import 'package:encrypted_app/screen/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'common/common_color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppDetails.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
          appBarTheme: AppBarTheme(
            backgroundColor:  HexColor(CommonColor.appBackColor),
            elevation: 0,
          ),
        scaffoldBackgroundColor: HexColor(CommonColor.appBackColor)
      ),
      home: const SignIn(),
    );
  }
}

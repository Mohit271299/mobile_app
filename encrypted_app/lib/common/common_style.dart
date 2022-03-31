import 'package:encrypted_app/appdetails.dart';
import 'package:encrypted_app/common/common_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CommonStyle {
  headerStyle() => const TextStyle(
      fontFamily: AppDetails.fontGilroySemiBold,
      color: Colors.white,
      fontSize: 26);

  subTitleStyle() => TextStyle(
    overflow: TextOverflow.ellipsis,
        fontFamily: AppDetails.fontGilroyRegular,
        fontSize: 12.0,
        color: HexColor(CommonColor.fontColor),
      );
  TitleStyle() => TextStyle(
    overflow: TextOverflow.ellipsis,
        fontFamily: AppDetails.fontGilroySemiBold,
        fontSize: 24.0,
        color: Colors.white,
      );
}

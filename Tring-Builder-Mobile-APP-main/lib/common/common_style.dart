import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/AppDetails.dart';
import 'package:tring/common/common_color.dart';

headerStyle() => const TextStyle(
      fontFamily: AppDetails.fontBold,
      fontSize: 23.0,
    );

subHeaderStyle() => TextStyle(
    fontSize: 13.0,
    fontFamily: AppDetails.fontSemiBold,
    color: HexColor(CommonColor.subHeaderColor));

forgotPasswordStyle() => TextStyle(
    fontFamily: AppDetails.fontSemiBold,
    color: HexColor(CommonColor.appActiveColor),
    fontStyle: FontStyle.italic,
    fontSize: 10.0);

noteColor() => TextStyle(
    fontFamily: AppDetails.fontSemiBold,
    fontSize: 9.0,
    color: HexColor(CommonColor.subHeaderColor));

noteActiveColor() => TextStyle(
    fontFamily: AppDetails.fontSemiBold,
    fontSize: 9.0,
    color: HexColor(CommonColor.appActiveColor));

dontColor() => TextStyle(
    fontFamily: AppDetails.fontSemiBold,
    fontSize: 11.0,
    color: HexColor(CommonColor.subHeaderColor));

dontColorActive() => TextStyle(
    fontFamily: AppDetails.fontSemiBold,
    fontSize: 11.0,
    color: HexColor(CommonColor.appActiveColor));

titleStyle() => TextStyle(
      fontFamily: AppDetails.fontSemiBold,
      fontSize: 20.0,
      color: HexColor("#485056"),
    );

drawerStyle() => TextStyle(
    fontSize: 14.0,
    fontFamily: AppDetails.fontSemiBold,
    color: HexColor(CommonColor.drawerFontColor));

drawerSubHeaderStyle() => TextStyle(
      fontFamily: AppDetails.fontSemiBold,
      color: HexColor(CommonColor.drawerFontColor),
      fontSize: 12.0,
    );

dialogTitleStyle() => TextStyle(
      overflow: TextOverflow.ellipsis,
      fontFamily: AppDetails.fontSemiBold,
      fontSize: 17.0,
      color: Colors.black,
    );

dialogbuttonStyle() => TextStyle(
      color: HexColor(CommonColor.textDarkColor),
      fontSize: 13.0,
      fontFamily: AppDetails.fontSemiBold,
    );

screenHeader() => TextStyle(
      color: HexColor(CommonColor.textDarkColor),
      fontFamily: AppDetails.fontSemiBold,
      fontSize: 20.0,
      fontWeight: FontWeight.w700,
    );

cartIdDateStyle() => TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 11.0,
      fontFamily: AppDetails.fontMedium,
      color: HexColor(
        CommonColor.subHeaderColor,
      ),
    );

cartNameStyle({String textColor = CommonColor.textDarkColor}) => TextStyle(
      overflow: TextOverflow.ellipsis,
      fontFamily: AppDetails.fontSemiBold,
      color: HexColor(textColor),
      fontSize: 15.0,
    );

cartMobileNumberStyle() => TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 15.0,
      fontFamily: AppDetails.fontMedium,
      color: HexColor(CommonColor.subHeaderColor),
    );

cartBlockStyle() => TextStyle(
    fontFamily: AppDetails.fontMedium,
    fontSize: 10.0,
    color: HexColor(CommonColor.subHeaderColor));

screenSubheaderStyle() => TextStyle(
      fontSize: 12.0,
      fontFamily: AppDetails.fontSemiBold,
      color: HexColor(CommonColor.textDarkColor),
    );

linkTextStyle({double fontSizes = 14.0}) => TextStyle(
      overflow: TextOverflow.ellipsis,
      fontFamily: AppDetails.fontSemiBold,
      fontSize: fontSizes,
      color: HexColor(CommonColor.appActiveColor),
    );

estimateStyle() => TextStyle(
    overflow: TextOverflow.ellipsis,
    fontSize: 11.0,
    fontFamily: AppDetails.fontMedium,
    color: HexColor(CommonColor.subHeaderColor));

estimateLabelStyle() => TextStyle(
      overflow: TextOverflow.ellipsis,
      fontFamily: AppDetails.fontSemiBold,
      color: HexColor(CommonColor.textDarkColor),
      fontSize: 12.0,
    );

totalEstimateLabelStyle() => TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 14.0,
      fontFamily: AppDetails.fontSemiBold,
      color: HexColor(CommonColor.subHeaderColor),
    );

buttonTextStyle() => TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 15.0,
      fontFamily: AppDetails.fontSemiBold,
      color: Colors.white,
    );

salesdueStyle() => TextStyle(
      overflow: TextOverflow.ellipsis,
      fontSize: 10.0,
      fontFamily: AppDetails.fontSemiBold,
      color: HexColor(CommonColor.durColor),
    );

errorTextStyle() => TextStyle(
      overflow: TextOverflow.ellipsis,
      fontFamily: AppDetails.fontSemiBold,
      color: Colors.red,
      fontSize: 12.0,
    );

List<BoxShadow>? ContainerInnerShadow = [
  BoxShadow(
    color: HexColor(CommonColor.appActiveColor),
  ),
  const BoxShadow(
    color: Colors.white,
    spreadRadius: 0.0,
    blurRadius: 2,
  ),
];

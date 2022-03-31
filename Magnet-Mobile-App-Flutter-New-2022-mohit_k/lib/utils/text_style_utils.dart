import 'package:flutter/material.dart';

enum FWT {
  light,
  regular,
  medium,
  lightBold,
  semiBold,
  bold,
}

FontWeight? getFontSize(FWT fwt) {
  switch (fwt) {
    case FWT.light:
      return FontWeight.w200;
      // ignore: dead_code
      break;
    case FWT.regular:
      return FontWeight.w300;
      // ignore: dead_code
      break;
    case FWT.medium:
      return FontWeight.w400;
      // ignore: dead_code
      break;
    case FWT.lightBold:
      return FontWeight.w500;
      // ignore: dead_code
      break;
    case FWT.semiBold:
      return FontWeight.w600;
      // ignore: dead_code
      break;
    case FWT.bold:
      return FontWeight.w700;
      // ignore: dead_code
      break;
    default:
      return FontWeight.w200;
      // ignore: dead_code
      break;
  }
}

class FontStyleUtility {

  static TextStyle? h30({
    @required Color? fontColor,
    FWT fontWeight = FWT.regular,
  }) {
    return TextStyle(
      fontFamily: 'GR',
      color: fontColor,
      fontWeight: getFontSize(fontWeight),
      fontSize: 30,
    );
  }

  static TextStyle? h25({
    @required Color? fontColor,
    FWT fontWeight = FWT.regular,
  }) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight),
      fontSize: 25,
        fontFamily: 'GR'

    );
  }

  static TextStyle? h22({
    @required Color? fontColor,
    FWT fontWeight = FWT.regular,
  }) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight),
      fontSize: 22,      fontFamily: 'GR'

    );
  }
  static TextStyle? h23({
    @required Color? fontColor,
    FWT fontWeight = FWT.regular,
  }) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight),
      fontSize: 23,
        fontFamily: 'GR'

    );
  }

  static TextStyle? h20({
    @required Color? fontColor,
    FWT fontWeight = FWT.regular,
  }) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight),
      fontSize: 20,
        fontFamily:'GR'

    );
  }
  static TextStyle? h20B({
    @required Color? fontColor,
  }) {
    return TextStyle(
      color: fontColor,
      fontSize: 20,
        fontFamily:'Gilroy-Bold'
    );
  }

  static TextStyle? h18({@required Color? fontColor, FWT fontWeight = FWT.regular}) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight),
      fontSize: 18,
        fontFamily: 'GR'

    );
  }
  static TextStyle? h17({@required Color? fontColor, FWT fontWeight = FWT.regular}) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight),
      fontSize: 17,      fontFamily: 'GR'

    );
  }
  static TextStyle? h15({@required Color? fontColor, FWT? fontWeight}) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight!),
      fontSize: 15,
        fontFamily: 'GR'

    );
  }static TextStyle? h15B({@required Color? fontColor,}) {
    return TextStyle(
      color: fontColor,
      fontSize: 15,
        fontFamily: 'Gilroy-Bold'

    );
  }

  static TextStyle? h16({@required Color? fontColor, FWT fontWeight = FWT.regular}) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight),
      fontSize: 16,      fontFamily: 'GR'

    );
  }

  static TextStyle? h14({@required Color? fontColor, FWT fontWeight = FWT.regular}) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight),
      fontSize: 14,fontFamily: 'GR'
    );
  }

  static TextStyle? h13({@required Color? fontColor, FWT fontWeight = FWT.regular}) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight),
      fontSize: 13,
        fontFamily: 'GR'

    );
  }static TextStyle? h13B({@required Color? fontColor}) {
    return TextStyle(
      color: fontColor,
      fontSize: 13,
        fontFamily:'Gilroy-Bold'

    );
  }

  static TextStyle? h12({@required Color? fontColor, FWT? fontWeight}) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight!),
      fontSize: 12,
        fontFamily: 'GR'

    );
  }
  static TextStyle? h11({@required Color? fontColor, FWT fontWeight = FWT.regular}) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight),
      fontSize: 11,      fontFamily: 'GR'

    );
  }

  static TextStyle? h10({@required Color? fontColor, FWT fontWeight = FWT.regular}) {
    return TextStyle(
      color: fontColor,
      fontWeight: getFontSize(fontWeight),
      fontSize: 10,
        fontFamily: 'GR'

    );
  }
}

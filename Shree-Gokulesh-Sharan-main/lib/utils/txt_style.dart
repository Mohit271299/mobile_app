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

  static TextStyle? h24({@required Color? fontColor, @required FWT? fontWeight}) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontSize(fontWeight!),
        fontSize: 24,
        fontFamily: 'sf_normal'
    );
  }
  static TextStyle? h18({@required Color? fontColor, @required FWT? fontWeight}) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontSize(fontWeight!),
        fontSize: 18,
        fontFamily: 'sf_normal'
    );
  }static TextStyle? h16({@required Color? fontColor, @required FWT? fontWeight}) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontSize(fontWeight!),
        fontSize: 16,
        fontFamily: 'sf_normal'
    );
  }static TextStyle? h15({@required Color? fontColor, @required FWT? fontWeight}) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontSize(fontWeight!),
        fontSize: 15,
        fontFamily: 'sf_normal'
    );
  }
  static TextStyle? h14({@required Color? fontColor, @required FWT? fontWeight}) {
    return TextStyle(
        color: fontColor,
        fontWeight: getFontSize(fontWeight!),
        fontSize: 14,
        fontFamily: 'sf_normal'
    );
  }
  static TextStyle? h13({@required Color? fontColor, @required FWT? fontWeight}) {
      return TextStyle(
          color: fontColor,
          fontWeight: getFontSize(fontWeight!),
          fontSize: 13,
          fontFamily: 'sf_normal'
      );
    }static TextStyle? h12({@required Color? fontColor, @required FWT? fontWeight}) {
      return TextStyle(
          color: fontColor,
          fontWeight: getFontSize(fontWeight!),
          fontSize: 12,
          fontFamily: 'sf_normal'
      );
    }

}

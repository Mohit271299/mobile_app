// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

import '../utils/color_utils.dart';


class MyLeadingItemCustomButtonWidget extends StatelessWidget {
  final String? title;
  final String? leadingIcon;
  final String? trailingIcon;
  final VoidCallback? onTap;
  final Alignment? alignment;
  final Color? backGroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? height;
  final double? width;
  const MyLeadingItemCustomButtonWidget(
      {Key? key,
      this.title,
      this.leadingIcon,
      this.trailingIcon,
      this.onTap,
      this.alignment = Alignment.centerLeft,
      this.height,
      this.width,
      this.backGroundColor,
      this.borderColor,
      this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backGroundColor ?? ColorUtils.blueColor,
            border: Border.all(color: borderColor ?? ColorUtils.darkBlueColor)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                leadingIcon != null ?
                Row(
                  children: [
                    SizedBox(
                      child:SvgPicture.asset(leadingIcon!),
                        height: 19,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 11),
                      child: Text(
                        title ?? '',
                        style: FontStyleUtility.h14(
                          fontColor: textColor ?? ColorUtils.whiteColor,
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    )
                  ],
                ):
                Container(
                  margin: EdgeInsets.symmetric(vertical: 11,horizontal: 36),
                  child: Text(
                    title ?? '',
                    style: FontStyleUtility.h14(
                      fontColor: textColor ?? ColorUtils.whiteColor,
                      fontWeight: FWT.semiBold,
                    ),
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





class MyLeadingItemCustomButtonWidgetHexColor extends StatelessWidget {
  final String? title;
  final String? leadingIcon;
  final String? trailingIcon;
  final VoidCallback? onTap;
  final Alignment? alignment;
  final String? backGroundColor;
  final String? textColor;
  final String? borderColor;
  final double? height;
  final double? width;
  const MyLeadingItemCustomButtonWidgetHexColor(
      {Key? key,
        this.title,
        this.leadingIcon,
        this.trailingIcon,
        this.onTap,
        this.alignment = Alignment.centerLeft,
        this.height,
        this.width,
        this.backGroundColor,
        this.borderColor,
        this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: HexColor(backGroundColor!),
            border: Border.all(color: HexColor(borderColor.toString()))),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  child:SvgPicture.asset(leadingIcon!),
                  height: 19,
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 11),
                  child: Text(
                    title ?? '',
                    style: FontStyleUtility.h14(
                      fontColor: HexColor(textColor.toString()),
                      fontWeight: FWT.semiBold,
                    ),
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



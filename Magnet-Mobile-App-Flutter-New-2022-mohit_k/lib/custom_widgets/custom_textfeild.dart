// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class CustomTextFieldWidget extends StatelessWidget {
  final String? title;
  final String? labelText;
  final TextEditingController? controller;
  final String? trailingImagePath;
  final TextInputType? keyboardType;
  final Widget? image;
  final IconData? icon_data;
  final bool? isObscure;
  final bool? isMobileTextField;
  final Color? color;
  final GestureTapCallback? onTap;

  CustomTextFieldWidget({
    Key? key,
    this.title,
    this.labelText,
    this.controller,
    this.trailingImagePath,
    this.keyboardType,
    this.image,
    this.isObscure = false,
    this.isMobileTextField = false,
    this.icon_data,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Container(
          // decoration: BoxDecoration(
          //   // border: Border.all(color: Colors.transparent),
          //   color: Colors.white,
          //   borderRadius: new BorderRadius.circular(10.0),
          // ),
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin: EdgeInsets.all(5),
            child: TextFormField(
              onTap: onTap,
              obscureText: isObscure ?? false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                fillColor: Colors.white,
                isDense: true,
                labelText: labelText ?? '',
                filled: true,
                border: InputBorder.none,
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //     color: ColorUtils.blueColor,
                //     width: 1,
                //   ),
                // ),
                hintStyle: FontStyleUtility.h12(
                    fontColor: ColorUtils.greyTextColor,
                    fontWeight: FWT.medium),
              ),
              style: FontStyleUtility.h16(
                  fontColor: ColorUtils.blackColor,
                  fontWeight: FWT.semiBold),
              controller: controller,
              keyboardType: keyboardType ?? TextInputType.multiline,
            ),
          ),
        )
      ],
    );
  }
}



class CustomTextFieldWidgetNew extends StatelessWidget {
  final String? title;
  final String? labelText;
  final TextEditingController? controller;
  final String? trailingImagePath;
  final TextInputType? keyboardType;
  final Widget? image;
  final IconData? icon_data;
  final bool? isObscure;
  final bool? isMobileTextField;
  final Function(String)? onChanged;
  final Color? color;
  final GestureTapCallback? onTap;

  CustomTextFieldWidgetNew({
    Key? key,
    this.title,
    this.labelText,
    this.controller,
    this.onChanged,
    this.trailingImagePath,
    this.keyboardType,
    this.image,
    this.isObscure = false,
    this.isMobileTextField = false,
    this.icon_data,
    this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Container(
          // decoration: BoxDecoration(
          //   // border: Border.all(color: Colors.transparent),
          //   color: Colors.white,
          //   borderRadius: new BorderRadius.circular(10.0),
          // ),
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: Container(
            margin: EdgeInsets.all(5),
            child: TextFormField(
              onChanged: onChanged,
              onTap: onTap,
              obscureText: isObscure ?? false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 10),
                fillColor: Colors.white,
                isDense: true,
                labelText: labelText ?? '',
                filled: true,
                border: InputBorder.none,
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //     color: ColorUtils.blueColor,
                //     width: 1,
                //   ),
                // ),
                hintStyle: FontStyleUtility.h12(
                    fontColor: ColorUtils.greyTextColor,
                    fontWeight: FWT.medium),
              ),
              style: FontStyleUtility.h16(
                  fontColor: ColorUtils.blackColor,
                  fontWeight: FWT.semiBold),
              controller: controller,
              keyboardType: keyboardType ?? TextInputType.multiline,
            ),
          ),
        )
      ],
    );
  }
}

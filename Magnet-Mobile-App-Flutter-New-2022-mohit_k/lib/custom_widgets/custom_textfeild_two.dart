// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class CustomTextFieldWidget_two extends StatelessWidget {
  final String? title;
  final String? labelText;
  final TextEditingController? controller;
  final String? trailingImagePath;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  final Widget? image;
  final bool? isObscure;
  final bool? isMobileTextField;
  final Color? color;
  final int? maxLines;
  final GestureTapCallback? tap;
  final bool readOnly;
  final TextAlign? align;
  FormFieldValidator<String>? validator;
  final bool? enabled;
  final bool? touch = false;
  final String? errorText;
  final TextStyle? errorStyle;
  final bool showCursor;

  CustomTextFieldWidget_two({
    Key? key,
    this.title,
    this.labelText,
    this.controller,
    this.trailingImagePath,
    this.keyboardType,
    this.image,
    this.isObscure = false,
    this.isMobileTextField = false,
    this.color,
    this.maxLines,
    this.tap,
    this.readOnly = false,
    this.align,
    this.validator,
    this.enabled,
    this.onChanged,
    this.errorText,
    this.errorStyle,
    this.showCursor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        isMobileTextField == false
            ? Container(
                height: 50,
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     border: Border.all(color: ColorUtils.blueColor, width: 1.5
                // )),
                child: TextField(
                  showCursor: showCursor,
                  enabled: enabled,
                  maxLines: maxLines,
                  onTap: tap,
                  readOnly: readOnly,
                  onChanged: onChanged,
                  obscureText: isObscure ?? false,
                  decoration: InputDecoration(
                    alignLabelWithHint: false,
                    isDense: true,
                    labelText: labelText ?? '',
                    filled: true,
                    border: InputBorder.none,
                    // errorMaxLines: 1,
                    errorText: errorText,
                    errorStyle: errorStyle,
                    // border: OutlineInputBorder(
                    //   borderSide:  BorderSide(color: Colors.red, width: 5),
                    // ),
                    contentPadding:
                        EdgeInsets.only(top: 15, left: 15, bottom: 15),
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 0),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorUtils.blueColor, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),

                    labelStyle: FontStyleUtility.h12(
                        fontColor: ColorUtils.ogfont, fontWeight: FWT.semiBold),
                    suffix: image,
                  ),
                  style: FontStyleUtility.h16(
                      fontColor: ColorUtils.blackColor,
                      fontWeight: FWT.semiBold),
                  controller: controller,
                  keyboardType: keyboardType ?? TextInputType.multiline,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: ColorUtils.boarderColor,
                  width: 2,
                )),
                child: Row(
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage(AssetUtils.indianFlagPng),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        readOnly: readOnly,
                        obscureText: isObscure ?? false,
                        decoration: InputDecoration(
                          hintText: labelText ?? '',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: ColorUtils.lightBlueColor,
                          hintStyle: FontStyleUtility.h16(
                              fontColor: ColorUtils.greyTextColor,
                              fontWeight: FWT.medium),
                          suffix: image,
                        ),
                        controller: controller,
                        keyboardType: keyboardType ?? TextInputType.multiline,
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  }
}

class CommonTextFormField extends StatelessWidget {
  final String? title;
  final String? labelText;
  final TextEditingController? controller;
  final String? trailingImagePath;
  final TextInputType? keyboardType;
  final Widget? image;
  final bool? isObscure;
  final bool? isMobileTextField;
  final Color? color;
  final int? maxLines;
  final GestureTapCallback? tap;
  final bool? readOnly;
  final TextAlign? align;
  FormFieldValidator<String>? validator;

  final Function(String)? onChanged;
  final bool? enabled;
  final bool? touch = false;

  CommonTextFormField({
    Key? key,
    this.onChanged,
    this.title,
    this.labelText,
    this.controller,
    this.trailingImagePath,
    this.keyboardType,
    this.image,
    this.isObscure = false,
    this.isMobileTextField = false,
    this.color,
    this.maxLines,
    this.tap,
    this.readOnly,
    this.align,
    this.validator,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        isMobileTextField == false
            ? Container(
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5,
                      offset: Offset(0, 0),
                      spreadRadius: -5,
                    ),
                  ],
                  color: ColorUtils.whiteColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextFormField(
                  onChanged: onChanged,
                  enabled: enabled,
                  validator: validator,
                  maxLines: maxLines,
                  onTap: tap,
                  obscureText: isObscure ?? false,
                  decoration: InputDecoration(
                    alignLabelWithHint: false,
                    isDense: true,
                    labelText: labelText ?? '',
                    filled: true,
                    border: InputBorder.none,
                    enabledBorder: const OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.transparent, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ColorUtils.blueColor, width: 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelStyle: FontStyleUtility.h12(
                        fontColor: ColorUtils.ogfont, fontWeight: FWT.semiBold),
                    suffix: image,
                  ),
                  style: FontStyleUtility.h14(
                      fontColor: ColorUtils.blackColor,
                      fontWeight: FWT.semiBold),
                  controller: controller,
                  keyboardType: keyboardType ?? TextInputType.multiline,
                ),
              )
            : Container(
                decoration: BoxDecoration(
                    border: Border.all(
                  color: ColorUtils.boarderColor,
                  width: 2,
                )),
                child: Row(
                  children: [
                    Container(
                      child: Image(
                        image: AssetImage(AssetUtils.indianFlagPng),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        obscureText: isObscure ?? false,
                        decoration: InputDecoration(
                          hintText: labelText ?? '',
                          border: InputBorder.none,
                          filled: true,
                          fillColor: ColorUtils.lightBlueColor,
                          hintStyle: FontStyleUtility.h16(
                              fontColor: ColorUtils.greyTextColor,
                              fontWeight: FWT.medium),
                          suffix: image,
                        ),
                        controller: controller,
                        keyboardType: keyboardType ?? TextInputType.multiline,
                      ),
                    ),
                  ],
                ),
              )
      ],
    );
  }
}

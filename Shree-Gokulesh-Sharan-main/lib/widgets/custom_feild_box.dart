import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:vaishnav_parivar/utils/color_utils.dart';
import 'package:vaishnav_parivar/utils/txt_style.dart';

class custom_login_feild extends StatelessWidget {
  final String? title;
  final String? labelText;
  final TextEditingController? controller;
  final String? trailingImagePath;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final HexColor? backgroundColor;
  final Widget? suffix_image;
  final Widget? prefix_image;
  final bool? isObscure;
  final bool? isMobileTextField;
  final Color? color;
  final int? maxLines;
  final GestureTapCallback? tap;
  final bool readOnly;
  final int? maxLength;
  final TextAlign? align;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  FormFieldValidator<String>? validator;
  final bool? enabled;
  final bool? touch = false;
  final String? errorText;
  final TextStyle? errorStyle;
  final bool showCursor;

  custom_login_feild({
    Key? key,
    this.title,
    this.labelText,
    this.textInputType,
    this.maxLength = 1024,
    this.textInputAction,
    this.controller,
    this.trailingImagePath,
    this.keyboardType,
    this.suffix_image,
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
    this.backgroundColor,
    this.prefix_image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0x17000000),
          blurRadius: 10.0,
          offset: Offset(0.0, 0.75),
        ),
      ]),
      child: TextField(
        showCursor: showCursor,
        enabled: enabled,
        maxLines: maxLines,
        onTap: tap,
        readOnly: readOnly,
        maxLength: maxLength,
        onChanged: onChanged,
        obscureText: isObscure ?? false,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: prefix_image,
          fillColor: backgroundColor,
          alignLabelWithHint: true,
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
              EdgeInsets.only(top: 15, left: 15, bottom: 15, right: 15),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorUtils.primary, width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),

          labelStyle: FontStyleUtility.h12(
              fontColor: ColorUtils.dark_font.withOpacity(0.3),
              fontWeight: FWT.semiBold),
          suffix: suffix_image,
        ),
        style: FontStyleUtility.h14(
            fontColor: ColorUtils.dark_font, fontWeight: FWT.semiBold),
        controller: controller,
        keyboardType: textInputType,
      ),
    );
  }
}

class custom_button extends StatelessWidget {
  final String title;
  final String? leadingIcon;
  final String? trailingIcon;
  final VoidCallback? onTap;
  final Alignment? alignment;
  final Color? backGroundColor;
  final Color? textColor;
  final Color? borderColor;
  final double? height;
  final double? width;

  const custom_button(
      {Key? key,
      required this.title,
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
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 54,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: backGroundColor ?? ColorUtils.primary,
            boxShadow: const [
              BoxShadow(
                color: Color(0x17000000),
                blurRadius: 10.0,
                offset: Offset(0.0, 0.75),
              ),
            ]),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                leadingIcon != null
                    ? Row(
                        children: [
                          SizedBox(
                            child: SvgPicture.asset(leadingIcon!),
                            height: 19,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 11),
                            child: Text(
                              title.tr,
                              style: FontStyleUtility.h18(
                                fontColor: textColor ?? ColorUtils.white,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                          )
                        ],
                      )
                    : Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 11, horizontal: 36),
                        child: Text(
                          title.tr,
                          style: FontStyleUtility.h18(
                            fontColor: textColor ?? ColorUtils.white,
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

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String labelText;
  final TextInputType textInputType;
  final bool isObscureText;
  final bool readOnly;
  final Widget? suffix_image;
  final Widget? prefix_icon;
  final int maxLength;
  final TextInputAction textInputAction;
  final String hintText;

  CommonTextField({
    required this.controller,
    required this.validator,
    required this.labelText,
    this.suffix_image,
    this.prefix_icon,
    required this.textInputType,
    required this.textInputAction,
    this.maxLength = 10247,
    required this.hintText,
    this.isObscureText = false,
    this.readOnly = false,
    Null Function()? onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
      child: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0x17000000),
              blurRadius: 10.0,
              offset: Offset(0.0, 0.75),
            ),
          ],
        ),
        height: 54,
        child: TextFormField(
          readOnly: readOnly,
          obscureText: isObscureText,
          controller: controller,
          style: FontStyleUtility.h14(
              fontColor: ColorUtils.dark_font, fontWeight: FWT.semiBold),
          maxLength: maxLength,
          // cursorColor: AppColors.textGrey,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            // labelText: labelText.tr,
            labelStyle: FontStyleUtility.h12(
              fontColor: ColorUtils.dark_font.withOpacity(0.3),
              fontWeight: FWT.semiBold,
            ),
            filled: true,
            fillColor: HexColor("#FFFFFF"),
            suffix: suffix_image,
            prefixIcon: prefix_icon,
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent, width: 0),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorUtils.primary, width: 1.5),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            hintText: hintText.tr,
            counterText: "",
          ),
          validator: validator,
          keyboardType: textInputType,
        ),
      ),
    );
  }
}

class custom_profile_feild extends StatelessWidget {
  final String? title;
  final String? labelText;
  final TextEditingController? controller;
  final String? trailingImagePath;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final HexColor? backgroundColor;
  final Widget? suffix_image;
  final Widget? prefix_image;
  final bool? isObscure;
  final bool? isMobileTextField;
  final Color? color;
  final int? maxLines;
  final GestureTapCallback? tap;
  final bool readOnly;
  final int? maxLength;
  final TextAlign? align;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  FormFieldValidator<String>? validator;
  final bool? enabled;
  final bool? touch = false;
  final String? errorText;
  final TextStyle? errorStyle;
  final bool showCursor;

  custom_profile_feild({
    Key? key,
    this.title,
    this.labelText,
    this.textInputType,
    this.maxLength = 1024,
    this.textInputAction,
    this.controller,
    this.trailingImagePath,
    this.keyboardType,
    this.suffix_image,
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
    this.backgroundColor,
    this.prefix_image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0x17000000),
          blurRadius: 10.0,
          offset: Offset(0.0, 0.75),
        ),
      ]),
      child: TextField(
        showCursor: showCursor,
        enabled: enabled,
        maxLines: maxLines,
        onTap: tap,
        readOnly: readOnly,
        maxLength: maxLength,
        onChanged: onChanged,
        obscureText: isObscure ?? false,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: prefix_image,
          fillColor: backgroundColor,
          alignLabelWithHint: true,
          isDense: true,
          labelText: labelText ?? '',
          filled: true,
          border: InputBorder.none,

          contentPadding:
          EdgeInsets.only(top: 15, left: 15, bottom: 15, right: 15),

          labelStyle: FontStyleUtility.h12(
              fontColor: ColorUtils.dark_font.withOpacity(0.3),
              fontWeight: FWT.semiBold),
          suffix: suffix_image,
        ),
        style: FontStyleUtility.h14(
            fontColor: ColorUtils.dark_font, fontWeight: FWT.semiBold),
        controller: controller,
        keyboardType: textInputType,
      ),
    );
  }
}


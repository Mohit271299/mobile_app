
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../appdetails.dart';
import 'gradient_txt.dart';
import '../common/common_color.dart';

class customTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FormFieldValidator<String> validator;
  final String? labelText;
  final TextInputType textInputType;
  final bool isObscureText;
  final bool readOnly;
  final Widget? suffix_image;
  final Widget? prefix_icon;
  final int maxLength;
  final TextAlign? alignment;
  final TextInputAction textInputAction;
  final String hintText;

  customTextField({
    this.controller,
    required this.validator,
    this.labelText,
    this.suffix_image,
    this.prefix_icon,
    required this.textInputType,
    required this.textInputAction,
    this.maxLength = 10247,
    required this.hintText,
    this.isObscureText = false,
    this.readOnly = false,
    Null Function()? onTap, this.alignment,
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
          textAlign: alignment!,
          readOnly: readOnly,
          obscureText: isObscureText,
          controller: controller,
          style: TextStyle(
            overflow: TextOverflow.ellipsis,
            fontFamily: AppDetails.fontGilroyRegular,
            fontSize: 14.0,
            color: HexColor("#ffffff"),
          ),
          maxLength: maxLength,
          // cursorColor: AppColors.textGrey,
          textInputAction: textInputAction,

          decoration: InputDecoration(
            border: InputBorder.none,
            labelText: labelText,

            hintStyle: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontFamily: AppDetails.fontGilroyRegular,
              fontSize: 14.0,
              color: Colors.white,
            ),
            filled: false,
            suffix: suffix_image,
            prefixIcon: prefix_icon,
            enabledBorder:UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.4), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
            ) ,
            focusedBorder:UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(0.4), width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
            ) ,
            // enabledBorder: const OutlineInputBorder(
            //   borderSide: BorderSide(color: Colors.transparent, width: 0),
            //   borderRadius: BorderRadius.all(Radius.circular(10)),
            // ),
            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(color: ColorUtils.primary, width: 1.5),
            //   borderRadius: const BorderRadius.all(Radius.circular(10)),
            // ),
            hintText: hintText,
            counterText: "",
          ),
          validator: validator,
          keyboardType: textInputType,
        ),
      ),
    );
  }
}



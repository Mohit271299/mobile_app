import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/AppDetails.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_style.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String icon;
  final TextInputType textInputType;
  final bool isObscureText;
  final bool readOnly;
  final int maxLength;
  final TextInputAction textInputAction;
  final String hintText;

  CommonTextField({
    required this.controller,
    required this.validator,
    required this.icon,
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
      padding: const EdgeInsets.only(
          left: 38.0, top: 0.0, right: 38.0, bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 2),
            ]),
        height: MediaQuery.of(context).size.height * 0.07,
        child: TextFormField(
          readOnly: readOnly,
          obscureText: isObscureText,
          controller: controller,
          style: const TextStyle(
              color: Colors.black, fontFamily: AppDetails.fontRegular),
          maxLength: maxLength,
          // cursorColor: AppColors.textGrey,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            filled: true,
            fillColor: HexColor("#FFFFFF"),
            hintStyle: TextStyle(
              fontFamily: AppDetails.fontSemiBold,
              fontSize: 12.0,
              color: HexColor(
                CommonColor.subHeaderColor,
              ),
            ),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Image.asset(
                icon.toString(),
                height: 19.0,
                width: 14.0,
                fit: BoxFit.fill,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: HexColor(CommonColor.textfieldBorder),
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: HexColor(CommonColor.textfieldBorder),
                width: 2.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: HexColor(CommonColor.textfieldBorder), width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: HexColor(CommonColor.textfieldBorder), width: 2.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: HexColor(CommonColor.appActiveColor), width: 2.0),
            ),
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

class CommonTextFieldPassword extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String icon;
  final TextInputType textInputType;
  final bool isObscureText;
  final bool readOnly;
  final int maxLength;
  final TextInputAction textInputAction;
  final String hintText;

  CommonTextFieldPassword({
    required this.controller,
    required this.validator,
    required this.icon,
    required this.textInputType,
    required this.textInputAction,
    this.maxLength = 10247,
    required this.hintText,
    this.isObscureText = false,
    this.readOnly = false,
    Null Function()? onTap,
  });

  @override
  State<CommonTextFieldPassword> createState() =>
      _CommonTextFieldPasswordState();
}

class _CommonTextFieldPasswordState extends State<CommonTextFieldPassword> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 38.0, top: 0.0, right: 38.0, bottom: 5.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(color: Colors.grey, blurRadius: 2),
          ],
        ),
        height: MediaQuery.of(context).size.height * 0.07,
        child: TextFormField(
          readOnly: widget.readOnly,
          obscureText: isPasswordVisible,
          controller: widget.controller,
          style: const TextStyle(
              color: Colors.black, fontFamily: AppDetails.fontRegular),
          maxLength: widget.maxLength,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            filled: true,
            fillColor: HexColor("#FFFFFF"),
            hintStyle: TextStyle(
              fontFamily: AppDetails.fontSemiBold,
              fontSize: 12.0,
              color: HexColor(
                CommonColor.subHeaderColor,
              ),
            ),
            prefixIcon: InkWell(
              onTap: () {
                if (isPasswordVisible == true) {
                  setState(() => isPasswordVisible = false);
                } else {
                  setState(() => isPasswordVisible = true);
                }
              },
              child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: (isPasswordVisible == false)
                      ? Image.asset(
                          widget.icon.toString(),
                          height: 19.0,
                          width: 14.0,
                          fit: BoxFit.fill,
                        )
                      : Image.asset(
                          widget.icon.toString(),
                          height: 19.0,
                          width: 14.0,
                          fit: BoxFit.fill,
                        )),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: HexColor(CommonColor.textfieldBorder),
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: HexColor(CommonColor.textfieldBorder),
                width: 2.0,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: HexColor(CommonColor.textfieldBorder),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: HexColor(CommonColor.textfieldBorder),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: HexColor(CommonColor.appActiveColor), width: 2.0),
            ),
            hintText: widget.hintText,
            counterText: "",
          ),
          validator: widget.validator,
          keyboardType: widget.textInputType,
        ),
      ),
    );
  }
}

class CommonTextFieldSearch extends StatelessWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final String icon;
  final TextInputType textInputType;
  final bool isObscureText;
  final bool readOnly;
  final int maxLength;
  final TextInputAction textInputAction;
  final String hintText;

  CommonTextFieldSearch({
    required this.controller,
    required this.validator,
    required this.icon,
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 2),
        ],
      ),
      height: 34.0,
      child: TextFormField(
        enabled: true,
        readOnly: readOnly,
        obscureText: isObscureText,
        controller: controller,
        style: const TextStyle(
            color: Colors.black, fontFamily: AppDetails.fontRegular),
        maxLength: maxLength,
        // cursorColor: AppColors.textGrey,
        textInputAction: textInputAction,
        maxLines: 1,
        decoration: InputDecoration(
          filled: true,

          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: -5.0),
          // contentPadding: const EdgeInsets.only(
          //     top: 10.0, left: -85.0, right: 0.0, bottom: 0.0),
          fillColor: HexColor("#FFFFFF"),

          hintStyle: TextStyle(
            fontFamily: AppDetails.fontMedium,
            fontSize: 12.0,
            color: HexColor(
              CommonColor.subHeaderColor,
            ),
          ),
          prefixIcon: Container(
            margin: const EdgeInsets.only(
                top: 10.0, bottom: 10.0, right: 0.0, left: 0.0),
            child: SizedBox(
              height: 11.0,
              width: 11.0,
              child: Image.asset(
                icon.toString(),
                height: 11.0,
                width: 11.0,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: HexColor(CommonColor.textfieldBorder),
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: HexColor(CommonColor.textfieldBorder),
              width: 2.0,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: HexColor(CommonColor.textfieldBorder), width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: HexColor(CommonColor.textfieldBorder), width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: HexColor(CommonColor.appActiveColor), width: 2.0),
          ),
          hintText: hintText,
          counterText: "",
        ),
        validator: validator,
        keyboardType: textInputType,
      ),
    );
  }
}

class CommonTextFieldLabel extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType textInputType;
  final bool isObscureText;
  final bool readOnly;
  final String labelText;
  final int maxLength;
  final TextInputAction textInputAction;
  final String hintText;
  Null Function()? onTap;
  void Function(String)? onChanged;
  void Function()? onComplete;
  void Function(String?)? onSave;
  void Function(String)? onfieldSubmitted;

  CommonTextFieldLabel({
    required this.controller,
    required this.validator,
    required this.textInputType,
    required this.textInputAction,
    required this.labelText,
    this.maxLength = 10247,
    required this.hintText,
    this.isObscureText = false,
    this.onChanged,
    this.readOnly = false,
    this.onfieldSubmitted,
    this.onTap,
    this.onComplete,
    this.onSave,
  });

  @override
  State<CommonTextFieldLabel> createState() => _CommonTextFieldLabelState();
}

class _CommonTextFieldLabelState extends State<CommonTextFieldLabel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      padding:
          const EdgeInsets.only(left: 10.0, top: 3.0, bottom: 5.0, right: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: ContainerInnerShadow,
      ),
      child: TextFormField(
        onEditingComplete: widget.onComplete,
        onSaved: widget.onSave,
        onFieldSubmitted: widget.onfieldSubmitted,
        onChanged: widget.onChanged,
        onTap: widget.onTap,
        autofocus: true,
        enabled: true,
        readOnly: widget.readOnly,
        obscureText: widget.isObscureText,
        controller: widget.controller,
        style: const TextStyle(
            color: Colors.black,
            fontFamily: AppDetails.fontSemiBold,
            fontSize: 14.0),
        maxLength: widget.maxLength,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontFamily: AppDetails.fontSemiBold,
            color: HexColor(CommonColor.subHeaderColor),
            fontSize: 10.0,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(
              top: 5.0, left: 0.0, right: 0.0, bottom: 3.0),
          // hintStyle: TextStyle(
          //   fontFamily: AppDetails.fontSemiBold,
          //   fontSize: 12.0,
          //   color: HexColor(
          //     CommonColor.subHeaderColor,
          //   ),
          // ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: widget.hintText,
          counterText: "",
        ),
        validator: widget.validator,
        keyboardType: widget.textInputType,
      ),
    );
  }
}

class CommonTextFieldLabelIcon extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType textInputType;
  final bool isObscureText;
  final bool readOnly;
  final String icon;
  final String labelText;
  final int maxLength;
  final TextInputAction textInputAction;
  final String hintText;

  Null Function()? onTap;

  CommonTextFieldLabelIcon({
    required this.controller,
    required this.validator,
    required this.icon,
    required this.textInputType,
    required this.textInputAction,
    required this.labelText,
    this.maxLength = 10247,
    required this.hintText,
    this.isObscureText = false,
    this.readOnly = false,
    this.onTap,
  });

  @override
  State<CommonTextFieldLabelIcon> createState() =>
      _CommonTextFieldLabelIconState();
}

class _CommonTextFieldLabelIconState extends State<CommonTextFieldLabelIcon> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.0,
      padding:
          const EdgeInsets.only(left: 10.0, top: 3.0, bottom: 5.0, right: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: ContainerInnerShadow,
      ),
      child: TextFormField(
        autofocus: true,
        enabled: true,
        readOnly: widget.readOnly,
        obscureText: widget.isObscureText,
        controller: widget.controller,
        onTap: widget.onTap,
        style: const TextStyle(
            color: Colors.black,
            fontFamily: AppDetails.fontSemiBold,
            fontSize: 14.0),
        maxLength: widget.maxLength,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(
                left: 13.0, top: 5.0, bottom: 10.0, right: 13.0),
            child: Image.asset(
              widget.icon.toString(),
              height: 11.0,
              width: 11.0,
              fit: BoxFit.fill,
            ),
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontFamily: AppDetails.fontSemiBold,
            color: HexColor(CommonColor.subHeaderColor),
            fontSize: 10.0,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(
              top: 5.0, left: 0.0, right: 0.0, bottom: 3.0),
          // hintStyle: TextStyle(
          //   fontFamily: AppDetails.fontSemiBold,
          //   fontSize: 12.0,
          //   color: HexColor(
          //     CommonColor.subHeaderColor,
          //   ),
          // ),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: widget.hintText,
          counterText: "",
        ),
        validator: widget.validator,
        keyboardType: widget.textInputType,
      ),
    );
  }
}

class CommonTextFieldTextArea extends StatefulWidget {
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final TextInputType textInputType;
  final bool isObscureText;
  final bool readOnly;
  final String labelText;
  final int maxLength;
  final TextInputAction textInputAction;
  final String hintText;
  int maxLines;

  Null Function()? onTap;

  CommonTextFieldTextArea({
    required this.controller,
    required this.maxLines,
    required this.validator,
    required this.textInputType,
    required this.textInputAction,
    required this.labelText,
    this.maxLength = 10247,
    required this.hintText,
    this.isObscureText = false,
    this.readOnly = false,
    this.onTap,
  });

  @override
  State<CommonTextFieldTextArea> createState() =>
      _CommonTextFieldTextAreaState();
}

class _CommonTextFieldTextAreaState extends State<CommonTextFieldTextArea> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70.0,
      padding:
          const EdgeInsets.only(left: 10.0, top: 3.0, bottom: 5.0, right: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: ContainerInnerShadow,
      ),
      child: TextFormField(
        autofocus: true,
        enabled: true,
        readOnly: widget.readOnly,
        obscureText: widget.isObscureText,
        controller: widget.controller,
        onTap: widget.onTap,
        style: const TextStyle(
            color: Colors.black,
            fontFamily: AppDetails.fontSemiBold,
            fontSize: 14.0),
        maxLength: widget.maxLength,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontFamily: AppDetails.fontSemiBold,
            color: HexColor(CommonColor.subHeaderColor),
            fontSize: 10.0,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.only(
              top: 5.0, left: 0.0, right: 0.0, bottom: 3.0),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          hintText: widget.hintText,
          counterText: "",
        ),
        validator: widget.validator,
        keyboardType: widget.textInputType,
      ),
    );
  }
}

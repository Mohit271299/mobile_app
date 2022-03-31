import 'package:country_code_picker/country_code_picker.dart';
import 'package:encrypted_app/common/common_color.dart';
import 'package:encrypted_app/common/common_style.dart';
import 'package:encrypted_app/common/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:hexcolor/hexcolor.dart';

import '../appdetails.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfeild.dart';
import 'otp_verification.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {
  late Size screenSize;

  String dialCodedigits = "+00";

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: HexColor(CommonColor.appBackColor),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            height: screenSize.height,
            width: screenSize.width,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30 ),

              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // 90 margin on top
                  SizedBox(
                    height: (screenSize.height * 0.126).ceilToDouble(),
                  ),
                  Text('ENCRYPTO', style: CommonStyle().headerStyle()),
                  SizedBox(
                    height: (screenSize.height * 0.02).ceilToDouble(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 58.0, right: 57.0),
                    child: Text(
                      Texts.signInBody,
                      textAlign: TextAlign.center,
                      style: CommonStyle().subTitleStyle(),
                    ),
                  ),
                  SizedBox(
                    height: (screenSize.height * 0.126).ceilToDouble(),
                  ),
                  // form
                  Container(
                    // height: screenSize.height / 2,
                    // width: screenSize.width,
                    decoration: BoxDecoration(
                      color: HexColor(CommonColor.appBackColor),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor("#FFFFFF").withOpacity(0.25),
                          blurRadius: 10,
                          spreadRadius: -8,
                          offset: const Offset(-6, -6),
                        ),
                        BoxShadow(
                          color: HexColor("#000000").withOpacity(0.25),
                          blurRadius: 12,
                          spreadRadius: 0,
                          offset: const Offset(6, 6),
                        ),
                      ],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 0),
                              child: Text('Your Phone',
                                  style: CommonStyle().TitleStyle())),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 30),
                              child: Text('Phone Number',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: AppDetails.fontGilroyRegular,
                                    fontSize: 14.0,
                                    color: HexColor("#ffffff"),
                                  ))),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: customTextField(
                              alignment: TextAlign.left,
                              maxLength: 10,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number,
                              prefix_icon: CountryCodePicker(
                                dialogBackgroundColor:
                                    HexColor(CommonColor.appBackColor),
                                dialogTextStyle: TextStyle(color: Colors.white),
                                searchStyle: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    decoration: TextDecoration.overline),
                                flagWidth: 20,
                                showDropDownButton: true,
                                hideMainText: true,
                                padding: EdgeInsets.zero,
                                textStyle: TextStyle(color: CupertinoColors.white),
                                onChanged: (country) {
                                  setState(() {
                                    dialCodedigits = country.dialCode!;
                                  });
                                },
                                initialSelection: "IN",
                                showCountryOnly: true,
                                showOnlyCountryWhenClosed: false,
                                favorite: const ["+1", "US", "+91", "IN"],
                              ),
                              hintText: 'Enter number',
                              validator: (String? value) {},
                              controller: null,
                            ),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 20),
                              child: Text(Texts.numberText,
                                  maxLines: 2,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: AppDetails.fontGilroyRegular,
                                    fontSize: 12.0,
                                    color: HexColor("#FFFFFF").withOpacity(0.40),
                                  ))),
                        ],
                      ),
                    ),
                  ),

                  customButton(
                    text: 'Send OTP',
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OtpVerification()));
                    },
                  )
                  //
                  // Text(
                  //   '${(screenSize.height * 0.02).ceilToDouble()}.',
                  //   style: const TextStyle(
                  //     color: Colors.white,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

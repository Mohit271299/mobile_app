import 'package:encrypted_app/screen/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:encrypted_app/common/common_color.dart';
import 'package:encrypted_app/common/common_style.dart';
import 'package:encrypted_app/common/texts.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../appdetails.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfeild.dart';
import '../widgets/gradient_txt.dart';
import 'otp_verification.dart';

class PersonalDetails extends StatefulWidget {
  const PersonalDetails({Key? key}) : super(key: key);

  @override
  _PersonalDetailsState createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
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
              margin: EdgeInsets.symmetric(horizontal: 30),
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
                  Text(
                    Texts.signInBody,
                    textAlign: TextAlign.center,
                    style: CommonStyle().subTitleStyle(),
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
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: customTextField(
                              alignment: TextAlign.left,
                              maxLength: 10,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number,
                              hintText: 'Contact name (optional)',
                              validator: (String? value) {},
                              controller: null,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: customTextField(
                              alignment: TextAlign.left,
                              maxLength: 10,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number,
                              hintText: 'Reference person name (optional)',
                              validator: (String? value) {},
                              controller: null,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: customTextField(
                              alignment: TextAlign.left,
                              maxLength: 10,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number,
                              hintText: 'Reference person number (optional)',
                              validator: (String? value) {},
                              controller: null,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: customTextField(
                              alignment: TextAlign.left,
                              maxLength: 10,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.number,
                              hintText: 'Referral code (optional)',
                              validator: (String? value) {},
                              controller: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 20),
                      child: GradientText(
                        "Filling all the details can help you to get cearence very soon.",
                        maxLines: 2,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: AppDetails.fontGilroySemiBold,
                          fontSize: 12.0,
                          color: HexColor("#FFFFFF"),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment(0.8, 0.0),
                          // 10% of the width, so there are ten blinds.
                          colors: <Color>[
                            HexColor('#C996CC'),
                            HexColor('#916BBF')
                          ],
                          // red to yellow
                          tileMode: TileMode.clamp,
                        ),
                      )),

                  customButton(
                    text: 'Lets do this',
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen(0)));
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

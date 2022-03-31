import 'package:encrypted_app/screen/personal_details.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:encrypted_app/common/common_color.dart';
import 'package:encrypted_app/common/common_style.dart';
import 'package:encrypted_app/common/texts.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pinput/pin_put/pin_put.dart';

import '../appdetails.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfeild.dart';
class CreatePin extends StatefulWidget {
  const CreatePin({Key? key}) : super(key: key);

  @override
  _CreatePinState createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  late Size screenSize;

  final TextEditingController _pinOTPController = TextEditingController();

  final FocusNode _pinOTPFocus = FocusNode();

  final BoxDecoration pinOTPDecoration = BoxDecoration(

    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.white10,
    ),
  );
  final BoxDecoration pinOTPDecoration2 = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.transparent,
    ),
  );

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
                      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: Column(
                        children: [
                          Container(
                              alignment: Alignment.topLeft,
                              margin:  EdgeInsets.only(top: 0),
                              child: Text('Create 6 Digit Pin',
                                  style: CommonStyle().TitleStyle())),
                          Container(
                            alignment: Alignment.center,
                            child: PinPut(
                              eachFieldMargin: const EdgeInsets.symmetric(horizontal: 1.65,vertical: 10),
                              mainAxisSize: MainAxisSize.min,
                              fieldsCount: 6,
                              textStyle: TextStyle(
                                  fontSize: 15, color: Colors.black),
                              eachFieldHeight: 40,
                              eachFieldWidth: 20,
                              focusNode: _pinOTPFocus,
                              controller: _pinOTPController,
                              submittedFieldDecoration: pinOTPDecoration,
                              selectedFieldDecoration: pinOTPDecoration,
                              followingFieldDecoration: pinOTPDecoration2,
                              pinAnimationType: PinAnimationType.rotation,
                              onSubmit: (pin) async {
                                try {
// await FirebaseAuth.instance
//     .signInWithCredential(
//     PhoneAuthProvider.credential(
//         verificationId: varification!,
//         smsCode: pin))
//     .then((value) {
//   if (value.user != null) {
//     signup(context);
//   }
// });
                                } catch (e) {

                                }
                              },
                            ),
                          ),
                          Container(
                              alignment: Alignment.topLeft,
                              margin:  EdgeInsets.only(top: 30),
                              child: Text('Enter Otp received',
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontFamily: AppDetails.fontGilroyRegular,
                                    fontSize: 14.0,
                                    color: HexColor("#ffffff"),
                                  )
                              )),
                          Container(
                            alignment: Alignment.center,
                            child: PinPut(
                              eachFieldMargin: const EdgeInsets.symmetric(horizontal: 1.65,vertical: 10),
                              mainAxisSize: MainAxisSize.min,
                              fieldsCount: 6,
                              textStyle: TextStyle(
                                  fontSize: 15, color: Colors.black),
                              eachFieldHeight: 40,
                              eachFieldWidth: 20,
                              focusNode: _pinOTPFocus,
                              controller: _pinOTPController,
                              submittedFieldDecoration: pinOTPDecoration,
                              selectedFieldDecoration: pinOTPDecoration,
                              followingFieldDecoration: pinOTPDecoration2,
                              pinAnimationType: PinAnimationType.rotation,
                              onSubmit: (pin) async {
                                try {
// await FirebaseAuth.instance
//     .signInWithCredential(
//     PhoneAuthProvider.credential(
//         verificationId: varification!,
//         smsCode: pin))
//     .then((value) {
//   if (value.user != null) {
//     signup(context);
//   }
// });
                                } catch (e) {

                                }
                              },
                            ),
                          ),


                        ],
                      ),
                    ),
                  ),

                  customButton(
                    text: 'Continue',
                    ontap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PersonalDetails()));
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:vaishnav_parivar/Common/common.dart';
import 'package:vaishnav_parivar/Common/common_routing.dart';
import 'package:vaishnav_parivar/Common/toast_util.dart';
import 'package:vaishnav_parivar/pagination/route_name.dart';
import 'package:vaishnav_parivar/screen/Auth/controller/signincontroller.dart';
import 'package:vaishnav_parivar/utils/asset_utils.dart';
import 'package:vaishnav_parivar/utils/back_image.dart';
import 'package:vaishnav_parivar/utils/color_utils.dart';
import 'package:vaishnav_parivar/utils/loader/page_loader.dart';
import 'package:vaishnav_parivar/utils/txt_file.dart';
import 'package:vaishnav_parivar/utils/txt_style.dart';

import '../../../widgets/custom_feild_box.dart';

class VerificationScreen extends StatefulWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _pinOTPController = TextEditingController();
  final mobileController = TextEditingController();

  @override
  void dispose() {
    hideLoader(context);
    super.dispose();
  }

  final FocusNode _pinOTPFocus = FocusNode();
  final SignInController signInController = Get.find<SignInController>();

  final BoxDecoration pinOTPDecoration = BoxDecoration(
    boxShadow: const [
      BoxShadow(
        color: Color(0x17000000),
        blurRadius: 10.0,
        offset: Offset(0.0, 0.75),
      ),
    ],
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: ColorUtils.primary,
    ),
  );
  final BoxDecoration pinOTPDecoration2 = BoxDecoration(
    boxShadow: const [
      BoxShadow(
        color: Color(0x17000000),
        blurRadius: 10.0,
        offset: Offset(0.0, 0.75),
      ),
    ],
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
      color: Colors.transparent,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
          child: SingleChildScrollView(
            child: InkWell(
              onTap: () => hideFocusKeyBoard(context),
              child: back_image(
                body_container: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: (screenSize.height * 0.05)),
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              margin: const EdgeInsets.only(top: 0, left: 03),
                              height: 40,
                              width: 40,
                              child: InkWell(
                                onTap: () => gotoRegistrationScreen(),
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 13, horizontal: 10),
                                  child: SvgPicture.asset(
                                    AssetUtils.drawer_back,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: (screenSize.height * 0.019).ceilToDouble(),
                          ),
                          Container(
                            // margin: EdgeInsets.only(top: 80),
                            alignment: Alignment.center,
                            child: Text(
                              txt_utils.confirm_otp,
                              style: FontStyleUtility.h24(
                                fontColor: ColorUtils.dark_font,
                                fontWeight: FWT.semiBold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(left: 40, right: 40),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'Enter OTP we just sent to your phone number. ',
                                style: FontStyleUtility.h14(
                                    fontColor:
                                        ColorUtils.black.withOpacity(0.6),
                                    fontWeight: FWT.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        "${signInController.selectCountryCode.value.toString()} ${signInController.phoneNoController.text.toString()}",
                                    style: FontStyleUtility.h14(
                                        fontColor: ColorUtils.black,
                                        fontWeight: FWT.bold),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: PinPut(
                              eachFieldMargin:
                                  const EdgeInsets.symmetric(horizontal: 3.65),
                              mainAxisSize: MainAxisSize.min,
                              fieldsCount: 6,
                              textStyle: TextStyle(
                                  fontSize: 15, color: ColorUtils.black),
                              eachFieldHeight: 54,
                              eachFieldWidth: 46,
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
                                  FocusScope.of(context).unfocus();
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('invalid otp'),
                                    duration: Duration(seconds: 3),
                                  ));
                                }
                              },
                            ),
                          ),
                          SizedBox(
                              height:
                                  (screenSize.height * 0.027).ceilToDouble()),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Time Remaining :",
                                  style: FontStyleUtility.h14(
                                      fontColor:
                                          ColorUtils.black.withOpacity(0.6),
                                      fontWeight: FWT.lightBold),
                                ),
                                InkWell(
                                  onTap: () {
                                    _pinOTPController.clear();
                                    hideFocusKeyBoard(context);
                                    signInController
                                        .phoneAuthentication()
                                        .then((value) {
                                      // debugPrint(
                                      //     '2-2-2-2-2-2 Inside the Response ${value.toString()}');

                                      if (value != null) {
                                        if (value == true) {
                                          ToastUtils.showSuccess(
                                              message:
                                                  'OTP send successfully.');
                                        }
                                      }
                                    });
                                  },
                                  child: Text(
                                    "Resend",
                                    style: FontStyleUtility.h14(
                                        fontColor: ColorUtils.primary,
                                        fontWeight: FWT.lightBold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                              height:
                                  (screenSize.height * 0.21).ceilToDouble()),
                          custom_button(
                            title: 'Submit',
                            onTap: () {
                              hideFocusKeyBoard(context);
                              signInController
                                  .checkOTP(
                                      otp: _pinOTPController.text
                                          .toString()
                                          .trim())
                                  .then((value) {
                                if (value != null) {
                                  if (value == true) {
                                    showLoader(context);
                                    signInController
                                        .authEmailPasswordStore()
                                        .then(
                                      (values) {
                                        debugPrint(
                                            '2-2-2-2-2- Inside authEmailPasswordStore ${value.toString()}');
                                        if (values == true) {
                                          signInController.storeUserInformations();
                                        } else {
                                          hideLoader(context);
                                        }
                                      },
                                    );
                                  }
                                }
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

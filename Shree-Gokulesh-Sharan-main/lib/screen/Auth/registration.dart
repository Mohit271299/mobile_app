// ignore_for_file: camel_case_types

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vaishnav_parivar/Common/common.dart';
import 'package:vaishnav_parivar/Common/common_routing.dart';
import 'package:vaishnav_parivar/pagination/route_name.dart';
import 'package:vaishnav_parivar/screen/Auth/controller/signincontroller.dart';
import 'package:vaishnav_parivar/screen/Auth/login.dart';
import 'package:vaishnav_parivar/utils/back_image.dart';
import 'package:vaishnav_parivar/utils/loader/page_loader.dart';
import 'package:vaishnav_parivar/utils/txt_file.dart';
import 'package:vaishnav_parivar/utils/txt_style.dart';

import '../../utils/asset_utils.dart';
import '../../utils/color_utils.dart';
import '../../widgets/custom_feild_box.dart';

class registration_screen extends StatefulWidget {
  const registration_screen({Key? key}) : super(key: key);

  @override
  _registration_screenState createState() => _registration_screenState();
}

class _registration_screenState extends State<registration_screen> {
  final SignInController signInController =
      Get.put(SignInController(), tag: SignInController().toString());
  PageController? _pageController;
  String dialCodedigits = "+00";

  final TextEditingController _pinOTPController = TextEditingController();
  final mobileController = TextEditingController();

  final FocusNode _pinOTPFocus = FocusNode();
  String? varification;

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
  void initState() {
    _pageController = PageController(initialPage: 0, keepPage: false);
    super.initState();
  }

  @override
  void dispose() {
    hideLoader(context);
    super.dispose();
  }

  bool isPasswordShow = false;
  bool isConfirmPasswordShow = false;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GetBuilder<SignInController>(
            init: signInController,
            builder: (ctx) {
              return back_image(
                body_container: Container(
                  height: screenSize.height,
                  width: screenSize.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        height: (screenSize.height * 0.11).ceilToDouble(),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Text(
                          'welcome'.tr,
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
                        child: Text('sign_up_body'.tr,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: FontStyleUtility.h14(
                                fontColor:
                                    ColorUtils.dark_font.withOpacity(0.6),
                                fontWeight: FWT.semiBold)),
                      ),
                      SizedBox(
                        height: screenSize.height * 0.059,
                      ),
                      CommonTextField(
                        labelText: 'enter_your_name'.tr,
                        controller: signInController.userNameController,
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {},
                        textInputType: TextInputType.text,
                        hintText: 'enter_your_name'.tr,
                      ),
                      Obx(() => (signInController.isUserNameError.isTrue)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, bottom: 2.0),
                                child: Text(
                                  signInController.userNameErrorMessage.value
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "sf_normal",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          : Text('')),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonTextField(
                        labelText: 'enter_your_email'.tr,
                        controller: signInController.emailController,
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {},
                        textInputType: TextInputType.emailAddress,
                        hintText: 'enter_your_email'.tr,
                      ),
                      Obx(() => (signInController.isEmailError.isTrue)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, bottom: 2.0),
                                child: Text(
                                  signInController
                                      .emailAddressErrorMessage.value
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "sf_normal",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          : const Text('')),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonTextField(
                        maxLength: 10,
                        textInputAction: TextInputAction.next,
                        textInputType: TextInputType.number,
                        prefix_icon: CountryCodePicker(
                          onChanged: (country) {
                            setState(() {
                              dialCodedigits = country.dialCode!;
                            });
                            debugPrint(
                                '1-1-1-1-1 Change Country Code ${dialCodedigits.toString()}');
                            signInController.selectCountryCode.value =
                                dialCodedigits.toString();
                            signInController.countryCodeController.text =
                                country.dialCode.toString();
                          },
                          initialSelection: "IN",
                          showCountryOnly: false,
                          showOnlyCountryWhenClosed: false,
                          favorite: const ["+1", "US", "+91", "IN"],
                        ),
                        controller: signInController.phoneNoController,
                        labelText: 'enter_your_mobile'.tr,
                        hintText: 'enter_your_mobile'.tr,
                        validator: (String? value) {},
                      ),
                      Obx(() => (signInController.isPhoneNumberError.isTrue)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, bottom: 2.0),
                                child: Text(
                                  signInController.mobileNoErrorMessage.value
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "sf_normal",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          : const Text('')),
                      const SizedBox(
                        height: 10,
                      ),
                      CommonTextField(
                        labelText: 'enter_your_password'.tr,
                        controller: signInController.passwordController,
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {},
                        isObscureText: isPasswordShow,
                        suffix_image: InkWell(
                          onTap: () {
                            if (isPasswordShow == true) {
                              setState(() {
                                isPasswordShow = false;
                              });
                            } else {
                              setState(() {
                                isPasswordShow = true;
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: SvgPicture.asset(
                              AssetUtils.hide_svg,
                              height: 20,
                            ),
                          ),
                        ),
                        textInputType: TextInputType.visiblePassword,
                        hintText: 'enter_your_password'.tr,
                      ),
                      Obx(() => (signInController.isPasswordError.isTrue)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, bottom: 2.0),
                                child: Text(
                                  signInController.passwordErrorMessage.value
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "sf_normal",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          : const Text('')),
                      const SizedBox(
                        height: 20,
                      ),
                      CommonTextField(
                        labelText: 'enter_your_confirm_password'.tr,
                        controller: signInController.confirmPasswordController,
                        textInputAction: TextInputAction.done,
                        validator: (String? value) {},
                        isObscureText: true,
                        suffix_image: SvgPicture.asset(
                          AssetUtils.hide_svg,
                          height: 18,
                        ),
                        textInputType: TextInputType.visiblePassword,
                        hintText: 'enter_your_confirm_password'.tr,
                      ),
                      Obx(() => (signInController.isConfirmPasswordError.isTrue)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 0.0, bottom: 2.0),
                                child: Text(
                                  signInController
                                      .confirmPasswordErrorMessage.value
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "sf_normal",
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            )
                          : const Text('')),
                      SizedBox(
                        height: screenSize.height * 0.059,
                      ),
                      custom_button(
                        title: 'sign_up'.tr,
                        onTap: () {
                          hideFocusKeyBoard(context);

                          signInController.checkValidation().then(
                            (value) {
                              debugPrint(
                                  '1-1-1-1-1- Inside checkValidation ${value.toString()}');
                              if (value == true) {
                                showLoader(context);
                                signInController.phoneAuthentication().then(
                                  (valus) {
                                    debugPrint(
                                        '2-2-2-2-2- Inside phoneAuthentication ${valus.toString()}');
                                    if (valus.toString() == 'true') {
                                      gotoVerificationScreen();
                                    } else {
                                      hideLoader(context);
                                    }
                                  },
                                );
                              }
                            },
                          );
                        },
                      ),
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 70.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const login_screen(),
                                  ),
                                );
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'already_have_an_account'.tr,
                                        style: FontStyleUtility.h14(
                                            fontColor: ColorUtils.orangeLight,
                                            fontWeight: FWT.semiBold)),
                                    TextSpan(
                                      text: 'sign_in'.tr,
                                      style: FontStyleUtility.h14(
                                          fontColor: ColorUtils.primary,
                                          fontWeight: FWT.semiBold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

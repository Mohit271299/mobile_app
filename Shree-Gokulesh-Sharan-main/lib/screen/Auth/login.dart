// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:vaishnav_parivar/pagination/route_name.dart';
import 'package:vaishnav_parivar/screen/Auth/controller/logincontroller.dart';
import 'package:vaishnav_parivar/screen/Auth/registration.dart';
import 'package:vaishnav_parivar/screen/dashboard/dashboard_screen.dart';
import 'package:vaishnav_parivar/utils/asset_utils.dart';
import 'package:vaishnav_parivar/utils/color_utils.dart';
import 'package:vaishnav_parivar/utils/loader/page_loader.dart';

import '../../utils/txt_style.dart';
import '../../widgets/custom_feild_box.dart';

class login_screen extends StatefulWidget {
  const login_screen({Key? key}) : super(key: key);

  @override
  _login_screenState createState() => _login_screenState();
}

class _login_screenState extends State<login_screen> {
  final LoginController loginController =
      Get.put(LoginController(), tag: LoginController().toString());

  bool hide_pass = true;

  @override
  void dispose() {
    hideLoader(context);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GetBuilder<LoginController>(
      init: loginController,
      builder: (contexts) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            width: screenSize.width,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AssetUtils.back_png),
                  fit: BoxFit.fill,
                ),
              ),
              child: Container(
                height: screenSize.height,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                        height: (screenSize.height * 0.095).ceilToDouble()),
                    // Text((screenSize.height * 0.059).ceilToDouble().toString()),
                    Container(
                      alignment: Alignment.center,
                      child: Text('hello_again'.tr,
                          style: FontStyleUtility.h24(
                              fontColor: ColorUtils.dark_font,
                              fontWeight: FWT.semiBold)),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'sign_in_body'.tr,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: FontStyleUtility.h14(
                          fontColor: ColorUtils.dark_font.withOpacity(0.6),
                          fontWeight: FWT.semiBold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.059,
                    ),
                    CommonTextField(
                      labelText: 'enter_your_email'.tr,
                      textInputAction: TextInputAction.next,
                      hintText: 'enter_your_email'.tr,
                      textInputType: TextInputType.emailAddress,
                      controller: loginController.emailAddressController,
                      validator: (String? value) {},
                    ),
                    Obx(
                      () => (loginController.isEmailError.isTrue)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, bottom: 2.0),
                                child: Text(
                                  loginController.emailAddressError.value
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
                          : const Text(''),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: CommonTextField(
                        isObscureText: hide_pass,
                        controller: loginController.passwordController,
                        labelText: 'enter_your_password'.tr,
                        suffix_image: InkWell(
                          onTap: () {
                            if (hide_pass == true) {
                              setState(() {
                                hide_pass = false;
                              });
                            } else {
                              setState(() {
                                hide_pass = true;
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
                        textInputAction: TextInputAction.next,
                        validator: (String? value) {},
                        textInputType: TextInputType.visiblePassword,
                        hintText: 'enter_your_password'.tr,
                      ),
                    ),
                    Obx(
                      () => (loginController.isPasswordError.isTrue)
                          ? Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, bottom: 2.0),
                                child: Text(
                                  loginController.passwordError.value
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
                          : const Text(''),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Text(
                        'forgot_password'.tr,
                        style: FontStyleUtility.h12(
                            fontColor: ColorUtils.dark_font.withOpacity(0.6),
                            fontWeight: FWT.semiBold),
                      ),
                    ),
                    SizedBox(
                      height: screenSize.height * 0.059,
                    ),
                    Container(
                      child: custom_button(
                        title: 'login'.tr,
                        onTap: () {
                          showLoader(context);
                          loginController.checkEmailAndPassword().then(
                            (value) {
                              // hideLoader(context);
                              if (value == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const dashBoard_screen(),
                                  ),
                                );
                                Get.toNamed(BindingUtils.dashboard_route);
                              }
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 70.0),
                          child: Container(
                            height: 50.0,
                            width: 200,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const registration_screen(),
                                  ),
                                );
                                // Get.toNamed(BindingUtils.registraion_route);
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'don_have_account'.tr,
                                        style: FontStyleUtility.h14(
                                            fontColor: ColorUtils.orangeLight,
                                            fontWeight: FWT.semiBold)),
                                    TextSpan(
                                      text: 'sign_up'.tr,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

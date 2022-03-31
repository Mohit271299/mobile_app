import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:http/http.dart' as http;
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild.dart';
import 'package:magnet_update/custom_widgets/my_leading_icon_custom_button.dart';
import 'package:magnet_update/custom_widgets/dashboard_class_widget.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/loader/page_loader.dart';
import 'package:magnet_update/utils/preference.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class loginScreen extends StatefulWidget {
  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  void dispose() {
    // hideLoader(context);
    super.dispose();
  }

  final Login_screen_controller _loginScreenController =
      Get.put(Login_screen_controller(), tag: Login_screen_controller().toString());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;
  bool email = false;
  bool pass = false;
  bool isLoading = false;
  late ScaffoldMessengerState scaffoldMessenger;

  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Login_screen_controller>(
      init: _loginScreenController,
      builder: (_) {
        return Scaffold(
          backgroundColor: ColorUtils.scffoldBgColor,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 60),
                    child: Text(
                      'Welcome back!',
                      style: FontStyleUtility.h23(
                        fontColor: ColorUtils.blackColor,
                        fontWeight: FWT.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Login to your existent account of Magnet',
                      style: FontStyleUtility.h13(
                        fontColor: ColorUtils.ogfont,
                        fontWeight: FWT.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Image.asset(
                      AssetUtils.welcomeScreenPng,
                      height: MediaQuery.of(context).size.height / 3.2,
                      width: MediaQuery.of(context).size.width - 150,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Form(
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                                offset: Offset(0, 0),
                                spreadRadius: -8,
                              ),
                            ],
                            color: Colors.white,
                            border: (email == true
                                ? Border.all(
                                    color: ColorUtils.blueColor, width: 1.5)
                                : Border.all(
                                    color: Colors.transparent, width: 1)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.only(
                              left: 38, right: 38, top: 40),
                          child: CustomTextFieldWidgetNew(
                            onChanged: (value) {
                              if (value.length.toString() == '0' &&
                                  value.toString().isEmpty) {
                                setState(() {
                                  isEmailEmpty = false;
                                });
                              } else {
                                setState(() {
                                  isEmailEmpty = true;
                                });
                              }
                            },
                            onTap: () {
                              setState(() {
                                email = true;
                                pass = false;
                              });
                            },
                            controller: emailController,
                            labelText: 'Email',
                            icon_data: Icons.person_outline,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                blurRadius: 10,
                                offset: Offset(0, 0),
                                spreadRadius: -8,
                              ),
                            ],
                            color: ColorUtils.whiteColor,
                            border: (pass == true
                                ? Border.all(
                                    color: ColorUtils.blueColor, width: 1.5)
                                : Border.all(
                                    color: Colors.transparent, width: 1)),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.only(
                              left: 38, right: 38, top: 20),
                          child: CustomTextFieldWidgetNew(
                            isObscure: true,
                            onChanged: (value) {
                              if (value.length.toString() == '0' &&
                                  value.toString().isEmpty) {
                                setState(() {
                                  isPasswordEmpty = false;
                                });
                              } else {
                                setState(() {
                                  isPasswordEmpty = true;
                                });
                              }
                            },
                            onTap: () {
                              setState(() {
                                email = false;
                                pass = true;
                              });
                            },
                            controller: passwordController,
                            labelText: 'Password',
                            icon_data: Icons.password,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        const EdgeInsets.only(right: 38, top: 12, bottom: 30),
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontFamily: 'GR',
                          color: ColorUtils.blueColor),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 38, right: 38, top: 0),
                    child: MyLeadingItemCustomButtonWidgetHexColor(
                      backGroundColor:
                          (isEmailEmpty == true && isPasswordEmpty == true)
                              ? "#3B7AF1"
                              : "#9faabf",
                      textColor: "#F1F1F1",
                      borderColor:
                          (isEmailEmpty == true && isPasswordEmpty == true)
                              ? "#3B7AF1"
                              : "#9faabf",
                      leadingIcon: AssetUtils.locksvg,
                      title: 'Secure Login',
                      onTap: () {
                        if (emailController.text.toString().isNotEmpty &&
                            passwordController.text.toString().isNotEmpty &&
                            isEmailEmpty == true &&
                            isPasswordEmpty == true) {
                          login(context);
                        }
                        if (emailController.text.toString().isNotEmpty) {
                          if (!reg.hasMatch(emailController.text)) {
                            scaffoldMessenger.showSnackBar(const SnackBar(
                                content: Text("Enter Valid Email")));
                            return;
                          }
                        }
                      }, // Navigator.push(
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("By signing up you agree to the",
                            style: FontStyleUtility.h10(
                                fontColor: ColorUtils.ogfont,
                                fontWeight: FWT.semiBold)),
                        Text(
                          " Terms & Conditions",
                          style: FontStyleUtility.h10(
                              fontColor: ColorUtils.blueColor,
                              fontWeight: FWT.bold),
                        ),
                        Text(
                          " and",
                          style: FontStyleUtility.h10(
                              fontColor: ColorUtils.ogfont,
                              fontWeight: FWT.bold),
                        ),
                        Text(
                          " Privacy Policy",
                          style: FontStyleUtility.h10(
                              fontColor: ColorUtils.blueColor,
                              fontWeight: FWT.bold),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 25.0,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(top: 15, bottom: 57),
                    child: InkWell(
                      highlightColor: Colors.black,
                      onTap: () =>
                          Get.toNamed(BindingUtils.registrationScreenRoute),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?",
                              style: FontStyleUtility.h13(
                                  fontColor: ColorUtils.ogfont,
                                  fontWeight: FWT.semiBold)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            "Sign Up!",
                            style: FontStyleUtility.h13(
                                fontColor: ColorUtils.blueColor,
                                fontWeight: FWT.bold),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String? name ;
  Future login(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    showLoader(context);
    Map data = {
      'email': emailController.text,
      'password': passwordController.text
    };
    print(data);
    String body = json.encode(data);

    var url = Api_url.Login_api;

    var response = await http.post(
      Uri.parse(url),
      headers: {
        // "Accept": "application/json",
        'Content-Type': 'application/json'
      },
      body: body,
    );
    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      hideLoader(context);
      var final_decode = jsonDecode(response.body); // .replaceAll('}[]', '}')

      print('Seccess');

      var token = final_decode["data"]["token"].toString();
      print(token);

      var User = final_decode["data"]["user"];
      print(User);
      var Step = User["step"].toString();
      print(Step);
      (Step == "company"
          ? Get.offAllNamed(BindingUtils.add_company)
          : (Step == "plan"
              ? Get.offAllNamed(BindingUtils.subscriptionRoute)
              : Get.offAll(DashboardPage(0))));
      // Get.offAllNamed(BindingUtils.dashBoardScreenRoute);

      await PreferenceManager().setPref(Api_url.token, token);
      await PreferenceManager().setPref(Api_url.user_id, User["id"].toString());
      debugPrint(
          '1-1-1-1-1 Inside the login screen ${User["role"].toString()}');
      await PreferenceManager()
          .setPref(Api_url.user_role, User["role"].toString());
      await PreferenceManager()
          .setPref(Api_url.account_id, User["account_id"].toString());
      await PreferenceManager()
          .setPref('First_name', User["first_name"].toString());
      await PreferenceManager()
          .setPref('Last_name', User["last_name"].toString());
      await PreferenceManager()
          .setPref('Profile_image', User["profile_image"].toString());
      await PreferenceManager()
          .setPref('Email', User["email"].toString());
      await PreferenceManager()
          .setPref('Contact_no', User["contact_no"].toString());


      await PreferenceManager().setPref('Role', User["role"].toString());

      name = await PreferenceManager().getPref('First_name');
      print(name);

    } else {
      hideLoader(context);
      Fluttertoast.showToast(
          msg: 'Invalid email or password.',
          backgroundColor: Colors.black38,
          textColor: Colors.white,
          gravity: ToastGravity.BOTTOM,
          toastLength: Toast.LENGTH_LONG);
      print("error");
    }
  }
}

import 'dart:convert';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:http/http.dart' as http;
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/controller/controllers_class.dart';
import 'package:magnet_update/custom_widgets/custom_textfeild_two.dart';
import 'package:magnet_update/custom_widgets/my_leading_icon_custom_button.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/loader/page_loader.dart';
import 'package:magnet_update/utils/text_style_utils.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:shared_preferences/shared_preferences.dart';

class registrationScreen extends StatefulWidget {
  const registrationScreen({Key? key}) : super(key: key);

  @override
  _registrationScreenState createState() => _registrationScreenState();
}

class _registrationScreenState extends State<registrationScreen> {
  @override
  void dispose() {
    hideLoader(context);
    super.dispose();
  }

  final _formkey = GlobalKey<FormState>();

  // final _auth = FirebaseAuth.instance;
  String dialCodedigits = "+00";

  bool isLoading = false;
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  PageController? _pageController;

  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final cnameController = TextEditingController();
  final unameController = TextEditingController();
  final acnameController = TextEditingController();
  final plan_detail_Controller = TextEditingController();
  final mobileController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool isFirstNameEmpty = false;
  bool isLastNameEmpty = false;
  bool isPhoneNumberEmpty = false;
  bool isEmailAddressEmpty = false;
  bool isPasswordEmpty = false;
  bool isConfirmPasswordEmpty = false;

  // postDetailsToFirestore() async {
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = _auth.currentUser;
  //
  //   UserModel userModel = UserModel();
  //
  //   userModel.email = user!.email;
  //   userModel.uid = user.uid;
  //   userModel.firstname = fnameController.text;
  //   userModel.lastname = lnameController.text;
  //
  //   await firebaseFirestore
  //       .collection("users")
  //       .doc(user.uid)
  //       .set(userModel.toMap());
  //   Fluttertoast.showToast(msg: 'Account created');
  //
  //   Navigator.pushAndRemoveUntil(
  //       context,
  //       MaterialPageRoute(builder: (context) => createUser()),
  //           (route) => false);
  // }

  // sigUp(String email, String password) async {
  //   await _auth
  //       .createUserWithEmailAndPassword(email: email, password: password)
  //       .then((value) => {postDetailsToFirestore()})
  //       .catchError((e) {
  //     Fluttertoast.showToast(msg: e!.message);
  //   });
  // }
  final Registration_screen_controller _registrationScreenController =
      Get.find(tag: Registration_screen_controller().toString());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: false);
    plan_detail_Controller.text = 'Trail';
  }

  final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();
  final TextEditingController _pinOTPController = TextEditingController();
  final FocusNode _pinOTPFocus = FocusNode();
  String? varification;

  final BoxDecoration pinOTPDecoration = BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          blurRadius: 10,
          offset: Offset(0, 0),
          spreadRadius: -8,
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: ColorUtils.blueColor,
      ));
  final BoxDecoration pinOTPDecoration2 = BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          blurRadius: 10,
          offset: Offset(0, 0),
          spreadRadius: -8,
        ),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Colors.transparent,
      ));

  verifyPhonenumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: "${dialCodedigits + mobileController.text}",
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              signup(context);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: const Duration(seconds: 10),
          ));
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            varification = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            varification = verificationId;
          });
        },
        timeout: const Duration(seconds: 60));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.scffoldBgColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: GetBuilder<Registration_screen_controller>(
            init: _registrationScreenController,
            builder: (_) {
              return PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 60),
                            child: Text("Let's get Started",
                                style: FontStyleUtility.h23(
                                    fontColor: ColorUtils.blackColor,
                                    fontWeight: FWT.bold))),
                        Container(
                            margin: const EdgeInsets.only(top: 15),
                            child: Text(
                                'Create an account to Magnet to get all features',
                                style: FontStyleUtility.h13(
                                    fontColor: ColorUtils.ogfont,
                                    fontWeight: FWT.bold))),
                        Form(
                          key: _formkey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 38, right: 38, top: 20),
                                child: CommonTextFormField(
                                  onChanged: (value) {
                                    if (value.length.toString() == '0' &&
                                        value.toString().isEmpty) {
                                      setState(() {
                                        isFirstNameEmpty = false;
                                      });
                                    } else {
                                      setState(() {
                                        isFirstNameEmpty = true;
                                      });
                                    }
                                  },
                                  controller: fnameController,
                                  labelText: 'First name',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 38, right: 38, top: 20),
                                child: CommonTextFormField(
                                  onChanged: (value) {
                                    if (value.length.toString() == '0' &&
                                        value.toString().isEmpty) {
                                      setState(() {
                                        isLastNameEmpty = false;
                                      });
                                    } else {
                                      setState(() {
                                        isLastNameEmpty = true;
                                      });
                                    }
                                  },
                                  controller: lnameController,
                                  labelText: 'Last name',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 38, right: 38, top: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CountryCodePicker(
                                      onChanged: (country) {
                                        setState(() {
                                          dialCodedigits = country.dialCode!;
                                        });
                                      },
                                      initialSelection: "IN",
                                      showCountryOnly: false,
                                      showOnlyCountryWhenClosed: false,
                                      favorite: ["+1", "US", "+91", "IN"],
                                    ),
                                    Container(
                                      height: 25,
                                      child: const VerticalDivider(
                                        color: Colors.black87,
                                      ),
                                    ),
                                    Expanded(
                                      child: CommonTextFormField(
                                        onChanged: (value) {
                                          if (value.length.toString() == '0' &&
                                              value.toString().isEmpty) {
                                            setState(() {
                                              isPhoneNumberEmpty = false;
                                            });
                                          } else {
                                            setState(() {
                                              isPhoneNumberEmpty = true;
                                            });
                                          }
                                        },
                                        controller: mobileController,
                                        keyboardType: TextInputType.number,
                                        labelText: 'Phone number',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 38, right: 38, top: 20),
                                child: CommonTextFormField(
                                  onChanged: (value) {
                                    if (value.length.toString() == '0' &&
                                        value.toString().isEmpty) {
                                      setState(() {
                                        isEmailAddressEmpty = false;
                                      });
                                    } else {
                                      setState(() {
                                        isEmailAddressEmpty = true;
                                      });
                                    }
                                  },
                                  controller: emailController,
                                  labelText: 'Email Address ',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 38, right: 38, top: 20),
                                child: CommonTextFormField(
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
                                  controller: passwordController,
                                  labelText: 'Password ',
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 38, right: 38, top: 20),
                                child: CommonTextFormField(
                                  onChanged: (value) {
                                    if (value.length.toString() == '0' &&
                                        value.toString().isEmpty) {
                                      setState(() {
                                        isConfirmPasswordEmpty = false;
                                      });
                                    } else {
                                      setState(() {
                                        isConfirmPasswordEmpty = true;
                                      });
                                    }
                                  },
                                  controller: confirmpasswordController,
                                  labelText: 'Confirm password',
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 38, right: 38, top: 20),
                          child: MyLeadingItemCustomButtonWidgetHexColor(
                            backGroundColor: (isFirstNameEmpty == true &&
                                    isLastNameEmpty == true &&
                                    isPhoneNumberEmpty == true &&
                                    isEmailAddressEmpty == true &&
                                    isPasswordEmpty == true &&
                                    isConfirmPasswordEmpty == true)
                                ? "#3B7AF1"
                                : "#9faabf",
                            textColor: "#F1F1F1",
                            borderColor: (isFirstNameEmpty == true &&
                                    isLastNameEmpty == true &&
                                    isPhoneNumberEmpty == true &&
                                    isEmailAddressEmpty == true &&
                                    isPasswordEmpty == true &&
                                    isConfirmPasswordEmpty == true)
                                ? "#3B7AF1"
                                : "#9faabf",
                            leadingIcon: AssetUtils.locksvg,
                            title: 'Secure Sign Up',
                            onTap: () {
                              if (isLoading) {
                                return;
                              }
                              if (fnameController.text.isEmpty ||
                                  lnameController.text.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Please Enter both First and Last name")));
                                return;
                              }
                              if (!reg.hasMatch(emailController.text)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Enter Valid Email")));
                                return;
                              }
                              if (passwordController.text !=
                                  confirmpasswordController.text) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Password does not Match")));
                                return;
                              }
                              if (passwordController.text.isEmpty ||
                                  passwordController.text.length < 6) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Password should be min 6 characters")));
                                return;
                              }
                              verifyPhonenumber();
                              _registrationScreenController
                                  .pageIndexUpdate('02');

                              _pageController!.jumpToPage(1);

                              // signup();
                            }, // Navigator.push(
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, bottom: 0),
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
                          height: 25,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(top: 15, bottom: 57),
                          child: InkWell(
                            highlightColor: Colors.transparent,
                            onTap: () =>
                                Get.toNamed(BindingUtils.loginScreenRoute),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account?",
                                    style: FontStyleUtility.h13(
                                        fontColor: ColorUtils.ogfont,
                                        fontWeight: FWT.semiBold)),
                                const SizedBox(
                                  width: 5,
                                ),
                                InkWell(
                                    onTap: () {
                                      // if(isLoading)
                                      // {
                                      //   return;
                                      // }
                                      // if(emailController.text.isEmpty||passwordController.text.isEmpty)
                                      // {
                                      //   scaffoldMessenger.showSnackBar(SnackBar(content:Text("Please Fill all fileds")));
                                      //   return;
                                      // }
                                      // login(emailController.text,passwordController.text);
                                      // setState(() {
                                      //   isLoading=true;
                                      // });
                                    },
                                    child: Text(
                                      "Log in",
                                      style: FontStyleUtility.h13(
                                          fontColor: ColorUtils.blueColor,
                                          fontWeight: FWT.bold),
                                    ))
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 50, left: 30),
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: ColorUtils.ogfont, width: 1),
                              color: ColorUtils.whiteColor),
                          child: InkWell(
                            onTap: () => _pageController!.jumpToPage(0),
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 13, horizontal: 10),
                                child: SvgPicture.asset(
                                  AssetUtils.back_svg,
                                )),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 50, left: 30),
                          child: Text(
                            'OTP Verification',
                            style: FontStyleUtility.h23(
                              fontColor: ColorUtils.blackColor,
                              fontWeight: FWT.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          child: RichText(
                            text: TextSpan(
                                text: 'Enter the OTP sent to',
                                style: FontStyleUtility.h14(
                                    fontColor: ColorUtils.ogfont,
                                    fontWeight: FWT.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        " ${dialCodedigits} -${mobileController.text}",
                                    style: FontStyleUtility.h14(
                                        fontColor: ColorUtils.blackColor,
                                        fontWeight: FWT.bold),
                                  )
                                ]),
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 30, right: 30),
                          child: PinPut(
                            fieldsCount: 6,
                            textStyle: TextStyle(
                                fontSize: 15, color: ColorUtils.blackColor),
                            eachFieldHeight: 40,
                            eachFieldWidth: 40,
                            focusNode: _pinOTPFocus,
                            controller: _pinOTPController,
                            submittedFieldDecoration: pinOTPDecoration,
                            selectedFieldDecoration: pinOTPDecoration,
                            followingFieldDecoration: pinOTPDecoration2,
                            pinAnimationType: PinAnimationType.rotation,
                            onSubmit: (pin) async {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithCredential(
                                        PhoneAuthProvider.credential(
                                            verificationId: varification!,
                                            smsCode: pin))
                                    .then((value) {
                                  if (value.user != null) {
                                    signup(context);
                                  }
                                });
                              } catch (e) {
                                FocusScope.of(context).unfocus();
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text('invalid otp'),
                                  duration: Duration(seconds: 3),
                                ));
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        // Container(
                        //   margin: const EdgeInsets.only(left: 30, right: 30),
                        //   child: MyLeadingItemCustomButtonWidget(
                        //     leadingIcon: AssetUtils.locksvg,
                        //     title: 'Save',
                        //     alignment: Alignment.center,
                        //     onTap: () async {
                        //       dynamic pin;
                        //       try {
                        //         await FirebaseAuth.instance
                        //             .signInWithCredential(
                        //                 PhoneAuthProvider.credential(
                        //                     verificationId: varification!,
                        //                     smsCode: pin))
                        //             .then((value) {
                        //           if (value.user != null) {
                        //             signup(context);
                        //           }
                        //         });
                        //       } catch (e) {
                        //         FocusScope.of(context).unfocus();
                        //         ScaffoldMessenger.of(context)
                        //             .showSnackBar(const SnackBar(
                        //           content: Text('invalid otp'),
                        //           duration: Duration(seconds: 3),
                        //         ));
                        //       }
                        //     },
                        //   ),
                        // ),
                      ],
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }

  Future signup(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    showLoader(context);
    print("Calling");

    Map data = {
      "account_uid": "",
      "business_details": "",
      "subscription_details": "",
      "app_referral_code": "",

      'first_name': fnameController.text,
      'last_name': lnameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'account_name': acnameController.text,
      'contact_no': mobileController.text,
      'plan': 'trial',
      // 'firebaseuid': '',
      'username': DateTime.now().toString(),
      "verify_otp": true,
      "firebase_uid": "string",
      // "account_uid": "string",
      // "first_name": "string",
      // "last_name": "string",
      // "password": "string",
      // "account_name": "string",
      // "email": "string",
      // "contact_no": "string",
      // "business_details": "string",
      // "subscription_details": "string",
      // "plan": "string",
      // "app_referral_code": "string",
      // "account_referral_code": "string",
      // "verify_otp": true
      // firebaseUid,
      // username,
      // otp
    };
    print(data);

    String body = json.encode(data);
    var url = Api_url.Registration_api;
    var response = await http.post(
      Uri.parse(url),
      headers: {
        // "Accept": "application/json",
        'Content-Type': 'application/json'
      },
      body: body,
      // encoding: Encoding.getByName("utf-8")
    );

    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 201) {
      Get.offAllNamed(BindingUtils.subscriptionRoute);

      print('Seccess');

      var data = json.decode(response.body);
      var user = data['data'];

      print(user);

      // savePref(1, user['first_name'], user['last_name'], user['email'],
      //     user['contact_no'], user['id']);
    } else {
      hideLoader(context);
      print("error");
    }
  }

  savePref(int value, String fname, String lname, String email, String contact,
      int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setInt("value", value);
    preferences.setString("first_name", fname);
    preferences.setString("last_name", lname);
    preferences.setString("email", email);
    preferences.setString("contact_no", contact);
    preferences.setString("id", id.toString());
    preferences.commit();
  }
}

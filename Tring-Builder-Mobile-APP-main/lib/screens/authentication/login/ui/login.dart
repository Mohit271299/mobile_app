import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tring/common/Texts.dart';
import 'package:tring/common/common_color.dart';
import 'package:tring/common/common_image.dart';
import 'package:tring/common/common_routing.dart';
import 'package:tring/common/common_style.dart';
import 'package:tring/common/common_textformfield.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/common/loader/page_loader.dart';
import 'package:tring/screens/authentication/login/controller/logincontroller.dart';
import 'package:tring/screens/authentication/login/model/LoginModel.dart';
import 'package:tring/screens/initialization/create_user.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  _loginScreenState createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  late LoginModel loginModel;
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  void logIn(String email, String password) async {
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((uid) => {
              Fluttertoast.showToast(msg: 'Login succ;'),
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const createUser()))
            })
        .catchError((e) {
      Fluttertoast.showToast(msg: e!.message);
    });
  }

  late double screenHeight, screenWidth;

  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: HexColor(CommonColor.appBackColor),
      body: SafeArea(
        child: InkWell(
          hoverColor: HexColor(CommonColor.appBackColor),
          highlightColor: HexColor(CommonColor.appBackColor),
          focusColor: HexColor(CommonColor.appBackColor),
          splashColor: HexColor(CommonColor.appBackColor),
          onTap: () => CommonWidget().hideFocusKeyBoard(context),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60.0),
                  child: Text(
                    Texts.welcome_back,
                    style: headerStyle(),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: Text(
                    Texts.login_body,
                    style: subHeaderStyle(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: (screenHeight * 0.1).ceilToDouble(),
                  ),
                  child: Image.asset(
                    CommonImage.login_back,
                    height: screenHeight * 0.24,
                    width: screenWidth,
                    fit: BoxFit.fill,
                  ),
                ),
                // Text('${(screenHeight * 0.035).ceilToDouble()}'.toString()),
                SizedBox(
                  height: (screenHeight * 0.082).ceilToDouble(),
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: <Widget>[
                      CommonTextField(
                        textInputAction: TextInputAction.next,
                        controller: loginController.emailOrPhoneController,
                        hintText: Texts.emailOrPhone,
                        icon: CommonImage.email_phone_icon,
                        validator: (value) {},
                        textInputType: TextInputType.text,
                      ),
                      Obx(
                        () =>
                            (loginController.isEmailOrPhoneError.value == true)
                                ? CommonWidget().showErrorMessage(
                                    errorMessage: loginController
                                        .emailOrPhoneError.value
                                        .toString())
                                : Container(
                                    padding: const EdgeInsets.only(top: 5.0),
                                  ),
                      ),
                      CommonTextFieldPassword(
                        textInputAction: TextInputAction.done,
                        controller: loginController.passwordController,
                        hintText: Texts.password,
                        icon: CommonImage.password_icon,
                        validator: (value) {},
                        textInputType: TextInputType.visiblePassword,
                        isObscureText: true,
                      ),
                      Obx(
                        () => (loginController.isPasswordError.value == true)
                            ? CommonWidget().showErrorMessage(
                                errorMessage: loginController
                                    .passwordError.value
                                    .toString())
                            : Container(
                                padding: const EdgeInsets.only(top: 5.0),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          right: 38.0,
                        ),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(Texts.forgotpassword,
                              style: forgotPasswordStyle()),
                        ),
                      ),
                      SizedBox(
                        height: (screenHeight * 0.035).ceilToDouble(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 38.0, right: 38.0, top: 0.0, bottom: 0.0),
                        child: CommonWidget().iconButton(
                          onPress: () =>
                              loginController.validateValue().then((value) {
                            debugPrint(
                                'ValidateValue Values ${value.toString()}');
                            if (value == true) {
                              showLoader(context);
                              CommonWidget().hideFocusKeyBoard(context);
                              Map params = {
                                'email': loginController
                                    .emailOrPhoneController.text
                                    .trim()
                                    .toString(),
                                'password': loginController
                                    .passwordController.text
                                    .trim()
                                    .toString(),
                              };
                              loginController
                                  .checkLogin(context, params)
                                  .then((value) {
                                    debugPrint('1-1-1-1-1-1 Inside the Api Repsonse ${value.toString()}');
                                if (value != null) {
                                  if(value != 'fail'){
                                    hideLoader(context);
                                    loginModel = value;
                                    gotoDashboardScreen(context);
                                  }

                                }
                              });
                            }
                          }),
                          context: context,
                          buttonLabel: Texts.secure_login,
                          buttonIcon: CommonImage.password_lock,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "By signing up you agree to the",
                              style: noteColor(),
                            ),
                            Text(
                              " Terms & Conditions",
                              style: noteActiveColor(),
                            ),
                            Text(
                              " and",
                              style: noteColor(),
                            ),
                            Text(
                              " Privacy Policy",
                              style: noteActiveColor(),
                            )
                          ],
                        ),
                      ),
                      Container(

                        margin: const EdgeInsets.only(top: 15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              Texts.dont_account,
                              style: dontColor(),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),

                            Container(
                              height: 30,
                              width: 50,
                              child: InkWell(
                                focusColor: HexColor(CommonColor.appBackColor),
                                hoverColor: HexColor(CommonColor.appBackColor),
                                highlightColor: HexColor(CommonColor.appBackColor),
                                splashColor: HexColor(CommonColor.appBackColor),
                                onTap: ()=> gotoSignUpScreen(),
                                child: Text(
                                  Texts.signUp,
                                  style: dontColorActive(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

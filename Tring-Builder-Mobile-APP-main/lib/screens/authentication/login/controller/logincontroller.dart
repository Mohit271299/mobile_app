import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tring/AppDetails.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/common/loader/page_loader.dart';
import 'package:tring/screens/authentication/login/model/LoginModel.dart';
import 'package:tring/service/commonservice.dart';

class LoginController extends GetxController {
  RxString emailOrPhoneError = ''.obs;
  RxBool isEmailOrPhoneError = false.obs;
  RxBool isPasswordError = false.obs;
  Rx passwordError = ''.obs;
  var loginModelList = LoginModel().obs();
  LoginModel? loginModel;
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String msg = '';
  RxBool checkitisNumber = false.obs;

  bool _isNumeric(String result) {
    if (result == null) {
      return false;
    }
    return double.tryParse(result) != null;
  }

  checkTextInputData({required String checkValue}) {
    if (_isNumeric(checkValue) == true) {
      checkitisNumber(true);
    } else {
      checkitisNumber(false);
    }
  }

  Future<dynamic> validateValue() async {
    isEmailOrPhoneError(false);
    isPasswordError(false);
    if (emailOrPhoneController.text.isEmpty) {
      isEmailOrPhoneError(true);
      emailOrPhoneError.value = "Please enter email or phone number.";
      return false;
    } else if (passwordController.text.trim().isEmpty) {
      isPasswordError(true);
      passwordError.value = "Please enter your password.";
      return false;
    } else if (emailOrPhoneController.text.isNotEmpty) {
      checkTextInputData(
          checkValue: emailOrPhoneController.text.trim().toString());
      if (checkitisNumber.value == true) {
        if (emailOrPhoneController.text.length < 10 ||
            emailOrPhoneController.text.length > 10) {
          isEmailOrPhoneError(true);
          emailOrPhoneError.value = "Please enter phone number.";
        }
        return false;
      } else {
        final bool isValid = EmailValidator.validate(
            emailOrPhoneController.text.trim().toString());
        if (!isValid) {
          isEmailOrPhoneError(true);
          emailOrPhoneError.value = "Please enter valid email address.";
          return false;
        }
        return true;
      }
    } else {
      return true;
    }
  }

  Future<dynamic> checkLogin(BuildContext context, params) async {
    String url = (URLConstants.base_url + URLConstants.getsignin);
    debugPrint('0-0-0-0-0-0-0 Params ${params.toString()}');
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: params,
      );
      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');

      var data = convert.jsonDecode(response.body);
      print('Response body: ${response.body}');
      msg = data["message"].toString();
      if (response.statusCode == 200 || response.statusCode == 201) {
        final status = data["success"];
        if (status == true) {
          CommonWidget().showToaster(msg: "login successfully.");
          loginModel = LoginModel.fromJson(data);
          CommonService().setStoreKey(
              setKey: 'token', setValue: loginModel!.data!.token.toString());
          CommonService().setStoreKey(
              setKey: 'id', setValue: loginModel!.data!.user!.id.toString());
          CommonService().setStoreKey(
              setKey: 'name',
              setValue: loginModel!.data!.user!.name.toString());
          CommonService().setStoreKey(
              setKey: 'email',
              setValue: loginModel!.data!.user!.email.toString());

          CommonService().setStoreKey(
              setKey: 'phone_number',
              setValue: loginModel!.data!.user!.phoneNumber.toString());
          CommonService().setStoreKey(
              setKey: 'role',
              setValue: loginModel!.data!.user!.role.toString());
          // CommonService().setStoreKey(
          //     setKey: 'uid', setValue: loginModel!.data!.user!.uid.toString());
          // CommonService().setStoreKey(
          //     setKey: 'projectId',
          //     setValue: loginModel!.data!.user!.projectId.toString());
          // CommonService().setStoreKey(
          //     setKey: 'profile_image',
          //     setValue: loginModel!.data!.user!.profileImage.toString());
          return loginModel;
        } else {
          CommonWidget().showToaster(msg: msg.toString());
          return 'fail';
        }
      } else if (response.statusCode == 422) {

        CommonWidget().showToaster(msg: msg.toString());
        return 'fail';
      } else {
        CommonWidget().showToaster(msg: msg.toString());
        return 'fail';
      }
    } catch (e) {
      CommonWidget().showToaster(msg: msg.toString());
      print('0-0-0-0-0-0- SignIn Error :- ${e.toString()}');
    }
  }




  // logout
  Future<dynamic> logoutUser(BuildContext context) async {
    // hideLoader(context);
    CommonService().logoutSuccessfully(context);
  }
  //   isEmailOrPhoneError(false);
  //   isPasswordError(false);
  //   if (emailOrPhoneController.text.isEmpty) {
  //     isEmailOrPhoneError(true);
  //     emailOrPhoneError.value = "Please enter email or phone number.";
  //     return false;
  //   } else if (passwordController.text.trim().isEmpty) {
  //     isPasswordError(true);
  //     passwordError.value = "Please enter your password.";
  //     return false;
  //   } else if (emailOrPhoneController.text.isNotEmpty) {
  //     checkTextInputData(
  //         checkValue: emailOrPhoneController.text.trim().toString());
  //     if (checkitisNumber.value == true) {
  //       if (emailOrPhoneController.text.length < 10 ||
  //           emailOrPhoneController.text.length > 10) {
  //         isEmailOrPhoneError(true);
  //         emailOrPhoneError.value = "Please enter phone number.";
  //       }
  //       return false;
  //     } else {
  //       final bool isValid = EmailValidator.validate(
  //           emailOrPhoneController.text.trim().toString());
  //       if (!isValid) {
  //         isEmailOrPhoneError(true);
  //         emailOrPhoneError.value = "Please enter valid email address.";
  //         return false;
  //       }
  //       return true;
  //     }
  //   } else {
  //     return true;
  //   }
  // }
}

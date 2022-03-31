import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaishnav_parivar/AppDetails.dart';
import 'package:vaishnav_parivar/Common/toast_util.dart';
import 'package:vaishnav_parivar/main.dart';
import 'package:vaishnav_parivar/pagination/route_name.dart';
import 'package:vaishnav_parivar/services/service.dart';

class SignInController extends GetxController {
  String pageIndex = '01';

  @override
  void onInit() {
    // ref = FirebaseDatabase.instance.ref();
    super.onInit();
  }

  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }

  RxString selectCountryCode = '+91'.obs;
  RxBool isUserNameError = false.obs;
  RxBool isEmailError = false.obs;
  RxBool isPhoneNumberError = false.obs;
  RxBool isPasswordError = false.obs;
  RxBool isConfirmPasswordError = false.obs;

  RxString userNameErrorMessage = ''.obs;
  RxString emailAddressErrorMessage = ''.obs;
  RxString mobileNoErrorMessage = ''.obs;
  RxString passwordErrorMessage = ''.obs;
  RxString confirmPasswordErrorMessage = ''.obs;
  RxString otpSendToken = ''.obs;
  RxString userAuthToken = ''.obs;

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController countryCodeController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  cleanAll() {
    userNameController.clear();
    emailController.clear();
    countryCodeController.clear();
    phoneNoController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  Future<bool> checkValidation() async {
    isUserNameError.value = false;
    isEmailError.value = false;
    isPhoneNumberError.value = false;
    isPasswordError.value = false;
    isConfirmPasswordError.value = false;
    if (userNameController.text.toString().isEmpty) {
      isUserNameError.value = true;
      userNameErrorMessage.value = "Please enter your username.";
    }
    if (emailController.text.toString().isEmpty) {
      isEmailError.value = true;
      emailAddressErrorMessage.value = "Please enter your email address.";
    } else if (emailController.text.toString().isNotEmpty) {
      bool isValid =
          EmailValidator.validate(emailController.text.toString().trim());
      if (isValid == false) {
        isEmailError.value = true;
        emailAddressErrorMessage.value =
            "Please enter your valid email address.";
      } else {
        isEmailError.value = false;
      }
    }
    if (phoneNoController.text.toString().isEmpty) {
      isPhoneNumberError.value = true;
      mobileNoErrorMessage.value = "Please enter your mobile number.";
    } else if (phoneNoController.text.toString().isNotEmpty) {
      if (int.parse(phoneNoController.text.length.toString()) != 10) {
        isPhoneNumberError.value = true;
        mobileNoErrorMessage.value = "Please enter your valid mobile number.";
      } else {
        isPhoneNumberError.value = false;
      }
    }
    if (passwordController.text.toString().isEmpty) {
      isPasswordError.value = true;
      passwordErrorMessage.value = "Please enter your password.";
    }
    if (confirmPasswordController.text.toString().isEmpty) {
      isConfirmPasswordError.value = true;
      confirmPasswordErrorMessage.value = "Please enter your confirm password.";
    } else if (confirmPasswordController.text.toString().isNotEmpty) {
      if (passwordController.text.toString().trim() !=
          confirmPasswordController.text.toString().trim()) {
        isConfirmPasswordError.value = true;
        confirmPasswordErrorMessage.value = "Confirm password not match.";
      } else {
        isConfirmPasswordError.value = false;
      }
    }

    if (isUserNameError.isFalse &&
        isEmailError.isFalse &&
        isPhoneNumberError.isFalse &&
        isPasswordError.isFalse &&
        isConfirmPasswordError.isFalse) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool?> phoneAuthentication() async {
    try {
      debugPrint('1-1-1-1 Inside Phone Authentications');
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber:
            "${selectCountryCode.value.toString() + phoneNoController.text.toString()}",
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          debugPrint('0-0-0-0-0 Inside VerificationFailed ${e.toString()}');
        },
        codeSent: (String verificationId, int? resendToken) {
          debugPrint('1-1-1-1 Inside Code Send ${verificationId.toString()}');
          otpSendToken.value = verificationId.toString();
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: const Duration(minutes: 2),
      );
      return true;
    } catch (e) {
      debugPrint('10-10-10-10 Error Send OTP ${e.toString()}');
      ToastUtils.showFailed(
          message: 'Something went to wrong,Please try again');
      return false;
    }
  }

// store password and email
  Future<bool?> authEmailPasswordStore() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.toString().trim(),
        password: passwordController.text.toString().trim(),
      );
      userAuthToken.value = userCredential.user!.uid.toString();
      Service().storeData(
          key: 'userUid', values: userCredential.user!.uid.toString());

      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        ToastUtils.showFailed(
            message:
                'The password provided is too weak.Please enter strong password.');
        return false;
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        ToastUtils.showFailed(
            message: 'The account already exists for that email.');
        return false;
      }
      debugPrint('3-3-3-3-3-3- Error ${e.toString()}');
      return false;
    } catch (e) {
      ToastUtils.showFailed(message: 'Something went wrong.Please try again');
      print('Error :- ${e.toString()}');
      return false;
    }
  }

  Future<bool?> checkOTP({required String otp}) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: otpSendToken.toString(), smsCode: otp),
      )
          .then((value) {
        debugPrint('202020202 Value ${value.toString()}');
        if (value.user != null) {
        } else {
          ToastUtils.showFailed(
              message: 'OTP did not match please check again');
        }
      });
      return true;
    } catch (e) {
      debugPrint('123123 ${e.toString()}');
      if (e.toString() ==
          "[firebase_auth/session-expired] The sms code has expired. Please re-send the verification code to try again.") {
        ToastUtils.showFailed(
            message:
                'The sms code has expired. Please re-send the verification code to try again.');
        return false;
      } else if (e.toString() ==
          "[firebase_auth/invalid-verification-code] The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user.") {
        ToastUtils.showFailed(message: 'Invalid OTP');
      } else {
        ToastUtils.showFailed(message: 'Something went wrong.Please try again');
        return false;
      }
    }
  }
  final firestoreInstance = FirebaseFirestore.instance;

  // store the realtime data base
  Future<bool?> storeUserInformations() async {

    DatabaseReference ref = await FirebaseDatabase.instance.reference();
    var data = await ref
        .child(AppDetails.dbUser)
        .child(userAuthToken.value.toString())
        .set({
      "id": '1',
      "uid": userAuthToken.value.toString(),
      "name": userNameController.text.toString().trim(),
      "mobile_no": phoneNoController.text.toString().trim(),
      "country_code": selectCountryCode.value.toString(),
      "email_id": emailController.text.toString().trim(),
      "password": passwordController.text.toString().trim(),
      "address": '',
      "city": '',
      "state": '',
      "country": '',
      "is_admin": false,
      "created_at": DateTime.now().toString(),
    }).then((values) {
      // Get.offAllNamed(BindingUtils.dashboard_route);
    });
    debugPrint('03-03-03-03-03 Auth ${data.toString()}');
    // var keys = ref.child(AppDetails.nToken).push().key;
    // await ref.child('Sate').ref;
    firestoreInstance.collection(AppDetails.nToken).add({
      "fcmToken": MyAppState.getToken.toString(),
      "deviceId": MyAppState.deviceID.toString(),
      "userUid": userAuthToken.value.toString(),
    }).then((value) {
      Get.offAllNamed(BindingUtils.dashboard_route);
    });
    // var datas = await ref.child(AppDetails.nToken).child(keys.toString()).set({
    //   "fcmToken": MyAppState.getToken.toString(),
    //   "deviceId": MyAppState.deviceID.toString(),
    //   "userUid": userAuthToken.value.toString(),
    //   "mobileNo": phoneNoController.text.toString().trim(),
    //   "isAllow": true,
    //   "createAt": DateTime.now().toString(),
    // }).then((values) {
    //   Get.offAllNamed(BindingUtils.dashboard_route);
    // });
  }

// Future<bool?> storeUserInformations() async {
//   DatabaseReference ref = await FirebaseDatabase.instance.reference();
//   var data = await ref
//       .child(AppDetails.dbUser)
//       .child(phoneNoController.text.toString().trim())
//       .set({
//     "id": '1',
//     "uid": userAuthToken.value.toString(),
//     "name": userNameController.text.toString().trim(),
//     "mobile_no": phoneNoController.text.toString().trim(),
//     "country_code": selectCountryCode.value.toString(),
//     "email_id": emailController.text.toString().trim(),
//     "password": passwordController.text.toString().trim(),
//     "address": '',
//     "city": '',
//     "state": '',
//     "country": '',
//     "is_admin": false,
//     "created_at": DateTime.now().toString(),
//   }).then((values) {
//     // Get.offAllNamed(BindingUtils.dashboard_route);
//   });
//   var datas = await ref.child(AppDetails.nToken).set({
//     "id": MyAppState.getToken.toString(),
//     "deviceId": MyAppState.deviceID.toString(),
//     "userUid": userAuthToken.value.toString(),
//     "mobileNo": phoneNoController.text.toString().trim(),
//     "isAllow": true,
//     "createAt": DateTime.now(),
//   }).then((values) {
//     Get.offAllNamed(BindingUtils.dashboard_route);
//   });
//   debugPrint('03-03-03-03-03 Auth ${data.toString()}');
// }
}

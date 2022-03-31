import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vaishnav_parivar/AppDetails.dart';
import 'package:vaishnav_parivar/main.dart';
import 'package:vaishnav_parivar/services/service.dart';
import 'package:vaishnav_parivar/utils/loader/page_loader.dart';

class LoginController extends GetxController {
  RxString emailAddressError = ''.obs;
  RxString passwordError = ''.obs;
  RxBool isEmailError = false.obs;
  RxBool isPasswordError = false.obs;

  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final firestoreInstance = FirebaseFirestore.instance;

  // ignore: body_might_complete_normally_nullable
  Future<bool?> checkEmailAndPassword() async {
    DatabaseReference ref = await FirebaseDatabase.instance.reference();
    isEmailError.value = false;
    isPasswordError.value = false;
    if (emailAddressController.text.toString().isEmpty) {
      isEmailError.value = true;
      emailAddressError.value = 'Please enter your email address.';
    } else if (passwordController.text.toString().isEmpty) {
      isPasswordError.value = true;
      passwordError.value = 'Please enter your password.';
    } else {
      try {
        debugPrint('2-2-2-2-2-2 Inside Login ');
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailAddressController.text.toString().trim(),
                password: passwordController.text.toString().trim());
        // debugPrint('1-1-1-1 Before Connect');
        // final databaseReference = FirebaseDatabase.instance.reference().child(AppDetails.nToken);
        // databaseReference.once().then((DataSnapshot snapshot) {
        //   print('Data : ${snapshot.value}');
        // });
        var keys = ref.child(AppDetails.nToken).push().key;

        var datas = firestoreInstance
            .collection(AppDetails.nToken)
            .where('fcmToken', isEqualTo: MyAppState.getToken.toString())
            .where('deviceId', isEqualTo: MyAppState.deviceID.toString())
            .where('userUid', isEqualTo: userCredential.user!.uid.toString());
      debugPrint('1-1-1-1-1-1 Inside the device Login ${datas.toString()}');

      if(datas.toString().isNotEmpty && datas.toString() != 'null'){
        Service().storeData(
            key: 'userUid', values: userCredential.user!.uid.toString());
        emailAddressController.clear();
        passwordController.clear();
        return true;
      }
      else{
        // debugPrint('3-3-3-3-3 Data is Empty');
        firestoreInstance.collection(AppDetails.nToken).add({
          "fcmToken": MyAppState.getToken.toString(),
          "deviceId": MyAppState.deviceID.toString(),
          "userUid": userCredential.user!.uid.toString(),
        });
        Service().storeData(
            key: 'userUid', values: userCredential.user!.uid.toString());
        emailAddressController.clear();
        passwordController.clear();
        return true;
      }
        // firestoreInstance.collection(AppDetails.nToken).add({
        //   "fcmToken": MyAppState.getToken.toString(),
        //   "deviceId": MyAppState.deviceID.toString(),
        //   "userUid": userCredential.user!.uid.toString(),
        // });
        // var datas =
        //     await ref.child(AppDetails.nToken).child(keys.toString()).set({
        //   "fcmToken": MyAppState.getToken.toString(),
        //   "deviceId": MyAppState.deviceID.toString(),
        //   "userUid": userCredential.user!.uid.toString(),
        //   "mobileNo": userCredential.user!.phoneNumber.toString(),
        //   "isAllow": true,
        //   "createAt": DateTime.now().toString(),
        // });
        // Service().storeData(
        //     key: 'userUid', values: userCredential.user!.uid.toString());
        // emailAddressController.clear();
        // passwordController.clear();
        // return true;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          return false;
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          return false;
        }
      }
    }
  }
}

import 'package:get/get.dart';
import 'package:vaishnav_parivar/screen/Auth/registration.dart';
import 'package:vaishnav_parivar/screen/verification/ui/verificationscreen.dart';

gotoVerificationScreen() {
  Get.off(const VerificationScreen());
}
gotoRegistrationScreen(){
  Get.off(const registration_screen());
}

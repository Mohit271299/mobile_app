import 'package:get/get.dart';

class ForceUpdateController extends GetxController{
  RxString forceUpdateMessage = ''.obs;
  RxString forceUpdateTitle = ''.obs;
  RxBool isAndroidForceUpdate = false.obs;
  RxBool isIosForceUpdate = false.obs;
  RxString androidLatestVersion = ''.obs;
  RxString iosLatestVersion = ''.obs;
}
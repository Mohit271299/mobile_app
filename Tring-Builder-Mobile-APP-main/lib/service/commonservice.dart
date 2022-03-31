import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tring/common/common_routing.dart';
import 'package:tring/common/loader/page_loader.dart';

class CommonService {
  final box = GetStorage();

  void setStoreKey({required String setKey, required String setValue}) async {
    debugPrint(
        '********** Store Storage ${setKey.toString()} = ${setValue.toString()}');
    await box.write(setKey, setValue);
  }

    String getStoreValue({required String keys}) {
    return box.read(keys).toString();
  }

  logoutSuccessfully(BuildContext context){
    box.erase();
    gotoSplashScreen();


  }

  unAuthorizedUser() {
    box.erase();
    gotoSplashScreen();
  }
}

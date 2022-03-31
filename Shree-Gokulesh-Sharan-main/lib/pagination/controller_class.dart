// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'dart:typed_data';

// import 'package:better_player/better_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../screen/homepage/homepage_testimg.dart';

class Login_screen_controller extends GetxController {
  bool isPasswordVisible = false;
  isPasswordVisibleUpdate(bool value) {
    isPasswordVisible = value;
    update();
  }
}

class registration_screen_controller extends GetxController{
  // String pageIndex = '01';
  // pageIndexUpdate(String? value) {
  //   pageIndex = value!;
  //   update();
  // }
}

class dashboard_screen_controller extends GetxController{
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}

class homepage_screen_controller extends GetxController{
  String pageIndex = '01';
  RxList final_data_list = RxList().obs();
  RxList<FeedModel> final_data_list_2 = RxList<FeedModel>().obs();
  RxList<FeedModel> list_data = RxList<FeedModel>();
  var dbRef = FirebaseDatabase.instance.reference().child("Posts");

  // getData() async {
  //   print("insiede get data controller");
  //  await dbRef.once().then((DataSnapshot dataSnapshot) {
  //
  //     Map<dynamic, dynamic> values = dataSnapshot.value;
  //     print(values);
  //     values.forEach((key, values) {
  //       final vartest = FeedModel(
  //           values["datetime"],
  //           values["description"],
  //           values["fileType"],
  //           values["id"],
  //           values["path"],
  //           values["postType"],
  //           values["size"],
  //           values["tpath"],
  //           values["title"]);
  //       final_data_list.value.add(vartest);
  //     });
  //     print('insed get data');
  //     print(final_data_list);
  //
  //     print('outside get data');
  //     print(final_data_list.length);
  //     // print(values);
  //
  //   });
  //  await testing_homeState().getMoreData(list_data.length);
  // }
  // final data = final_data_list;

  // Future<List<FeedModel>> getPostList(int index) async {
  //   // await homeController.getData();
  //   print("final_data_list.length : ${final_data_list.length}");
  //   final data = final_data_list.length;
  //   print(data);
  //   RxList<FeedModel> l =RxList<FeedModel>();
  //
  //   print('object');
  //   for (var i = index; i < index + 5 && i < final_data_list.length; i++) {
  //     l.addAll(final_data_list[i]);
  //   }
  //   print(".length");
  //   print(l.length);
  //   await Future.delayed(const Duration(seconds: 1));
  //   return l;
  // }
  // var dbRef = FirebaseDatabase.instance.reference().child("Posts");
  //
  // getData() {
  //   dbRef.limitToLast(3).once().then((DataSnapshot dataSnapshot) {
  //     Map<dynamic, dynamic> values = dataSnapshot.value;
  //     print(values);
  //     values.forEach((key, values) {
  //       final_data_list.add(values);
  //     });
  //     print(final_data_list);
  //     print(final_data_list.length);
  //     // print(values);
  //   });
  // }

  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class video_screen_controller extends GetxController{
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class post_screen_controller extends GetxController{
  RxString file_selected_image = '_'.obs;
  RxString file_orignal_path = '_'.obs;
  RxString file_selected_video = '_'.obs;
  RxString image_original_path = ''.obs;
  // BetterPlayerController? playerController;
  RxString selected_item = '_'.obs;
  RxString Img_base64String = '_'.obs;
  RxString Img_basetitle = '_'.obs;

  RxString Vid_base64String = '_'.obs;
  RxString Vid_basetitle = '_'.obs;
  File? Vid_;


  //Image data
  RxString Img_postType = '_'.obs;
  RxString Img_fileType = '_'.obs;
  RxString Img_size = '_'.obs;
  RxString Img_path = '_'.obs;
  RxString Img_title = '_'.obs;
  RxString Img_description = '_'.obs;
  RxString Img_datetime = '_'.obs;
  RxString Img_tPath = '_'.obs;

  //Video data
  RxString vid_postType = '_'.obs;
  RxString vid_fileType = '_'.obs;
  RxString vid_size = '_'.obs;
  RxString vid_path = '_'.obs;
  RxString vid_title = '_'.obs;
  RxString vid_description = '_'.obs;
  RxString vid_datetime = '_'.obs;
  RxString vid_tPath = '_'.obs;

  //Audio data
  RxString Aud_postType = '_'.obs;
  RxString Aud_fileType = '_'.obs;
  RxString Aud_size = '_'.obs;
  RxString Aud_path = '_'.obs;
  RxString Aud_title = '_'.obs;
  RxString Aud_description = '_'.obs;
  RxString Aud_datetime = '_'.obs;
  RxString Aud_tPath = '_'.obs;


  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }

}

class blog_screen_controller extends GetxController{}
class videolisting_controller extends GetxController{}
class Audiolisting_controller extends GetxController{}
class profile_screen_controller extends GetxController{}


import 'package:get/get.dart';
import 'package:vaishnav_parivar/pagination/binding_class.dart';
import 'package:vaishnav_parivar/pagination/route_name.dart';
import 'package:vaishnav_parivar/screen/Auth/login.dart';
import 'package:vaishnav_parivar/screen/Auth/registration.dart';
import 'package:vaishnav_parivar/screen/listing/blog_listing.dart';
import 'package:vaishnav_parivar/screen/dashboard/dashboard_screen.dart';
import 'package:vaishnav_parivar/screen/homepage/homepage_screen.dart';
import 'package:vaishnav_parivar/widgets/audio_class_model.dart';
import 'package:vaishnav_parivar/screen/video_details/videoDetail_screen.dart';

import '../screen/listing/audio_listing.dart';
import '../screen/listing/video_listing.dart';
import '../screen/post/post_screen.dart';
import '../screen/profile/profile_screen.dart';

class AppPages {
  static final getPageList = [
    GetPage(
      name: BindingUtils.login_route,
      page: () => login_screen(),
      binding: Login_Binding(),
    ),
    GetPage(
      name: BindingUtils.registraion_route,
      page: () => registration_screen(),
      binding: registation_Binding(),
    ),
    GetPage(
      name: BindingUtils.dashboard_route,
      page: () => dashBoard_screen(),
      binding: dashboard_Binding(),
    ),
    GetPage(
      name: BindingUtils.homepage_route,
      page: () => Homepage_screen(),
      binding: homepage_Binding(),
    ),
    // GetPage(
    //   name: BindingUtils.video_route,
    //   page: () => VideoDetails(),
    //   binding: video_detail_Binding(),
    // ),
    GetPage(
      name: BindingUtils.post_route,
      page: () => PostScreen(),
      binding: post_screen_Binding(),
    ),
    GetPage(
      name: BindingUtils.blog_route,
      page: () => Blog_screen(),
      binding: blog_screen_binding(),
    ),
    GetPage(
      name: BindingUtils.video_listing,
      page: () => videoListingScreen(),
      binding: imageListing_screen_binding(),
    ),
    GetPage(
      name: BindingUtils.Audio_listing,
      page: () => Audio_listing(),
      binding: AudioListing_screen_binding(),
    ),
    GetPage(
      name: BindingUtils.Profile_screen,
      page: () => profileScreen(),
      binding: Profile_screen_binding(),
    ),
  ];
}

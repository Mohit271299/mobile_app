import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'controller_class.dart';

class Login_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Login_screen_controller(), tag: Login_screen_controller().toString());
  }
}

class registation_Binding implements Bindings{
  @override
  void dependencies() {
    Get.put(registration_screen_controller(), tag: registration_screen_controller().toString());
  }
}
class dashboard_Binding implements Bindings{
  @override
  void dependencies() {
    Get.put(dashboard_screen_controller(), tag: dashboard_screen_controller().toString());
  }
}
class homepage_Binding implements Bindings{
  @override
  void dependencies() {
    Get.put(homepage_screen_controller(), tag: homepage_screen_controller().toString());
  }
}
class video_detail_Binding implements Bindings{
  @override
  void dependencies() {
    Get.put(video_screen_controller(), tag: video_screen_controller().toString());
  }
}
class post_screen_Binding implements Bindings{
  @override
  void dependencies() {
    Get.put(post_screen_controller(), tag: post_screen_controller().toString());
  }
}

class blog_screen_binding implements Bindings{
  @override
  void dependencies() {
    Get.put(blog_screen_controller(), tag: blog_screen_controller().toString());
  }
}
class imageListing_screen_binding implements Bindings{
  @override
  void dependencies() {
    Get.put(videolisting_controller(), tag: videolisting_controller().toString());
  }
}
class AudioListing_screen_binding implements Bindings{
  @override
  void dependencies() {
    Get.put(Audiolisting_controller(), tag: Audiolisting_controller().toString());
  }
}
class Profile_screen_binding implements Bindings {
  @override
  void dependencies() {
    Get.put(profile_screen_controller(), tag: profile_screen_controller().toString());
  }
}

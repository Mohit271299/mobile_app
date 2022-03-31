import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vaishnav_parivar/screen/Auth/login.dart';
import 'package:vaishnav_parivar/screen/listing/blog_listing.dart';
import 'package:vaishnav_parivar/screen/post/post_screen.dart';
import 'package:vaishnav_parivar/screen/profile/profile_screen.dart';
import 'package:vaishnav_parivar/services/service.dart';
import 'package:vaishnav_parivar/splash/splashscreen.dart';
import 'package:vaishnav_parivar/utils/asset_utils.dart';
import 'package:vaishnav_parivar/utils/color_utils.dart';
import 'package:vaishnav_parivar/utils/txt_style.dart';

import '../pagination/route_name.dart';
import '../screen/listing/audio_listing.dart';
import '../screen/listing/video_listing.dart';
import '../screen/post/post_screen.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String selectDrawerItem = 'Dashnoard';
  late double screenHeight;

  String userUid = '_';

  @override
  void initState() {
    getId();
    super.initState();
  }

  getId() {
    setState(() {
      userUid = Service().getData(key: 'userUid');
    });
    if (userUid.toString().isNotEmpty && userUid.toString() != 'null') {
      getInformation();
    }
  }

  getInformation() {}

  // final loginControllers = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: SvgPicture.asset(AssetUtils.drawer_close_svg)),
      ),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        child: ClipRRect(
          child: Drawer(
            child: DecoratedBox(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AssetUtils.back_png), fit: BoxFit.fill),
              ),
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.09),
                height: screenSize.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    drawerItem(
                      itemName: 'home'.tr,
                      onTap: () {
                        Navigator.pop(context);
                        // gotoSalesListScreen(context);
                      },
                    ),
                    // SizedBox(
                    //     height: (screenSize.height * 0.07).ceilToDouble()),
                    // drawerItem(
                    //   itemName: txt_utils.drawer_images,
                    //   onTap: () {
                    //     // Navigator.pop(context);
                    //     // Get.toNamed(BindingUtils.Image_listing);
                    //   },
                    // ),
                    SizedBox(height: (screenSize.height * 0.07).ceilToDouble()),
                    // Text((screenSize.height * 0.07).ceilToDouble().toString()),
                    drawerItem(
                      itemName: 'video'.tr,
                      onTap: () {
                        Navigator.pop(context);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => videoListingScreen()));
                        // Get.toNamed(BindingUtils.video_listing);
                      },
                    ),
                    SizedBox(height: (screenSize.height * 0.07).ceilToDouble()),
                    drawerItem(
                        itemName: 'audio'.tr,
                        onTap: () {
                          Navigator.pop(context);
                          // Get.toNamed(BindingUtils.Audio_listing);
                          // Navigator.pop(context);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Audio_listing()));

                          // gotoEstimateListScreen(context);
                        }),
                    SizedBox(height: (screenSize.height * 0.07).ceilToDouble()),
                    drawerItem(
                        itemName: 'blog'.tr,
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Blog_screen()));
                          // Get.toNamed(BindingUtils.blog_route);
                        }),
                    SizedBox(height: (screenSize.height * 0.07).ceilToDouble()),
                    drawerItem(
                      itemName: 'post'.tr,
                      onTap: () {
                        Navigator.pop(context);

                        // Get.toNamed(BindingUtils.post_route);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostScreen()));
                      },
                    ),
                    SizedBox(height: (screenSize.height * 0.07).ceilToDouble()),
                    drawerItem(
                      itemName: 'setting'.tr,
                      onTap: () {
                        Navigator.pop(context);
                        // Get.toNamed(BindingUtils.Profile_screen);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => profileScreen()));
                        // Navigator.pop(context);
                        // gotoLeadsListScreen(context);
                      },
                    ),
                    SizedBox(height: (screenSize.height * 0.07).ceilToDouble()),
                    drawerItem(
                      itemName: 'logout'.tr,
                      onTap: () {
                        Service().eraseAll();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SplashScreen(),
                          ),
                        );
                        // Get.offAll(const login_screen());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  InkWell drawerItem({
    required String itemName,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Text(
        itemName.toString().tr,
        style: FontStyleUtility.h16(
          fontColor: ColorUtils.primary,
          fontWeight: FWT.bold,
        ),
      ),
    );
  }

  SizedBox setSpace() => SizedBox(
        height: screenHeight * 0.01,
      );
}

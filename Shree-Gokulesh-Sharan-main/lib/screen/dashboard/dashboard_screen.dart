import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vaishnav_parivar/utils/asset_utils.dart';
import 'package:vaishnav_parivar/utils/back_image.dart';
import 'package:vaishnav_parivar/utils/txt_style.dart';
import 'package:vaishnav_parivar/widgets/custom_appbar.dart';

import '../../pagination/controller_class.dart';
import '../../utils/color_utils.dart';
import '../../widgets/drawer_class.dart';
import '../homepage/homepage_screen.dart';

class dashBoard_screen extends StatefulWidget {
  const dashBoard_screen({Key? key}) : super(key: key);

  @override
  _dashBoard_screenState createState() => _dashBoard_screenState();
}

class _dashBoard_screenState extends State<dashBoard_screen> {

  final _dashboard_screen_controller = Get.put(dashboard_screen_controller());

  GlobalKey<ScaffoldState>? globalKey = GlobalKey<ScaffoldState>();

  int _page = 0;
  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to exit an App'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          FlatButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    )) ??
        false;
  }


  Widget? get getPage {
    if (_page == 0) {
      return const Homepage_screen();
    } else if (_page == 1) {
      return const Homepage_screen();
    } else if (_page == 2) {
      return const Homepage_screen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return GetBuilder<dashboard_screen_controller>(
      init: _dashboard_screen_controller,
      builder:(context) {
        return Scaffold(
          key: globalKey,
          extendBodyBehindAppBar: true,
          drawer: DrawerScreen(),
          // appBar: AppBar(
          //   elevation: 0.0,
          //   backgroundColor: Colors.transparent ,
          //   leading: InkWell(
          //     onTap: ()=> _globalKey!.currentState!.openDrawer(),
          //     child: Padding(
          //       padding: const EdgeInsets.only(
          //           left: 20.0, top: 18.0, bottom: 18.0, right: 10.0),
          //       child: InkWell(
          //         child: Image.asset(
          //           AssetUtils.drawer_png,
          //           height: 14.0,
          //           width: 16.0,
          //           // width: 20.0,
          //           // fit: BoxFit.fill,
          //
          //         ),
          //       ),
          //     ),
          //   ),
          //   centerTitle: false,
          //   title: Text(
          //     'Dashboard',
          //     textAlign: TextAlign.left,
          //     style:  FontStyleUtility.h16(
          //         fontColor: ColorUtils.primary,
          //         fontWeight: FWT.semiBold),
          //   ),
          //   actions: [
          //     InkWell(
          //       child: Padding(
          //         padding: const EdgeInsets.only(right: 20.0,top: 10.0,bottom: 10.0),
          //         child: Image.asset(
          //           AssetUtils.noti_png,
          //           height: 19.0,
          //           width: 16.0,
          //           // width: 37.0,
          //           // fit: BoxFit.fill,
          //         ),
          //       ),
          //     ),
          //   ],
          // ),
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: custom_appbar(
              keys: globalKey,
               // drawertap : () {
              //   print("object");
              //   globalKey!.currentState!.openDrawer();
              // },
              title: 'dashboard'.tr,
              burger: AssetUtils.drawer_png,
            ),
          ),
          body: WillPopScope(
            onWillPop: _onWillPop,
            child: Container(

              height: screenSize.height,
              child: Column(
                children: [
                  SizedBox(height: (screenSize.height * 0.107)),

                  Expanded(
                    child: getPage!,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

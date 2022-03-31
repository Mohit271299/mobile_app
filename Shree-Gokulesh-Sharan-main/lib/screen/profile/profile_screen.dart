import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../pagination/controller_class.dart';
import '../../pagination/route_name.dart';
import '../../utils/asset_utils.dart';
import '../../utils/back_image.dart';
import '../../utils/color_utils.dart';
import '../../utils/txt_style.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_feild_box.dart';
import '../../widgets/drawer_class.dart';

class profileScreen extends StatefulWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  _profileScreenState createState() => _profileScreenState();
}

class _profileScreenState extends State<profileScreen> {
  final _profileScreenController = Get.put(profile_screen_controller());

  GlobalKey<ScaffoldState>? globalKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    bool _lights = false;

    return GetBuilder<profile_screen_controller>(
      init: _profileScreenController,
      builder: (ctx) {
        return Scaffold(
          key: globalKey,
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: custom_appbar(
              title: "Profile",
              backRoute: BindingUtils.dashboard_route,
              back: AssetUtils.drawer_back,
            ),
          ),
          drawer: DrawerScreen(),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus( FocusNode());
            },
            child: back_image(
              body_container: Container(
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 0, left: 20, right:20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            height: (screenSize.height * 0.041).ceilToDouble()),
                        // Text((screenSize.height * 0.041).ceilToDouble().toString()),
                        Container(
                          alignment: Alignment.center,
                            // height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              AssetUtils.user_png,
                              fit: BoxFit.contain,
                            )),
                        SizedBox(
                            height: 12),
                        // Text((screenSize.height * 0.041).ceilToDouble().toString()),
                        Center(
                          child: Text(
                            'Change Profile Photo',
                            style: FontStyleUtility.h13(
                                fontColor: ColorUtils.primary,
                                fontWeight: FWT.semiBold),
                          ),
                        ),
                        SizedBox(
                            height: (screenSize.height * 0.069).ceilToDouble()),
                        Container(
                          height: 54,
                          decoration:  BoxDecoration(
                            color: ColorUtils.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                            BoxShadow(
                              color: Color(0x17000000),
                              blurRadius: 10.0,
                              offset: Offset(0.0, 0.75),
                            ),

                          ]),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Name:",style: FontStyleUtility.h13(
                                    fontColor: ColorUtils.dark_font,
                                    fontWeight: FWT.semiBold),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    fillColor: ColorUtils.white,
                                    isDense: true,
                                    filled: true,
                                    border: InputBorder.none,
                                  ),
                                  style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.dark_font,
                                      fontWeight: FWT.semiBold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: (screenSize.height * 0.02).ceilToDouble()),
                        Container(
                          height: 54,
                          decoration:  BoxDecoration(
                            color: ColorUtils.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                            BoxShadow(
                              color: Color(0x17000000),
                              blurRadius: 10.0,
                              offset: Offset(0.0, 0.75),
                            ),

                          ]),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Email:",style: FontStyleUtility.h13(
                                    fontColor: ColorUtils.dark_font,
                                    fontWeight: FWT.semiBold),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    fillColor: ColorUtils.white,
                                    isDense: true,
                                    filled: true,
                                    border: InputBorder.none,
                                  ),
                                  style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.dark_font,
                                      fontWeight: FWT.semiBold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: (screenSize.height * 0.02).ceilToDouble()),
                        Container(
                          height: 54,
                          decoration:  BoxDecoration(
                            color: ColorUtils.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                            BoxShadow(
                              color: Color(0x17000000),
                              blurRadius: 10.0,
                              offset: Offset(0.0, 0.75),
                            ),

                          ]),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  "Phone:",style: FontStyleUtility.h13(
                                    fontColor: ColorUtils.dark_font,
                                    fontWeight: FWT.semiBold),
                                ),
                              ),
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    fillColor: ColorUtils.white,
                                    isDense: true,
                                    filled: true,
                                    border: InputBorder.none,
                                  ),
                                  style: FontStyleUtility.h14(
                                      fontColor: ColorUtils.dark_font,
                                      fontWeight: FWT.semiBold),
                                  keyboardType: TextInputType.number,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: (screenSize.height * 0.027).ceilToDouble()),
                        // Text((screenSize.height * 0.027).ceilToDouble().toString()),
                        Container(
                          child: Text('Notification',style: FontStyleUtility.h15(
                              fontColor: ColorUtils.dark_black,
                              fontWeight: FWT.semiBold) ,),
                        ),
                        SizedBox(
                            height: (screenSize.height * 0.027).ceilToDouble()),
                        Container(
                          height: 54,
                          decoration:  BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0x17000000),
                                  blurRadius: 10.0,
                                  offset: Offset(0.0, 0.75),
                                ),

                              ]),
                          child:  MergeSemantics(
                            child: ListTile(
                              title: Text('Lights'),
                              trailing: Transform.scale(
                                scale: 1,
                                child: CupertinoSwitch(
                                  trackColor:ColorUtils.primary_light,
                                  thumbColor: ColorUtils.primary,
                                  value: _lights,
                                  onChanged: (bool value) {
                                    print(value);
                                    setState(() {
                                      _lights = value;
                                      // _lights = !_lights;
                                    });
                                  },
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  _lights = !_lights;
                                });
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

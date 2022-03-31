import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar({Key? key})
      : preferredSize = Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorUtils.blueColor,
      centerTitle: true,
      actions: [
        // action button
        Container(
          margin: EdgeInsets.only(right: 20),
          child: IconButton(
            iconSize: 37,
            icon: Image.asset(AssetUtils.userPng),
            onPressed: () {
              Get.toNamed(BindingUtils.user_profile_ScreenRoute);
            },
          ),
        ),
      ],
    );
  }
}

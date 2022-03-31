import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vaishnav_parivar/Common/common_widget.dart';
import 'package:vaishnav_parivar/screen/dashboard/dashboard_screen.dart';

import '../utils/asset_utils.dart';
import '../utils/color_utils.dart';
import '../utils/txt_style.dart';

class custom_appbar extends StatelessWidget {
  final Widget? data;
  final String? burger;
  final String? back;
  final String? route;
  final VoidCallback? drawertap;
  final VoidCallback? backtap;
  final String? backRoute;
  final String? labelText;
  final GlobalKey<ScaffoldState>? keys;
  final String? title;

  const custom_appbar({
    Key? key,
    this.drawertap,
    this.backtap,
    this.burger,
    this.back,
    this.route,
    this.backRoute,
    this.labelText,
    this.title,
    this.data,
    this.keys,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
      leading: IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            (burger != null
                ? keys!.currentState!.openDrawer()
                :  Navigator.push(context, MaterialPageRoute(builder: (context)=> dashBoard_screen())));
          },
          icon: (burger != null
              ? Image.asset(
                  burger!,
                  height: 20,
                  color: Colors.black,
                )
              : SvgPicture.asset(
                  back!,
                  height: 15,
                  color: Colors.black,
                ))),
      centerTitle: false,
      title: Text(
        '$title'.tr,
        textAlign: TextAlign.left,
        style: FontStyleUtility.h16(
            fontColor: ColorUtils.primary, fontWeight: FWT.semiBold),
      ),
      actions: [
        InkWell(
          child: Padding(
            padding:
                const EdgeInsets.only(right: 20.0, top: 10.0, bottom: 10.0),
            child: Image.asset(
              AssetUtils.noti_png,
              height: 19.0,
              width: 16.0,
              // width: 37.0,
              // fit: BoxFit.fill,
            ),
          ),
        ),
        InkWell(
          onTap: ()=> CommonWidget().changeLanguage(context),
          child: Icon(
            Icons.language,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
      ],
    );
  }
}

// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';
import 'package:magnet_update/controller/controllers_class.dart';

import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashScreenController _splashController = Get.find(tag: SplashScreenController().toString());
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.toNamed(BindingUtils.loginScreenRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.scffoldBgColor,
      body: Center(
        child: AvatarGlow(
          endRadius: 200.0,
          showTwoGlows: true,
          duration: Duration(milliseconds: 900),
          repeat: true,
          child: SvgPicture.asset(AssetUtils.magnet_logo),
          glowColor: Colors.grey,
        ),
      ),
    );
  }
}

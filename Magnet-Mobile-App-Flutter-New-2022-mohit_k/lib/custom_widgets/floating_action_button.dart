import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';

class floating_button extends StatelessWidget {
  final VoidCallback? Open;
  final VoidCallback? Close;
  final VoidCallback? onTap_1;
  final VoidCallback? onTap_2;
  final VoidCallback? onTap_3;
  final VoidCallback? onTap_4;
  final VoidCallback? onTap_5;
  final VoidCallback? onTap_6;

  final String? labelText_1;
  final String? labelText_2;
  final String? labelText_3;
  final String? labelText_4;
  final String? labelText_5;
  final String? labelText_6;
  final String? labelText_7;
  final String? labelText_8;
  final String? labelText_9;

  const floating_button({
    Key? key,
    this.Open,
    this.Close,
    this.labelText_1,
    this.labelText_2,
    this.labelText_3,
    this.labelText_4,
    this.labelText_5,
    this.labelText_6,
    this.labelText_7,
    this.labelText_8,
    this.labelText_9,
    this.onTap_1,
    this.onTap_2,
    this.onTap_3,
    this.onTap_4,
    this.onTap_5,
    this.onTap_6,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return SpeedDial(
      animatedIcon: AnimatedIcons.add_event,
      animatedIconTheme: IconThemeData(size: 22.0 , color: ColorUtils.whiteColor),
      visible: true,
      curve: Curves.bounceIn,
      overlayColor: HexColor("#FFFFFF"),
      overlayOpacity: 0.95,
      backgroundColor: ColorUtils.blueColor,
      onOpen: Open,
      onClose: Close,
      activeBackgroundColor: HexColor('#3B7AF1'),
      foregroundColor: Colors.black,
      elevation: 2.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
          labelWidget: Text(''),
        ),

        SpeedDialChild(
          elevation: 0.0,
            child: Image(
              image: AssetImage(AssetUtils.addPng),
              height: screenSize.height * 0.02,
              width: screenSize.height * 0.02,
              fit: BoxFit.cover,
            ),
            backgroundColor: ColorUtils.oxffCFDFFD,
            label: labelText_1,
            labelWidget: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                labelText_1.toString(),
                style: TextStyle(
                    fontFamily: "GR",
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: HexColor("#0B0D16")),
              ),
            ),
            onTap: onTap_1),
        SpeedDialChild(
            elevation: 0.0,
            child: Image(
              image: AssetImage(AssetUtils.addPng),
              height: screenSize.height * 0.02,
              width: screenSize.height * 0.02,
              fit: BoxFit.cover,
            ),
            backgroundColor: ColorUtils.oxffCFDFFD,
            label: labelText_2,
            labelWidget: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                labelText_2.toString(),
                style: TextStyle(
                    fontFamily: "GR",
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: HexColor("#0B0D16")),
              ),
            ),
            onTap: onTap_2),
        SpeedDialChild(
          elevation: 0.0,
          child: Image(
            image: AssetImage(AssetUtils.addPng),
            height: screenSize.height * 0.02,
            width: screenSize.height * 0.02,
            fit: BoxFit.cover,
          ),
          backgroundColor: ColorUtils.oxffCFDFFD,
          label: labelText_3,
          labelWidget: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              labelText_3.toString(),
              style: TextStyle(
                  fontFamily: "GR",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#0B0D16")),
            ),
          ),
          onTap: onTap_3,
        ),
        SpeedDialChild(
            elevation: 0.0,
            child: Image(
              image: AssetImage(AssetUtils.addPng),
              height: screenSize.height * 0.02,
              width: screenSize.height * 0.02,
              fit: BoxFit.cover,
            ),
            backgroundColor: ColorUtils.oxffCFDFFD,
            label: labelText_4,
            labelWidget: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Text(
                labelText_4.toString(),
                style: TextStyle(
                    fontFamily: "GR",
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                    color: HexColor("#0B0D16")),
              ),
            ),
            onTap: onTap_4),
        SpeedDialChild(
          elevation: 0.0,
          child: Image(
            image: AssetImage(AssetUtils.addPng),
            height: screenSize.height * 0.02,
            width: screenSize.height * 0.02,
            fit: BoxFit.cover,
          ),
          backgroundColor: ColorUtils.oxffCFDFFD,
          label: labelText_5,
          labelWidget: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              labelText_5.toString(),
              style: TextStyle(
                  fontFamily: "GR",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#0B0D16")),
            ),
          ),
          onTap: onTap_5,
        ),
        SpeedDialChild(
          elevation: 0.0,
          child: Image(
            image: AssetImage(AssetUtils.addPng),
            height: screenSize.height * 0.02,
            width: screenSize.height * 0.02,
            fit: BoxFit.cover,
          ),
          backgroundColor: ColorUtils.oxffCFDFFD,
          label: labelText_6,
          labelWidget: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text(
              labelText_6.toString(),
              style: TextStyle(
                  fontFamily: "GR",
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: HexColor("#0B0D16")),
            ),
          ),
          onTap: onTap_6,
        ),
      ],
    );
  }
}

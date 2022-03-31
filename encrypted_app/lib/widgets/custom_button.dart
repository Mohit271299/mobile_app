import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../appdetails.dart';
import '../common/common_color.dart';
import 'gradient_txt.dart';

class customButton extends StatelessWidget{
  final  String text;
  final GestureTapCallback? ontap;
  const customButton({Key? key, required this.text, this.ontap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: ontap,
          child: Container(
            margin: EdgeInsets.only(bottom: 50),
            decoration: BoxDecoration(
              color: HexColor(CommonColor.appBackColor),
              boxShadow: [
                BoxShadow(
                  color: HexColor("#FFFFFF").withOpacity(0.25),
                  blurRadius: 10,
                  spreadRadius: -8,
                  offset: const Offset(-6, -6),
                ),
                BoxShadow(
                  color: HexColor("#000000").withOpacity(0.25),
                  blurRadius: 12,
                  spreadRadius: 0,
                  offset: const Offset(6, 6),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 18,horizontal: 60),
                child: GradientText(
                  text,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontFamily: AppDetails.fontGilroySemiBold,
                    fontSize: 14.0,
                    color: HexColor("#FFFFFF"),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end:
                    Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      HexColor('#C996CC'),
                      HexColor('#916BBF')
                    ], // red to yellow
                    tileMode: TileMode.clamp,),
                )
            ),
          ),
        ),
      ),
    );
  }

}

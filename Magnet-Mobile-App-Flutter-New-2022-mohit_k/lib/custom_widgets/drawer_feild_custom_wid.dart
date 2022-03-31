import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class DrawerFieldCustomWidget extends StatelessWidget {
  final String? imageUrl;
  final String? lablename;
  final ExpansionTile? collapse;

  const DrawerFieldCustomWidget(
      {Key? key, this.imageUrl, this.lablename, this.collapse})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.only(right: 0),
                  child: Image.asset(
                    imageUrl!,
                    height: 24.0,
                    width: 24.0,
                    fit: BoxFit.fill,
                    color: Color(0xff485056),
                  )),
            ),
            SizedBox(width: 0),
            Expanded(
              flex: 3,
              child: Container(
                child: Text(
                  lablename!,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: HexColor("#485056"),
                    fontFamily: "GR"
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

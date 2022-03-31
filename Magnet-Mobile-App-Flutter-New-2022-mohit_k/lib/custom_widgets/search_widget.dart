import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:magnet_update/utils/color_utils.dart';
import 'package:magnet_update/utils/image_utils.dart';
import 'package:magnet_update/utils/text_style_utils.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;


  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
    required this.hintText,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: ColorUtils.whiteColor,
        boxShadow: [
          BoxShadow(
            color: Color(0x17000000),
            blurRadius: 10.0,
            offset: Offset(0.0, 0.75),
          ),
        ],
      ),
      height: 34,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: 15,),
          icon: Container(
            margin: EdgeInsets.only(left: 12,),
            child: SizedBox(
              height: 16,
              width: 16,
              child: SvgPicture.asset(
                AssetUtils.searchIcons,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontFamily: "GR",
            color: HexColor("#9D9D9D"),
            fontSize: 12.0,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
        ),
        style: FontStyleUtility.h12(
          fontColor: ColorUtils.blackColor,
          fontWeight: FWT.semiBold,
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


abstract class textfeild {
  static const TextStyle lable_style = TextStyle(
      color: Color(0xff9d9d9d),
      fontSize: 12.0,
      fontWeight: FontWeight.w600
  );

  static const TextStyle text_style = TextStyle(
      color: Color(0xff0B0D16),
      fontSize: 16.0,
      fontWeight: FontWeight.w600
  );

  static OutlineInputBorder box_focus_style = OutlineInputBorder(
    borderSide: BorderSide(
        color: Colors.blueAccent,
        width: 1.0),
    borderRadius:
    BorderRadius.circular(10.0),
  );
}
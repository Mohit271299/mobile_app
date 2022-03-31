import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
hideFocusKeyBoard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:path_provider/path_provider.dart';

hideKeyboard(BuildContext _context) {
  FocusScope.of(_context).requestFocus(FocusNode());
}

class Utils {
// compress file and get file.
//   static Future<File> compressAndGetFile(File file) async {
//     Random random =  Random();
//     int randomNumber = random.nextInt(10000000);
//     final dir = await path_provider.getTemporaryDirectory();
//     final targetPath =
//         dir.absolute.path + "/" + randomNumber.toString() + ".jpg";
//
//     var result = await FlutterImageCompress.compressAndGetFile(
//       file.absolute.path,
//       targetPath,
//       quality: 50,
//       rotate: 0,
//     );
//
//     return result;
//   }
//
//   static Future<File> byteDataToFile(ByteData data) async {
//     Random random = new Random();
//     int randomNumber = random.nextInt(10000000);
//     final buffer = data.buffer;
//
//     final dir = await path_provider.getTemporaryDirectory();
//     final targetPath =
//         dir.absolute.path + "/" + randomNumber.toString() + ".jpg";
//
//     return new File(targetPath).writeAsBytes(
//         buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
//   }

//   static dateFormatFun(date)
// {
//   final DateFormat formatter = DateFormat('dd-MMMM-yyyy');
//   final String formatted = formatter.format(date);
//   return formatted;
// }
}
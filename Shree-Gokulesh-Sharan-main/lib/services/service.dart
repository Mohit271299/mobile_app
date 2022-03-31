import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:vaishnav_parivar/AppDetails.dart';

class Service {
  static var box = GetStorage();

  storeData({required String key, required String values}) {
    debugPrint('***** Store Data ${key.toString()} == ${values.toString()}');
    box.write(key, values);
  }

  getData({required String key}) {
    return box.read(key).toString();
  }

  eraseAll() {
    box.erase();
  }
}

class SendFCMNotification {
  static Future sendFcmMessage(String title, String message) async {
    QuerySnapshot ref =
        await FirebaseFirestore.instance.collection(AppDetails.nToken).get();

    ref.docs.forEach((snapshot) async {
      debugPrint('Inside Token ${snapshot['fcmToken'].toString()} == ${title.toString()} === ${message.toString()}');

      try {
        var header = {
          "Content-Type": "application/json",
          "Authorization": "key=${AppDetails.appSecretId}",
        };
        var request = {
          "notification": {
            "title": title,
            "text": message,
            "sound": "default",
            "color": "#990000",
          },
          "priority": "high",
          "to": snapshot['fcmToken'].toString(),
        };

        var response = await http.post(
          Uri.parse("https://fcm.googleapis.com/fcm/send"),
          headers: header,
          body: json.encode(request),
        );

        debugPrint('Notification Response ${response.body.toString()}');
      } catch (e, s) {
        print('Notification Error ${e.toString()}');
        // return false;
      }
    });
  }
}

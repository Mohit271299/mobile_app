import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/screen/global_class.dart';
import 'package:magnet_update/utils/loader/page_loader.dart';
import 'package:magnet_update/utils/preference.dart';

var url = Api_url.customer_listing_api;
String Token = "";
BuildContext? cntx=  NavigationService.navigatorKey.currentContext;

class http_service {
  static Future<dynamic> get_Data(url) async {
    showLoader(cntx);
    String Token = await PreferenceManager().getPref(Api_url.token);

    final response = await http.get(
      Uri.parse(url),
      headers: {
        // "Accept": "application/json",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    hideLoader(cntx!);
    return handleGetResponse(response);
  }



  static Future<dynamic> post(url, data) async {

    String Token = await PreferenceManager().getPref(Api_url.token);

    final response = await http.post(
      Uri.parse(url),
      body:json.encode(data),
      headers: {
        // "Accept": "application/json",
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ' + Token
      },
    );
    print(response.toString());
    return handleResponse(response);
  }
  static Future<dynamic> delete(url) async {
      String Token = await PreferenceManager().getPref(Api_url.token);

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          // "Accept": "application/json",
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + Token
        },
      );
      return handleResponse(response);
    }

  static Future<dynamic> put(url,data) async {
        String Token = await PreferenceManager().getPref(Api_url.token);

        final response = await http.put(
          Uri.parse(url),
          body: json.encode(data),
          headers: {
            // "Accept": "application/json",
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + Token
          },
        );
        return handleResponse(response);
      }

  static handleResponse(response) {
    if (response.statusCode == 200  || response.statusCode == 201) {
      Map<String, dynamic> result = json.decode(response.body);
      if (result["success"]) {
        return result;
      } else {
        throw Exception(result['message']);
      }
    } else if (response.statusCode == 401) {
      throw Exception('Error');
    } else {
      print("response.statusCode");
      print(response.statusCode);
      // print(response.body);
      throw Exception(response.body);
    }
  }
  static handleGetResponse(response) {
    if (response.statusCode == 200) {
      Map<String, dynamic> ressult = json.decode(response.body);
      if (ressult["success"]) {
        return ressult;
      } else {
        print(response.statusCode);
        throw Exception(ressult['message']);
      }
    } else if (response.statusCode == 401) {
      throw Exception('Error');
    } else {
      print("response.statusCode");
      print(response.statusCode);
      // print(response.body);
      throw Exception();
    }
  }

}

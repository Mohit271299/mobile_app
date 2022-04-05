import 'dart:convert';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../AppDetails.dart';
import '../../../AppDetails.dart';
import '../../../common/common_routing.dart';
import '../../../common/common_widget.dart';
import '../../../common/loader/page_loader.dart';
import '../../../service/commonservice.dart';
import '../model/getAllpaymentModel.dart';

class PaymentController extends GetxController{
  RxBool ispaymentLoading = false.obs;
  GetAllPaymentModel? getAllPaymentModel;
  var getAllpaymentModelList = GetAllPaymentModel().obs;

  // Get All payment Fron API
  Future<dynamic> getAllPaymentFromAPI({
    int recordPerPage = 10,
    int pageNumber = 1,
    String sortBy = "name",
  }) async {
    ispaymentLoading(true);
    String url = (URLConstants.base_url +
        "payment/receivable?recordsPerPage=${recordPerPage.toString()}&pageNumber=${pageNumber.toString()}");
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();

    // debugPrint('Get Sales Token ${tokens.toString()}');
    try {
      http.Response response = await http.get(Uri.parse(url), headers: {
        'Authorization': 'Bearer ${tokens.toString()}',
      });

      print('Response request: ${response.request}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      var data = convert.jsonDecode(response.body);

      if (response == null) {
        return null;
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        final status = data["success"];
        getAllPaymentModel = GetAllPaymentModel.fromJson(data);
        getAllpaymentModelList(getAllPaymentModel);
        if (status == true) {
          debugPrint(
              '2-2-2-2-2-2 Inside the payment Controller Details ${getAllPaymentModel!.data!.length}');
          ispaymentLoading(false);
          // CommonWidget().showToaster(msg: data["success"].toString());
          return getAllPaymentModel;
        } else {
          CommonWidget().showToaster(msg: msg.toString());
          return null;
        }
      } else if (response.statusCode == 422) {
        CommonWidget().showToaster(msg: msg.toString());
      } else if (response.statusCode == 401) {
        CommonService().unAuthorizedUser();
      } else {
        CommonWidget().showToaster(msg: msg.toString());
      }
    } catch (e) {
      print('1-1-1-1 Get payment ${e.toString()}');
    }
  }

}
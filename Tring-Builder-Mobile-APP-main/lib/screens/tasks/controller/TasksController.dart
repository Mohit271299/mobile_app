import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../AppDetails.dart';
import '../../../common/common_widget.dart';
import '../../../service/commonservice.dart';
import '../../product/model/getAllProductModel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/getAlltasksModel.dart';

class TasksController extends GetxController{
  RxBool isTasksLoading = false.obs;

  GetAllTasksModel? getAllTasksModel;
  var getAllLeadsModelList = GetAllTasksModel().obs;

  // Get All Tasks Fron API
  Future<dynamic> getAllTasksFromAPI({
    int recordPerPage = 10,
    int pageNumber = 1,
    String sortBy = "ASC",
  }) async {
    isTasksLoading(true);
    String url = (URLConstants.base_url +
        "task?recordsPerPage=${recordPerPage.toString()}&pageNumber=${pageNumber.toString()}&sortBy=assignTo&sortOrder=ASC");
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
        getAllTasksModel = GetAllTasksModel.fromJson(data);
        getAllLeadsModelList(getAllTasksModel);
        if (status == true) {
          debugPrint('2-2-2-2-2-2 Inside the product Controller Details ${getAllTasksModel!.data!.length}');
          isTasksLoading(false);
          // CommonWidget().showToaster(msg: data["success"].toString());
          return getAllTasksModel;
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
      print('1-1-1-1 Get Purchase ${e.toString()}');
    }
  }

}
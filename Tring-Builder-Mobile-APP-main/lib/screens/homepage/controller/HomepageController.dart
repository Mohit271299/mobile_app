 import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../AppDetails.dart';
import '../../../common/common_widget.dart';
import '../../../service/commonservice.dart';
import '../model/getAllProjectsModel.dart';

 import 'package:http/http.dart' as http;
 import 'dart:convert' as convert;

import '../ui/homepage.dart';

class HomepageController extends GetxController{

  RxBool isHomepageLoading = false.obs;
  Data? selectedTower;
  List<tower_data>? selectedTowerData = [];

  GetAllProjcetsModel? getAllProjcetsModel;
  var getAllProjectsModelList = GetAllProjcetsModel().obs;

  // Get All Leads Fron API
  Future<dynamic> getAllLeadsFromAPI({
    int recordPerPage = 10,
    int pageNumber = 1,
    String sortBy = "leadDate",
  }) async {
    isHomepageLoading(true);
    String url = (URLConstants.base_url +
        "project");
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
        getAllProjcetsModel = GetAllProjcetsModel.fromJson(data);
        getAllProjectsModelList(getAllProjcetsModel);
        if (status == true) {
          debugPrint('2-2-2-2-2-2 Inside the product Controller Details ${getAllProjcetsModel!.data!.length}');
          isHomepageLoading(false);
          selectedTower = getAllProjcetsModel!.data![0];
          selectedTowerData = selectedTower!.data_tower;
          // CommonWidget().showToaster(msg: data["success"].toString());
          return getAllProjcetsModel;
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
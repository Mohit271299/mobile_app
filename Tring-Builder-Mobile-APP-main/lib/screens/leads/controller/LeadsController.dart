import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../AppDetails.dart';
import '../../../common/common_widget.dart';
import '../../../service/commonservice.dart';
import '../../sales/model/getAllCustomerDetails.dart';
import '../model/getAllLeadsModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class LeadsController extends GetxController{

  RxBool isLeadsLoading = false.obs;
  GetAllLeadsModel? getAllLeadsModel;
  var getAllLeadsModelList = GetAllLeadsModel().obs;
  RxInt selectFlatId = 0.obs;

  // Get All Customer list model
  RxBool isCustomerLoading = false.obs;
  GetAllCustomerDetails? getAllCustomerDetails;
  var getAllCustomerModelList = GetAllCustomerDetails().obs;


  // Get All Leads Fron API
  Future<dynamic> getAllLeadsFromAPI({
    int recordPerPage = 10,
    int pageNumber = 1,
    String sortBy = "leadDate",
  }) async {
    isLeadsLoading(true);
    String url = (URLConstants.base_url +
        "lead?recordsPerPage=${recordPerPage.toString()}&pageNumber=${pageNumber.toString()}&sortBy=${sortBy.toString()}");
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();

    // debugPrint('Get Sales Token ${tokens.toString()}');
    // try {
    // } catch (e) {
    //   print('1-1-1-1 Get Purchase ${e.toString()}');
    // }

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
      getAllLeadsModel = GetAllLeadsModel.fromJson(data);
      getAllLeadsModelList(getAllLeadsModel);
      if (status == true) {
        debugPrint('2-2-2-2-2-2 Inside the product Controller Details ${getAllLeadsModel!.data!.length}');
        isLeadsLoading(false);
        // CommonWidget().showToaster(msg: data["success"].toString());
        return getAllLeadsModel;
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
  }

  Future<dynamic> getAllCustomerFromAPI() async {
    isCustomerLoading(true);
    String url = (URLConstants.base_url + URLConstants.getAllCustomerDetails);
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
        getAllCustomerDetails = GetAllCustomerDetails.fromJson(data);
        getAllCustomerModelList(getAllCustomerDetails);
        if (status == true) {
          isCustomerLoading(false);
          // CommonWidget().showToaster(msg: msg.toString());
          return getAllLeadsModel;
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
      print('1-1-1-1 Get Sales ${e.toString()}');
    }
  }

  String? inquirydate;
  String? folloUpdate;
  String? sitevisitdate;

  TextEditingController customerController = new TextEditingController();
  TextEditingController inquirydateController = new TextEditingController();
  TextEditingController folloUpdateController = new TextEditingController();
  TextEditingController sitevisitdateController = new TextEditingController();
  TextEditingController leadownerController = new TextEditingController();
  TextEditingController sourceCampaignController = new TextEditingController();
  TextEditingController salespersonController = new TextEditingController();
  TextEditingController notesController = new TextEditingController();
  TextEditingController flatNoController = TextEditingController();

  // Future<dynamic> storeLeads
  //     (
  //     {required BuildContext context,
  //       required String activityType,
  //       required String activityTypeId,
  //       required String associatedName,
  //       required String associatedLeadId}) async {
  //   String url = (URLConstants.base_url + URLConstants.ActivityUrl);
  //   String msg = '';
  //   String tokens = CommonService().getStoreValue(keys: 'token').toString();
  //
  //   Map params = {
  //     "activityDate": birth_date,
  //     "activityDateFormat": "",
  //     "activityTime": "${selectedTime.hour}:${selectedTime.minute}",
  //     "activityTypeId": int.parse(activityTypeId),
  //     "activityTypeName": activityType,
  //     "addedById": null,
  //     "associatedLeadId": int.parse(associatedLeadId),
  //     "associatedName": associatedName,
  //     "completedById": null,
  //     "description": descriptionController.text,
  //     "leadOwnerId": 1,
  //     "leadOwnerName": lead_ownerController.text,
  //     "location": addressController.text,
  //     "timeNeeded": "$selectedhr:$selectedmn",
  //   };
  //
  //   // try {
  //   //   } catch (e) {
  //   //   // hideLoader(context);
  //   //   print('1-1-1-1 Get Contacts ${e.toString()}');
  //   // }
  //   debugPrint('Add Activity Params => ${params}');
  //   http.Response response = await http.post(
  //     Uri.parse(url),
  //     headers: {
  //       "Content-Type": "application/json",
  //       'Authorization': 'Bearer ${tokens.toString()}',
  //     },
  //     body: json.encode(params),
  //   );
  //
  //   print('Response request: ${response.request}');
  //   print('Response status: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //
  //   var data = convert.jsonDecode(response.body);
  //   // print('Data :- ${data}');
  //   if (response == null) {
  //     return null;
  //   } else if (response.statusCode == 200 || response.statusCode == 201) {
  //     // hideLoader(context);
  //     final status = data["success"];
  //     if (status == true) {
  //       // hideLoader(context);
  //       // cleanAllTextForm();
  //       CommonWidget().showToaster(msg: data["message"].toString());
  //       Navigator.push(
  //           context, MaterialPageRoute(builder: (context) => ActivityList()));
  //       // gotoContactScreen(context);
  //       return getAllActivityModel;
  //     } else {
  //       // hideLoader(context);
  //       CommonWidget().showToaster(msg: msg.toString());
  //       return null;
  //     }
  //   } else if (response.statusCode == 422) {
  //     // hideLoader(context);
  //     CommonWidget().showToaster(msg: msg.toString());
  //   } else if (response.statusCode == 401) {
  //     hideLoader(context);
  //     CommonService().unAuthorizedUser();
  //   } else {
  //     // hideLoader(context);
  //     CommonWidget().showToaster(msg: msg.toString());
  //   }
  //
  // }

}
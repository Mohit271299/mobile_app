import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../AppDetails.dart';
import '../../../common/common_widget.dart';
import '../../../common/loader/page_loader.dart';
import '../../../service/commonservice.dart';
import '../../contact_mohit/ui/contactm_listing.dart';
import '../../product/model/getAllCustomerDetails.dart';
import '../../tasks/model/gettasksIdModel.dart';
import '../model/GetAllActivityModel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/GetAllActivityTypeModel.dart';
import '../model/GetIdActivityModel.dart';
import '../ui/activity_listing.dart';

class ActivityController extends GetxController {
  RxBool isactivityLoading = false.obs;
  GetAllActivityModel? getAllActivityModel;
  var getAllActivityModelList = GetAllActivityModel().obs;

  RxBool isCustomerLoading = false.obs;
  GetAllCustomerDetails? getAllCustomerDetails;
  var getAllCustomerModelList = GetAllCustomerDetails().obs;

  RxBool isactivityTaskLoading = false.obs;
  GetAllActivityTypeModel? getAllActivityTypeModel;
  var getAllActivityTaskModelList = GetAllActivityTypeModel().obs;

  RxBool isIdactivityLoading = false.obs;
  GetIdActivityModel? getIdActivityModel;
  var getIdActivityModelList = GetIdActivityModel().obs;

  // Get All Activity Fron API
  Future<dynamic> getAllActivityFromAPI({
    int recordPerPage = 10,
    int pageNumber = 1,
    String sortBy = "name",
  }) async {
    isactivityLoading(true);
    String url = (URLConstants.base_url +
        "activity?recordsPerPage=${recordPerPage.toString()}&pageNumber=${pageNumber.toString()}&sortBy=activityDate&sortOrder=ASC");
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
        getAllActivityModel = GetAllActivityModel.fromJson(data);
        getAllActivityModelList(getAllActivityModel);
        if (status == true) {
          debugPrint(
              '2-2-2-2-2-2 Inside the product Controller Details ${getAllActivityModel!.data!.length}');
          isactivityLoading(false);
          // CommonWidget().showToaster(msg: data["success"].toString());
          return getAllActivityModel;
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

  Future<dynamic> getAllActivityType({
    int recordPerPage = 10,
    int pageNumber = 1,
    String sortBy = "type ",
  }) async {
    isactivityTaskLoading(true);
    String url = (URLConstants.base_url +
        "activity-type?recordsPerPage=${recordPerPage.toString()}&pageNumber=${pageNumber.toString()}&sortBy=activityDate&sortOrder=ASC");
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
        getAllActivityTypeModel = GetAllActivityTypeModel.fromJson(data);
        getAllActivityTaskModelList(getAllActivityTypeModel);
        if (status == true) {
          debugPrint(
              '2-2-2-2-2-2 Inside the product Controller Details ${getAllActivityTypeModel!.data!.length}');
          isactivityTaskLoading(false);
          // CommonWidget().showToaster(msg: data["success"].toString());
          return getAllActivityTypeModel;
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

  // get Customer List
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
          return getAllActivityModel;
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

  TextEditingController task_typeController = new TextEditingController();
  TextEditingController lead_ownerController = new TextEditingController();
  TextEditingController associated_lead_Controller =
      new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  TextEditingController time_neededController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();

  String? birth_date;
  TimeOfDay selectedTime = TimeOfDay.now();
  int? selectedhr;
  int? selectedmn;

  int? activity_id;
  int? customer_id;
  int? owner_id;
  String? customer_name;

  Future<dynamic> storeActivity
      (
      {required BuildContext context,
      required String activityType,
      required String activityTypeId,
      required String associatedName,
      required String associatedLeadId}) async {
    String url = (URLConstants.base_url + URLConstants.ActivityUrl);
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();

    Map params = {
      "activityDate": birth_date,
      "activityDateFormat": "",
      "activityTime": "${selectedTime.hour}:${selectedTime.minute}",
      "activityTypeId": int.parse(activityTypeId),
      "activityTypeName": activityType,
      "addedById": null,
      "associatedLeadId": int.parse(associatedLeadId),
      "associatedName": associatedName,
      "completedById": null,
      "description": descriptionController.text,
      "leadOwnerId": 1,
      "leadOwnerName": lead_ownerController.text,
      "location": addressController.text,
      "timeNeeded": "$selectedhr:$selectedmn",
    };

    // try {
    //   } catch (e) {
    //   // hideLoader(context);
    //   print('1-1-1-1 Get Contacts ${e.toString()}');
    // }
    debugPrint('Add Activity Params => ${params}');
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${tokens.toString()}',
      },
      body: json.encode(params),
    );

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = convert.jsonDecode(response.body);
    // print('Data :- ${data}');
    if (response == null) {
      return null;
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      // hideLoader(context);
      final status = data["success"];
      if (status == true) {
        // hideLoader(context);
        // cleanAllTextForm();
        CommonWidget().showToaster(msg: data["message"].toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ActivityList()));
        // gotoContactScreen(context);
        return getAllActivityModel;
      } else {
        // hideLoader(context);
        CommonWidget().showToaster(msg: msg.toString());
        return null;
      }
    } else if (response.statusCode == 422) {
      // hideLoader(context);
      CommonWidget().showToaster(msg: msg.toString());
    } else if (response.statusCode == 401) {
      hideLoader(context);
      CommonService().unAuthorizedUser();
    } else {
      // hideLoader(context);
      CommonWidget().showToaster(msg: msg.toString());
    }

  }

  Future<dynamic> GetActivityById({
    required BuildContext context,
    required int activityId,
    required int contactId,
  }) async {
    isIdactivityLoading(true);
    String url = (URLConstants.base_url + URLConstants.ActivityUrl + '/$activityId');
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();

    // debugPrint('Get Sales Token ${tokens.toString()}');
    // try { } catch (e) {
    //   print('1-1-1-1 Get tasksId ${e.toString()}');
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
      getIdActivityModel = GetIdActivityModel.fromJson(data);
      getIdActivityModelList(getIdActivityModel);
      // print("final_data : ${getActivityModelList.value.data!.subject}");

      Datum _get = getAllCustomerModelList.value.data!.firstWhere((element) =>
      element.id == getIdActivityModelList.value.data!.associatedLead!.id);
      customer_name = _get.name!;
      customer_id = _get.id!;
      owner_id = getIdActivityModelList.value.data!.leadOwnerId!;

      if (status == true) {
        isIdactivityLoading(false);

        // subjectController.text =
        //     getidtaskModelList.value.data!.subject.toString();
        task_typeController.text =
            getIdActivityModelList.value.data!.activityType!.type!;
        lead_ownerController.text = getIdActivityModelList.value.data!.leadOwnerName!;
        associated_lead_Controller.text = customer_name!;
        addressController.text = getIdActivityModelList.value.data!.location!;
        dateController.text=  getIdActivityModelList.value.data!.activityDate!;
        timeController.text = getIdActivityModelList.value.data!.activityTime!;
        // selectedhr = getIdActivityModelList.value.data!.t
        descriptionController.text = getIdActivityModelList.value.data!.description!;

        // assignToController.text =
        //     getidtaskModelList.value.data!.assignTo.toString();
        // associated_lead_Controller.text = customer_name!;
        // addressController.text =
        //     getidtaskModelList.value.data!.address.toString();
        // fromdateController.text =
        //     getidtaskModelList.value.data!.fromDate!.toString();
        // todateController.text =
        //     getidtaskModelList.value.data!.toDate.toString();
        // reminderdateController.text =
        //     getidtaskModelList.value.data!.reminder.toString();
        // priorityController.text =
        //     getidtaskModelList.value.data!.priority.toString();
        // descriptionController.text =
        //     getidtaskModelList.value.data!.description.toString();

        // CommonWidget().showToaster(msg: msg.toString());
        return getAllActivityModel;
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

  Future<dynamic> storeActivitybyID(
      {required BuildContext context,
        required int activityId,
        required String activityTypeId,
        required String associatedLeadId,
        required String ownerId}) async {
    String url = (URLConstants.base_url + URLConstants.ActivityUrl + '/$activityId');
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();

    Map params = {
      "activityTypeId": int.parse(activityTypeId),
      "leadOwnerId": int.parse(ownerId),
      "associatedLeadId": int.parse(associatedLeadId),
      "location": addressController.text,
      "dateAndTime": DateTime.now().toIso8601String(),
      "description": descriptionController.text,
      "timeNeeded": "11:00",
      "addedById": 1,
      "completedById": null,
      "isCompleted": false
      //
    };

    // try {
    //   } catch (e) {
    //   // hideLoader(context);
    //   print('1-1-1-1 Get Contacts ${e.toString()}');
    // }
    debugPrint('Add tasks Params => $params');
    http.Response response = await http.put(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer ${tokens.toString()}',
      },
      body: json.encode(params),
    );

    print('Response request: ${response.request}');
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var data = convert.jsonDecode(response.body);
    // print('Data :- ${data}');
    if (response == null) {
      return null;
    } else if (response.statusCode == 200 || response.statusCode == 201) {
      // hideLoader(context);
      final status = data["success"];
      if (status == true) {
        // hideLoader(context);
        // cleanAllTextForm();
        CommonWidget().showToaster(msg: data["message"].toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ActivityList()));
        // gotoContactScreen(context);
        return getAllActivityModel;
      } else {
        // hideLoader(context);
        CommonWidget().showToaster(msg: msg.toString());
        return null;
      }
    } else if (response.statusCode == 422) {
      // hideLoader(context);
      CommonWidget().showToaster(msg: msg.toString());
    } else if (response.statusCode == 401) {
      // hideLoader(context);
      CommonService().unAuthorizedUser();
    } else {
      // hideLoader(context);
      CommonWidget().showToaster(msg: msg.toString());
    }
  }

}

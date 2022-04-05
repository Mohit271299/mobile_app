import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tring/screens/tasks/model/gettasksIdModel.dart';
import 'package:tring/screens/tasks/ui/tasks_listing.dart';

import '../../../AppDetails.dart';
import '../../../common/common_widget.dart';
import '../../../service/commonservice.dart';
import '../../activity/model/GetAllActivityTypeModel.dart';
import '../../product/model/getAllCustomerDetails.dart';
import '../../product/model/getAllProductModel.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/getAlltasksModel.dart';

class TasksController extends GetxController {
  RxBool isTasksLoading = false.obs;
  GetAllTasksModel? getAllTasksModel;
  var getAllLeadsModelList = GetAllTasksModel().obs;

  RxBool isCustomerLoading = false.obs;
  GetAllCustomerDetails? getAllCustomerDetails;
  var getAllCustomerModelList = GetAllCustomerDetails().obs;

  RxBool isactivityTaskLoading = false.obs;
  GetAllActivityTypeModel? getAllActivityTypeModel;
  var getAllActivityTaskModelList = GetAllActivityTypeModel().obs;

  RxBool isIdTasksLoading = false.obs;
  GetIDTasksModel? getIDTasksModel;
  var getidtaskModelList = GetIDTasksModel().obs;

  // Get All Tasks Fron API
  Future<dynamic> getAllTasksFromAPI({
    int recordPerPage = 10,
    int pageNumber = 1,
    String sortBy = "ASC",
  }) async {
    // isTasksLoading(true);
    String url = (URLConstants.base_url +
        "task?recordsPerPage=${recordPerPage.toString()}&pageNumber=${pageNumber.toString()}&sortBy=assignTo&sortOrder=ASC");
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();

    // debugPrint('Get Sales Token ${tokens.toString()}');

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
        debugPrint(
            '2-2-2-2-2-2 Inside the product Controller Details ${getAllTasksModel!.data!.length}');
        // isTasksLoading(false);
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
    // try {
    // } catch (e) {
    //   print('1-1-1-1 Get Purchase ${e.toString()}');
    // }
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
      print('1-1-1-1 Get Sales ${e.toString()}');
    }
  }

  TextEditingController task_typeController = new TextEditingController();
  TextEditingController assignToController = new TextEditingController();
  TextEditingController associated_lead_Controller =
      new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController subjectController = new TextEditingController();
  TextEditingController fromdateController = new TextEditingController();
  TextEditingController todateController = new TextEditingController();
  TextEditingController reminderdateController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  TextEditingController time_neededController = new TextEditingController();
  TextEditingController descriptionController = new TextEditingController();
  TextEditingController priorityController = new TextEditingController();

  String? from_date;
  String? to_date;
  String? reminder_date;
  TimeOfDay selectedTime = TimeOfDay.now();
  int? selectedhr;
  int? selectedmn;

  int? task_id;
  int? customer_id;
  int? owner_id;
  String? customer_name;

  Future<dynamic> storeTasks(
      {required BuildContext context,
      required String activityType,
      required String activityTypeId,
      required String associatedName,
      required String associatedLeadId}) async {
    String url = (URLConstants.base_url + URLConstants.taskUrl);
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();

    Map params = {
      "subject": subjectController.text,
      "typeId": int.parse(activityTypeId),
      "contactId": int.parse(associatedLeadId),
      "ownerId": 1,
      "associatedLead": "string",
      "address": addressController.text,
      "fromDate": from_date,
      "toDate": to_date,
      "reminder": reminder_date,
      "priority": priorityController.text,
      "description": descriptionController.text,
      "assignTo": assignToController.text
    };

    // try {
    //   } catch (e) {
    //   // hideLoader(context);
    //   print('1-1-1-1 Get Contacts ${e.toString()}');
    // }
    debugPrint('Add tasks Params => $params');
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
            context, MaterialPageRoute(builder: (context) => TasksList()));
        // gotoContactScreen(context);
        return getAllTasksModel;
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

  Future<dynamic> GetTasksById({
    required BuildContext context,
    required int taskId,
    required int contactId,
  }) async {
    isIdTasksLoading(true);
    String url = (URLConstants.base_url + URLConstants.taskUrl + '/$taskId');
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
      getIDTasksModel = GetIDTasksModel.fromJson(data);
      getidtaskModelList(getIDTasksModel);
      print("final_data : ${getidtaskModelList.value.data!.subject}");

      Datum _get = getAllCustomerModelList.value.data!.firstWhere((element) =>
      element.id == getidtaskModelList.value.data!.contact!.id!);
      customer_name = _get.name!;
      customer_id = _get.id!;
      owner_id = getidtaskModelList.value.data!.ownerId;

      if (status == true) {
        isIdTasksLoading(false);

        subjectController.text =
            getidtaskModelList.value.data!.subject.toString();
        task_typeController.text =
            getidtaskModelList.value.data!.type!.type.toString();
        assignToController.text =
            getidtaskModelList.value.data!.assignTo.toString();
        associated_lead_Controller.text = customer_name!;
        addressController.text =
            getidtaskModelList.value.data!.address.toString();
        fromdateController.text =
            getidtaskModelList.value.data!.fromDate!.toString();
        todateController.text =
            getidtaskModelList.value.data!.toDate.toString();
        reminderdateController.text =
            getidtaskModelList.value.data!.reminder.toString();
        priorityController.text =
            getidtaskModelList.value.data!.priority.toString();
        descriptionController.text =
            getidtaskModelList.value.data!.description.toString();

        // CommonWidget().showToaster(msg: msg.toString());
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

  }

  Future<dynamic> storeTasksbyID(
      {required BuildContext context,
      required int taskId,
      required String activityTypeId,
      required String associatedLeadId,
      required String ownerId}) async {
    String url = (URLConstants.base_url + URLConstants.taskUrl + '/$taskId');
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();

    Map params = {
      "subject": subjectController.text,
      "typeId": int.parse(activityTypeId),
      "contactId": int.parse(associatedLeadId),
      "ownerId": int.parse(ownerId),
      "associatedLead": "string",
      "address": addressController.text,
      "fromDate": fromdateController.text,
      "toDate": todateController.text,
      "reminder": "20/2/2022",
      "priority": priorityController.text,
      "description": descriptionController.text,
      "assignTo": assignToController.text,
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
            context, MaterialPageRoute(builder: (context) => TasksList()));
        // gotoContactScreen(context);
        return getAllTasksModel;
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

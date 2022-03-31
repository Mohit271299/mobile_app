import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../AppDetails.dart';
import '../../../common/common_routing.dart';
import '../../../common/common_widget.dart';
import '../../../common/loader/page_loader.dart';
import '../../../service/commonservice.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import '../model/getAllContactsModel.dart';
import '../ui/contactm_listing.dart';

class ContactsController extends GetxController {
  RxBool isContactsLoading = false.obs;

  GetAllContactsModel? getAllContactsModel;
  var getAllContactsModelList = GetAllContactsModel().obs;

  // Get All Leads Fron API
  Future<dynamic> getAllContactsFromAPI({
    int recordPerPage = 10,
    int pageNumber = 1,
    String sortBy = "name",
  }) async {
    isContactsLoading(true);
    String url = (URLConstants.base_url +
        "contact?recordsPerPage=${recordPerPage.toString()}&pageNumber=${pageNumber.toString()}&sortBy=${sortBy.toString()}");
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
        getAllContactsModel = GetAllContactsModel.fromJson(data);
        getAllContactsModelList(getAllContactsModel);
        if (status == true) {
          debugPrint(
              '2-2-2-2-2-2 Inside the product Controller Details ${getAllContactsModel!.data!.length}');
          isContactsLoading(false);
          // CommonWidget().showToaster(msg: data["success"].toString());
          return getAllContactsModel;
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

  TextEditingController contact_typeController = TextEditingController();
  TextEditingController contact_nameController = TextEditingController();
  TextEditingController contact_mobileController = TextEditingController();
  TextEditingController contact_emailIdController = TextEditingController();
  TextEditingController contact_companyController = TextEditingController();
  TextEditingController contact_bussinessTypeController =
      TextEditingController();
  TextEditingController contact_alternateNoController = TextEditingController();
  TextEditingController contact_phoneController = TextEditingController();
  TextEditingController contact_faxController = TextEditingController();
  TextEditingController contact_websiteController = TextEditingController();
  TextEditingController contact_bithdateController = TextEditingController();
  TextEditingController contact_marriagedateController =
      TextEditingController();
  TextEditingController contact_socialmedaiController = TextEditingController();
  TextEditingController contact_addressController = TextEditingController();
  TextEditingController contact_sourceofpromotionController =
      TextEditingController();
  TextEditingController contact_sourceofcompaignController =
      TextEditingController();
  TextEditingController contact_descriptionController = TextEditingController();

  String? birth_date;
  String? mrg_date;
  String selectedValue = 'Mobile No';
  String selectedValue_promotion = 'Instagram';
  String selectedValue_campaign = 'Mobile No';

  // Store Contacts
  Future<dynamic> storeContacts({required BuildContext context}) async {
    String url = (URLConstants.base_url + URLConstants.ContactUrl);
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();

    Map params = {
      "alternateMobileNo": contact_alternateNoController.text,
      "birthDate": birth_date,
      "businessName": contact_companyController.text,
      "businessType": contact_bussinessTypeController.text,
      "contactOn": selectedValue,
      "contactType": contact_typeController.text,
      "created_at": null,
      "created_by": null,
      "descriptionInformation": contact_descriptionController.text,
      "emailId": contact_emailIdController.text,
      "estimates": null,
      "fax": contact_faxController.text,
      "id": null,
      "leads": null,
      "marriageDate": mrg_date,
      "mobileNo": contact_mobileController.text,
      "name": contact_nameController.text,
      "phoneNo": contact_phoneController.text,
      "purchases": null,
      "sales": null,
      "sameAddress": false,
      "socialMediaAccountLinks": contact_socialmedaiController.text,
      "sourceCampaign": selectedValue_campaign,
      "sourceOfPromotion": selectedValue_promotion,
      "updated_at": null,
      "updated_by": null,
      "website": contact_websiteController.text
    };

    try {
      debugPrint('Add Contacts Params => ${params}');
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
        hideLoader(context);
        final status = data["success"];
        if (status == true) {
          hideLoader(context);
          // cleanAllTextForm();
          CommonWidget().showToaster(msg: data["message"].toString());
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ContactMList()));
          // gotoContactScreen(context);
          return getAllContactsModel;
        } else {
          hideLoader(context);
          // CommonWidget().showToaster(msg: msg.toString());
          return null;
        }
      } else if (response.statusCode == 422) {
        hideLoader(context);
        CommonWidget().showToaster(msg: msg.toString());
      } else if (response.statusCode == 401) {
        hideLoader(context);
        CommonService().unAuthorizedUser();
      } else {
        hideLoader(context);
        CommonWidget().showToaster(msg: msg.toString());
      }
    } catch (e) {
      hideLoader(context);
      print('1-1-1-1 Get Contacts ${e.toString()}');
    }
  }
}

import 'dart:convert' as convert;
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/sales/model/getAllSalesModel.dart';
import 'package:tring/service/commonservice.dart';

import '../../../AppDetails.dart';

class AddContactController extends GetxController {



  RxBool isCheckAddContactValidatation = false.obs;
  RxString businessType = 'One'.obs;
  RxString constactOn = 'Select Contact on'.obs;
  RxString sourcePromation = 'Select Source of Promotion'.obs;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailIdController = TextEditingController();
  final TextEditingController companyBusinessController =
      TextEditingController();
  final TextEditingController alternateMobileNoController =
      TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController contactNoController = TextEditingController();
  final TextEditingController faxController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController dateofbirthController = TextEditingController();
  final TextEditingController marriageDateController = TextEditingController();
  final TextEditingController socialMediaAccountController =
      TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionInformationController =
      TextEditingController();

  cleanErrorMessage() {
    isNameError.value = false;
    isMobileNoError.value = false;
    isEmailError.value = false;
    isCompanyError.value = false;
    isBusinessTypeError.value = false;
    isAlternatePhoneError.value = false;
    isPhoneNoError.value = false;
    isContactOnError.value = false;
    isFaxError.value = false;
    isWebsiteError.value = false;
    isBirthDateError.value = false;
    isMarriageDateError.value = false;
    isSocialMediaError.value = false;
    isAddressError.value = false;
    isSourcefPromotionError.value = false;
    isDescriptionInformationError.value = false;
  }

  RxBool isNameError = false.obs;
  RxBool isMobileNoError = false.obs;
  RxBool isEmailError = false.obs;
  RxBool isCompanyError = false.obs;
  RxBool isBusinessTypeError = false.obs;
  RxBool isAlternatePhoneError = false.obs;
  RxBool isPhoneNoError = false.obs;
  RxBool isContactOnError = false.obs;
  RxBool isFaxError = false.obs;
  RxBool isWebsiteError = false.obs;
  RxBool isBirthDateError = false.obs;
  RxBool isMarriageDateError = false.obs;
  RxBool isSocialMediaError = false.obs;
  RxBool isAddressError = false.obs;
  RxBool isSourcefPromotionError = false.obs;
  RxBool isDescriptionInformationError = false.obs;

  RxString nameErrorMessage = 'Please enter your name.'.obs;
  RxString mobileNoErrorMessage = 'Please enter your mobile no.'.obs;
  RxString emailErrorMessage = 'Please enter your email address.'.obs;
  RxString companyErrorMessage = 'Please enter your company name.'.obs;
  RxString businessTypeErrorMessage = 'Please select your business type.'.obs;
  RxString alternatePhoneErrorMessage = 'Please enter your alternate'.obs;
  RxString phoneNoErrorMessage = 'Please enter your phone no.'.obs;
  RxString contactOnErrorMessage = 'Please select your contact on'.obs;
  RxString faxErrorMessage = 'Please enter your fax'.obs;
  RxString websiteErrorMessage = 'Please enter your website'.obs;
  RxString birthDateErrorMessage = 'Please enter your birth date'.obs;
  RxString marriageDateErrorMessage = 'Please enter your marriage date'.obs;
  RxString socialMediaErrorMessage =
      'Please enter your social media account link'.obs;
  RxString addressErrorMessage = 'Please enter your address.'.obs;
  RxString sourceOfPromotionErrorMessage =
      'Please select your source of promotion.'.obs;
  RxString descriptionInformationErrorMessage =
      'Please enter your descirption information'.obs;

  Future<bool> validateValue({required BuildContext context}) async {
    if (nameController.text.trim().isEmpty) {
      isNameError.value = true;
      return false;
    }
    if (mobileNoController.text.trim().isEmpty) {
      isMobileNoError.value = true;
      return false;
    }
    if (emailIdController.text.trim().isEmpty) {
      isEmailError.value = true;
      return false;
    }
    if (companyBusinessController.text.trim().isEmpty) {
      isCompanyError.value = true;
      return false;
    }
    if (businessType.toString() == 'One') {
      isBusinessTypeError.value = true;
      return false;
    }
    if (alternateMobileNoController.text.trim().isEmpty) {
      isAlternatePhoneError.value = true;
      return false;
    }
    if (phoneNoController.text.trim().isEmpty) {
      isPhoneNoError.value = true;
      return false;
    }
    if (alternateMobileNoController.text.trim().isEmpty) {
      isAlternatePhoneError.value = true;
      return false;
    }
    if (constactOn.value == 'Select Contact on') {
      isContactOnError.value = true;
      return false;
    }
    if (faxController.text.trim().isEmpty) {
      isFaxError.value = true;
      return false;
    }
    if (websiteController.text.trim().isEmpty) {
      isWebsiteError.value = true;
      return false;
    }
    if (dateofbirthController.text.trim().isEmpty) {
      isBirthDateError.value = true;
      return false;
    }
    if (marriageDateController.text.trim().isEmpty) {
      isMarriageDateError.value = true;
      return false;
    }
    if (socialMediaAccountController.text.trim().isEmpty) {
      isSocialMediaError.value = true;
      return false;
    }
    if (addressController.text.trim().isEmpty) {
      isAddressError.value = true;
      return false;
    }
    if (sourcePromation.value == "Select Source of Promotion") {
      isSourcefPromotionError.value = true;
      return false;
    }
    if (descriptionInformationController.text.trim().isEmpty) {
      isDescriptionInformationError.value = true;
      return false;
    }
    return true;
  }

  Future<dynamic> storeContactValue() async {
    String token = await CommonService().getStoreValue(keys: 'token');
    Map params = {
      'name': nameController.text.trim().toString(),
      'contactType': constactOn.toString(),
      'mobileNo': mobileNoController.text.trim().toString(),
      'emailId': emailIdController.text.trim().toString(),
      'businessName': companyBusinessController.text.trim().toString(),
      'businessType': businessType.toString(),
      'alternateMobileNo': alternateMobileNoController.text.trim().toString(),
      'phoneNo': phoneNoController.text.trim().toString(),
      'contactOn': constactOn.toString(),
      'fax': faxController.text.trim().toString(),
      'website': websiteController.text.trim().toString(),
      'birthDate': dateofbirthController.text.trim().toString(),
      'marriageDate': marriageDateController.text.trim().toString(),
      'socialMediaAccountLinks':
          socialMediaAccountController.text.trim().toString(),
      'sameAddress': true,
      'sourceOfPromotion': sourcePromation.toString(),
      'sourceCampaign': 'AAAA',
      'descriptionInformation':
          descriptionInformationController.text.trim().toString(),
    };
    debugPrint('1-1-1-1-1-1 Add Contact Paramater ${params.toString()}');
    debugPrint('1-1-1-1-1-1 Add Contact Token ${token.toString()}');

    String url = (URLConstants.base_url + URLConstants.addContact);
    String msg = '';
    try {
      http.Response response =
          await http.post(Uri.parse(url), body: params, headers: {
        'Authorization': 'Bearer Token $token',
      });
      // ignore: avoid_print
      print('Response request: ${response.request}');
      // ignore: avoid_print
      print('Response status: ${response.statusCode}');
      // ignore: avoid_print
      print('Response body: ${response.body}');
      var data = convert.jsonDecode(response.body);
      msg = data["message"];
      if (response == null) {
        return null;
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        final status = data["success"];
        if (status == true) {
          CommonWidget().showToaster(msg: msg.toString());
          return true;
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
      debugPrint('************** AddContact ${e.toString()}');
    }
  }


}

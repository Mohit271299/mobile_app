import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tring/AppDetails.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/common/loader/page_loader.dart';
import 'package:tring/screens/sales/model/GetSelectFlat.dart';
import 'package:tring/screens/sales/model/GetSelectTown.dart';
import 'package:tring/screens/sales/model/getAllCustomerDetails.dart';
import 'package:tring/screens/sales/model/getAllSalesModel.dart';
import 'package:tring/screens/sales/model/getSelectFloor.dart';
import 'package:tring/service/commonservice.dart';

class SalesController extends GetxController {
  RxBool isTrue = true.obs;
  RxBool isSalesLoading = false.obs;
  RxBool isTowerLoading = false.obs;
  RxBool isFloorLoading = false.obs;
  RxBool isFlatLoading = false.obs;

  final TextEditingController estimateDateDialogController = TextEditingController();
  final TextEditingController estimateNoDialogController = TextEditingController();

  GetAllSalesModel? getAllSalesModel;
  var getAllSalesModelList = GetAllSalesModel().obs;

  // Get All Customer list model
  RxBool isCustomerLoading = false.obs;
  GetAllCustomerDetails? getAllCustomerDetails;
  var getAllCustomerModelList = GetAllCustomerDetails().obs;

  // get Sales Select Town
  GetSelectTown? getSelectTown;
  var getSelectTownModelList = GetSelectTown().obs;

  //Get Sales Select Floor
  GetSelectFloor? getSelectFloor;
  var getSelectFloorModelList = GetSelectFloor().obs;

  // Get Sales Select Flat
  GetSelectFlat? getSelectFlat;
  var getSelectFlatModeList = GetSelectFlat().obs;

  RxDouble showOtherChargesTotal = 0.0.obs;
  RxDouble showHomeLoanChargesTotal = 0.0.obs;
  RxDouble showSalesBillTotal = 0.0.obs;
  RxInt selectFlatId = 0.obs;

  Future<dynamic> billSubmitValidation(
      {required String inVoiceNumber,
        required String invoideDate,
        required BuildContext context}) async {
    isSalesCheckFormValidation.value = true;
    if (flatNoController.text.toString().isNotEmpty &&
        sqftController.text.toString().isNotEmpty &&
        priceperSqftController.text.toString().isNotEmpty &&
        basicAmountController.text.toString().isNotEmpty &&
        gstController.text.toString().isNotEmpty) {
      isSalesCheckFormValidation.value = false;
      storeSales(
        context: context,
        invoideDate: invoideDate.toString(),
        inVoiceNumber: inVoiceNumber.toString(),
      );
    }
  }

  void countSalesBillAmount() {
    showSalesBillTotal.value = 0.0;
    if (int.parse(basicAmountController.text.length.toString()) != 0) {
      showSalesBillTotal.value +=
          double.parse(basicAmountController.text.toString());
    }
    if (int.parse(otherChargesController.text.length.toString()) != 0) {
      showSalesBillTotal.value +=
          double.parse(otherChargesController.text.toString());
    }
    if (int.parse(homeLoanChargeController.text.length.toString()) != 0) {
      showSalesBillTotal.value +=
          double.parse(homeLoanChargeController.text.toString());
    }
    if (int.parse(gstController.text.length.toString()) != 0) {
      showSalesBillTotal.value += double.parse(gstController.text.toString());
    }
  }

  void countBasicAmount() {
    if (int.parse(sqftController.text.length.toString()) != 0 &&
        int.parse(priceperSqftController.text.length.toString()) != 0) {
      double sqft = double.parse(sqftController.text.toString()).ceilToDouble();
      double persSqft =
      double.parse(priceperSqftController.text.toString()).ceilToDouble();
      basicAmountController.text += (sqft * persSqft).toString();
    }
  }

  void countHomeLoanCharges() {
    showHomeLoanChargesTotal.value = 0.0;

    if (int.parse(salesHomeLoanLoanAmountController.text.length.toString()) !=
        0) {
      showHomeLoanChargesTotal.value +=
          double.parse(salesHomeLoanLoanAmountController.text).ceilToDouble();
      // homeLoanChargeController.text = showHomeLoanChargesTotal.value.toString();
    }
    if (int.parse(
        salesHomeLoanInterestChargesController.text.length.toString()) !=
        0) {
      showHomeLoanChargesTotal.value +=
          double.parse(salesHomeLoanInterestChargesController.text)
              .ceilToDouble();
      // homeLoanChargeController.text = showHomeLoanChargesTotal.value.toString();
    }
    if (int.parse(salesHomeLoanLoanProcessingFee.text.length.toString()) != 0) {
      showHomeLoanChargesTotal.value +=
          double.parse(salesHomeLoanLoanProcessingFee.text).ceilToDouble();
      // homeLoanChargeController.text = showHomeLoanChargesTotal.value.toString();
    }
    if (int.parse(
        salesHomeLoanPrepaymentChargesController.text.length.toString()) !=
        0) {
      showHomeLoanChargesTotal.value +=
          double.parse(salesHomeLoanPrepaymentChargesController.text)
              .ceilToDouble();
      // homeLoanChargeController.text = showHomeLoanChargesTotal.value.toString();
    }
    if (int.parse(
        salesHomeLoanLatePaymentChargesController.text.length.toString()) !=
        0) {
      showHomeLoanChargesTotal.value +=
          double.parse(salesHomeLoanLatePaymentChargesController.text)
              .ceilToDouble();
      // homeLoanChargeController.text = showHomeLoanChargesTotal.value.toString();
    }
    if (int.parse(salesHomeLoanApplicationProcessingController.text.length
        .toString()) !=
        0) {
      showHomeLoanChargesTotal.value +=
          double.parse(salesHomeLoanApplicationProcessingController.text)
              .ceilToDouble();
      // homeLoanChargeController.text = showHomeLoanChargesTotal.value.toString();
    }
    if (int.parse(
        salesHomeLoanBrokerageChargesController.text.length.toString()) !=
        0) {
      showHomeLoanChargesTotal.value +=
          double.parse(salesHomeLoanBrokerageChargesController.text)
              .ceilToDouble();
      // homeLoanChargeController.text = showHomeLoanChargesTotal.value.toString();
    }
    if (int.parse(salesHomeLoanInsuranceFeeController.text.length.toString()) !=
        0) {
      showHomeLoanChargesTotal.value +=
          double.parse(salesHomeLoanInsuranceFeeController.text).ceilToDouble();
      // homeLoanChargeController.text = showHomeLoanChargesTotal.value.toString();
    }
    if (int.parse(
        salesHomeLoanMortgageChargesController.text.length.toString()) !=
        0) {
      showHomeLoanChargesTotal.value +=
          double.parse(salesHomeLoanMortgageChargesController.text)
              .ceilToDouble();
      // homeLoanChargeController.text = showHomeLoanChargesTotal.value.toString();
    }
    if (int.parse(salesHomeLoanOtherChargesController.text.length.toString()) !=
        0) {
      showHomeLoanChargesTotal.value +=
          double.parse(salesHomeLoanOtherChargesController.text).ceilToDouble();
      // homeLoanChargeController.text = showHomeLoanChargesTotal.value.toString();
    }
  }

  void countOtherCharges() {
    showOtherChargesTotal.value = 0.0;

    if (int.parse(salesOtherParkingController.text.length.toString()) != 0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherParkingController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherMaintenanceController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherMaintenanceController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherPreferentialController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherPreferentialController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherRegistrationController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherRegistrationController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherStampController.text.length.toString()) != 0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherStampController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherBrokerageController.text.length.toString()) != 0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherBrokerageController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherTitleSalesController.text.length.toString()) != 0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherTitleSalesController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherNotaryController.text.length.toString()) != 0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherNotaryController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherMortgageController.text.length.toString()) != 0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherMortgageController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherOtherController.text.length.toString()) != 0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherOtherController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(
        salesOtherChargesClubmembershipController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesClubmembershipController.text)
              .ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(
        salesOtherChargesCivicamentialController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesCivicamentialController.text)
              .ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherChargesExternalDevelopmentController.text.length
        .toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesExternalDevelopmentController.text)
              .ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherChargesInfrastructureDevelopmentController
        .text.length
        .toString()) !=
        0) {
      showOtherChargesTotal.value += double.parse(
          salesOtherChargesInfrastructureDevelopmentController.text)
          .ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherChargesOverheadController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesOverheadController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(
        salesOtherChargesInsuranceController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesInsuranceController.text)
              .ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherChargesUtilityController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesUtilityController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(
        salesOtherChargesHomeInspectionController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesHomeInspectionController.text)
              .ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(
        salesOtherChargesInteriorsController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesInteriorsController.text)
              .ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(salesOtherChargesPlumbingController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesPlumbingController.text).ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(
        salesOtherChargesFurnitureController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesFurnitureController.text)
              .ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(
        salesOtherChargesElectricWorkController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesElectricWorkController.text)
              .ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(
        salesOtherChargesMiscellaneousController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesMiscellaneousController.text)
              .ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }
    if (int.parse(
        salesOtherChargesBrokerageController.text.length.toString()) !=
        0) {
      showOtherChargesTotal.value +=
          double.parse(salesOtherChargesBrokerageController.text)
              .ceilToDouble();
      // otherChargesController.text = showOtherChargesTotal.value.toString();
    }

    update();
    debugPrint(
        '************ Show Other Charges Total ${showOtherChargesTotal.value.toString()}');
  }

  @override
  void onInit() {
    super.onInit();
    if (CommonService().getStoreValue(keys: 'token').toString().isNotEmpty &&
        CommonService().getStoreValue(keys: 'token').toString() != 'null') {
      getAllSalesFromAPI();
    }
  }

  cleanAllTextForm(){
    getAllSalesFromAPI();
    showHomeLoanChargesTotal.value = 0.0;
    showOtherChargesTotal.value = 0.0;
    showSalesBillTotal.value = 0.0;
    saleseEstimateDateDialogController.clear();
    salesEstimateNoDialogController.clear();
    invoiceNoController.clear();
    invoiceDateController.clear();
    typeOfSalesController.clear();
    flatNoController.clear();
    sqftController.clear();
    salesByEmployeeController.clear();
    salesBrokerNameController.clear();
    priceperSqftController.clear();
    basicAmountController.clear();
    gstController.clear();
    otherChargesController.clear();
    homeLoanChargeController.clear();
    // Sales Other Charges Controller
    salesOtherParkingController.clear();
    salesOtherMaintenanceController.clear();
    salesOtherPreferentialController.clear();
    salesOtherRegistrationController.clear();
    salesOtherStampController.clear();
    salesOtherBrokerageController.clear();
    salesOtherTitleSalesController.clear();
    salesOtherNotaryController.clear();
    salesOtherMortgageController.clear();
    salesOtherOtherController.clear();
    salesOtherChargesClubmembershipController.clear();
    salesOtherChargesCivicamentialController.clear();
    salesOtherChargesExternalDevelopmentController.clear();
    salesOtherChargesInfrastructureDevelopmentController.clear();
    salesOtherChargesOverheadController.clear();
    salesOtherChargesInsuranceController.clear();
    salesOtherChargesUtilityController.clear();
    salesOtherChargesHomeInspectionController.clear();
    salesOtherChargesInteriorsController.clear();
    salesOtherChargesPlumbingController.clear();
    salesOtherChargesFurnitureController.clear();
    salesOtherChargesElectricWorkController.clear();
    salesOtherChargesMiscellaneousController.clear();
    salesOtherChargesBrokerageController.clear();
    salesHomeLoanLoanAmountController.clear();
    salesHomeLoanInterestChargesController.clear();
    salesHomeLoanLoanProcessingFee.clear();
    salesHomeLoanPrepaymentChargesController.clear();
    salesHomeLoanLatePaymentChargesController.clear();
    salesHomeLoanApplicationProcessingController.clear();
    salesHomeLoanBrokerageChargesController.clear();
    salesHomeLoanInsuranceFeeController.clear();
    salesHomeLoanMortgageChargesController.clear();
    salesHomeLoanOtherChargesController.clear();
  }

  RxString typeofSales = "Booked with Token".obs;
  String typeOfSalesErrorMessage = "Please select type of sales";
  String flatnoErrorMessage = "Please enter flat no.";
  String sqftErroMessage = "Please enter sq.ft.";
  String salesByEmployeeError = "Please enter Sales By Employee.";
  String brokerNameError = "Please enter Broker Name.";
  String pricePerSqErrorMessage = "Please enter price per sq.ft.";
  String gstErrorMessage = "Please enter gst no.";
  String otherChargesErrorMessage = "Please enter other charges.";
  String homeLoanErrorMessage = "Please enter home loan charges";
  RxBool isSalesCheckFormValidation = false.obs;
  RxBool isSalesCheckHomeLoanValidation = false.obs;
  TextEditingController saleseEstimateDateDialogController =
  TextEditingController();
  TextEditingController salesEstimateNoDialogController =
  TextEditingController();
  TextEditingController invoiceNoController = TextEditingController();
  TextEditingController invoiceDateController = TextEditingController();
  TextEditingController typeOfSalesController = TextEditingController();
  TextEditingController flatNoController = TextEditingController();
  TextEditingController sqftController = TextEditingController();
  TextEditingController salesByEmployeeController = TextEditingController();
  TextEditingController salesBrokerNameController = TextEditingController();

  TextEditingController priceperSqftController = TextEditingController();
  TextEditingController basicAmountController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController otherChargesController = TextEditingController();
  TextEditingController homeLoanChargeController = TextEditingController();

  // Sales Other Charges Controller
  TextEditingController salesOtherParkingController = TextEditingController();
  TextEditingController salesOtherMaintenanceController =
  TextEditingController();
  TextEditingController salesOtherPreferentialController =
  TextEditingController();
  TextEditingController salesOtherRegistrationController =
  TextEditingController();
  TextEditingController salesOtherStampController = TextEditingController();
  TextEditingController salesOtherBrokerageController = TextEditingController();
  TextEditingController salesOtherTitleSalesController =
  TextEditingController();
  TextEditingController salesOtherNotaryController = TextEditingController();
  TextEditingController salesOtherMortgageController = TextEditingController();
  TextEditingController salesOtherOtherController = TextEditingController();

  // Sales Other Charges
  TextEditingController salesOtherChargesClubmembershipController =
  TextEditingController();
  TextEditingController salesOtherChargesCivicamentialController =
  TextEditingController();
  TextEditingController salesOtherChargesExternalDevelopmentController =
  TextEditingController();
  TextEditingController salesOtherChargesInfrastructureDevelopmentController =
  TextEditingController();
  TextEditingController salesOtherChargesOverheadController =
  TextEditingController();
  TextEditingController salesOtherChargesInsuranceController =
  TextEditingController();
  TextEditingController salesOtherChargesUtilityController =
  TextEditingController();
  TextEditingController salesOtherChargesHomeInspectionController =
  TextEditingController();
  TextEditingController salesOtherChargesInteriorsController =
  TextEditingController();
  TextEditingController salesOtherChargesPlumbingController =
  TextEditingController();
  TextEditingController salesOtherChargesFurnitureController =
  TextEditingController();
  TextEditingController salesOtherChargesElectricWorkController =
  TextEditingController();
  TextEditingController salesOtherChargesMiscellaneousController =
  TextEditingController();
  TextEditingController salesOtherChargesBrokerageController =
  TextEditingController();

  // Sales OtherCharges
  RxBool isSalesOtherChargesClubmembershipError = false.obs;
  RxBool isSalesOtherChargesCivicamentialError = false.obs;
  RxBool isSalesOtherChargesExternalDevelopmentError = false.obs;
  RxBool isSalesOtherChargesInfrastructureDevelopmentError = false.obs;
  RxBool isSalesOtherChargesOverheadError = false.obs;
  RxBool isSalesOtherChargesInsuranceError = false.obs;
  RxBool isSalesOtherChargesUtilityError = false.obs;
  RxBool isSalesOtherChargesHomeInspectionError = false.obs;
  RxBool isSalesOtherChargesInteriorsError = false.obs;
  RxBool isSalesOtherChargesPlumbingError = false.obs;
  RxBool isSalesOtherChargesFurnitureError = false.obs;
  RxBool isSalesOtherChargesElectricWorkError = false.obs;
  RxBool isSalesOtherChargesMiscellaneousError = false.obs;
  RxBool isSalesOtherChargesBrokerageError = false.obs;

  RxBool isCheckSalesValidation = false.obs;
  RxBool isSalesOtherParkingError = false.obs;
  RxBool isSalesOtherMaintenanceError = false.obs;
  RxBool isSalesOtherPreferentialError = false.obs;
  RxBool isSalesOtherRegistrationError = false.obs;
  RxBool isSalesOtherStampError = false.obs;
  RxBool isSalesOtherBrokerageError = false.obs;
  RxBool isSalesOtherTitleSalesError = false.obs;
  RxBool isSalesOtherNotaryError = false.obs;
  RxBool isSalesOtherMortgageError = false.obs;
  RxBool isSalesOtherOtherError = false.obs;

  // Sales HomeLoan
  TextEditingController salesHomeLoanLoanAmountController =
  TextEditingController();
  TextEditingController salesHomeLoanInterestChargesController =
  TextEditingController();
  TextEditingController salesHomeLoanLoanProcessingFee =
  TextEditingController();
  TextEditingController salesHomeLoanPrepaymentChargesController =
  TextEditingController();
  TextEditingController salesHomeLoanLatePaymentChargesController =
  TextEditingController();
  TextEditingController salesHomeLoanApplicationProcessingController =
  TextEditingController();
  TextEditingController salesHomeLoanBrokerageChargesController =
  TextEditingController();
  TextEditingController salesHomeLoanInsuranceFeeController =
  TextEditingController();
  TextEditingController salesHomeLoanMortgageChargesController =
  TextEditingController();
  TextEditingController salesHomeLoanOtherChargesController =
  TextEditingController();

  // Sales HomeLoan Error
  RxBool isSalesHomeLoanLoanAmountError = false.obs;
  RxBool isSalesHomeLoanInterestChargesError = false.obs;
  RxBool isSalesHomeLoanLoanProError = false.obs;
  RxBool isSalesHomeLoanPrepaymentChargesError = false.obs;
  RxBool isSalesHomeLoanLatePaymentChargesError = false.obs;
  RxBool isSalesHomeLoanApplicationProcessingError = false.obs;
  RxBool isSalesHomeLoanBrokerageChargesError = false.obs;
  RxBool isSalesHomeLoanInsuranceFeeError = false.obs;
  RxBool isSalesHomeLoanMortgageChargesError = false.obs;
  RxBool isSalesHomeLoanOtherChargesError = false.obs;

  // Get All Sales Fron API
  Future<dynamic> getAllSalesFromAPI({
    int recordPerPage = 10,
    int pageNumber = 1,
    String sortBy = "invoiceNumber",
  }) async {
    isSalesLoading(true);
    String url = (URLConstants.base_url +
        "sales?recordsPerPage=${recordPerPage.toString()}&pageNumber=${pageNumber.toString()}&sortBy=${sortBy.toString()}");
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
      getAllSalesModel = GetAllSalesModel.fromJson(data);
      getAllSalesModelList(getAllSalesModel);
      if (status == true) {
        isSalesLoading(false);
        // CommonWidget().showToaster(msg: msg.toString());
        return getAllSalesModel;
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
          return getAllSalesModel;
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

  // Get Select Town
  Future<dynamic> getAllTownFromApi() async {
    isTowerLoading(true);
    String url = (URLConstants.base_url + URLConstants.getAllTown);
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
        getSelectTown = GetSelectTown.fromJson(data);
        getSelectTownModelList(getSelectTown);
        if (status == true) {
          isTowerLoading(false);
          // CommonWidget().showToaster(msg: msg.toString());
          return getAllSalesModel;
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


  // Get Select Floor Value
  Future<dynamic> getSelectFloorsFromApi(
      {required int getSelectedTownIndex}) async {
    isFloorLoading(true);
    String url = (URLConstants.base_url +
        URLConstants.getAllFloor +
        getSelectedTownIndex.toString());
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
        getSelectFloor = GetSelectFloor.fromJson(data);
        getSelectFloorModelList(getSelectFloor);
        if (status == true) {
          isFloorLoading(false);
          // CommonWidget().showToaster(msg: msg.toString());
          return getSelectFloor;
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

  // Get Select Flat Value
  Future<dynamic> getSelectFlatFromApi(
      {required int getSelectedFlatIndex}) async {
    isFlatLoading(true);
    String url = (URLConstants.base_url +
        URLConstants.getAllFlat +
        getSelectedFlatIndex.toString());
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
        getSelectFlat = GetSelectFlat.fromJson(data);
        getSelectFlatModeList(getSelectFlat);
        if (status == true) {
          isFlatLoading(false);
          // CommonWidget().showToaster(msg: msg.toString());
          return getSelectFloor;
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

  // Store Sales
  Future<dynamic> storeSales(
      {required BuildContext context,
        required String inVoiceNumber,
        required String invoideDate}) async {
    String url = (URLConstants.base_url + URLConstants.storeSales);
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();

    debugPrint('IOS Date ${selectFlatId.value}');
    Map params = {
      "invoiceNumber": inVoiceNumber.toString(),
      "otherChargeAmount":double.parse(showOtherChargesTotal.value.toString()).ceilToDouble(),
      "invoiceDate": invoideDate.toString(),
      "totalAmount": double.parse(showSalesBillTotal.toString()).ceilToDouble(),
      "contactId": 1,
      "typeOfSale": typeofSales.value.toString(),
      "flatId": int.parse(selectFlatId.value.toString()),
      "squareFeet": (int.parse(sqftController.text.length.toString()) != 0)
          ? double.parse(sqftController.text.toString()).ceilToDouble()
          : 0,
      "pricePerSquareFeet": (int.parse(priceperSqftController.text.length.toString()) != 0)
          ? double.parse(priceperSqftController.text.toString())
          .ceilToDouble()
          : 0,
      "basicAmount": (int.parse(basicAmountController.text.length.toString()) !=
          0)
          ? double.parse(basicAmountController.text.toString()).ceilToDouble()
          : 0,
      "gst": (int.parse(gstController.text.length.toString()) != 0)
          ? double.parse(gstController.text.toString()).ceilToDouble()
          : 0,
      "homeLoanCharges": double.parse(showHomeLoanChargesTotal.value.toString()),
      "salesByEmployee": salesByEmployeeController.text.toString().trim(),
      "brokerName": salesBrokerNameController.text.toString().trim(),
      "otherCharges": {
        "parking":
        (int.parse(salesOtherParkingController.text.length.toString()) != 0)
            ? double.parse(salesOtherParkingController.text.toString())
            .ceilToDouble()
            : 0,
        "maintenanceDeposite": (int.parse(
            salesOtherMaintenanceController.text.length.toString()) !=
            0)
            ? double.parse(salesOtherMaintenanceController.text.toString())
            .ceilToDouble()
            : 0,
        "preferentialLocationCharges": (int.parse(
            salesOtherPreferentialController.text.length.toString()) !=
            0)
            ? double.parse(salesOtherPreferentialController.text.toString())
            .ceilToDouble()
            : 0,
        "registrationFee": (int.parse(
            salesOtherRegistrationController.text.length.toString()) !=
            0)
            ? double.parse(salesOtherRegistrationController.text.toString())
            .ceilToDouble()
            : 0,
        "stampDuty":
        (int.parse(salesOtherStampController.text.length.toString()) != 0)
            ? double.parse(salesOtherStampController.text.toString())
            .ceilToDouble()
            : 0,
        "brokerageCharges":
        (int.parse(salesOtherBrokerageController.text.length.toString()) !=
            0)
            ? double.parse(salesOtherBrokerageController.text.toString())
            .ceilToDouble()
            : 0,
        "titleSalesDeedCharges":
        (int.parse(salesOtherTitleSalesController.text.length.toString()) !=
            0)
            ? double.parse(salesOtherTitleSalesController.text.toString())
            .ceilToDouble()
            : 0,
        "notaryFrankingCharges":
        (int.parse(salesOtherNotaryController.text.length.toString()) != 0)
            ? double.parse(salesOtherNotaryController.text.toString())
            .ceilToDouble()
            : 0,
        "mortgageCharges":
        (int.parse(salesOtherMortgageController.text.length.toString()) !=
            0)
            ? double.parse(salesOtherMortgageController.text.toString())
            .ceilToDouble()
            : 0,
        "otherCharges":
        (int.parse(salesOtherOtherController.text.length.toString()) != 0)
            ? double.parse(salesOtherOtherController.text.toString())
            .ceilToDouble()
            : 0,
        "clubMembership": (int.parse(salesOtherChargesClubmembershipController
            .text.length
            .toString()) !=
            0)
            ? double.parse(
            salesOtherChargesClubmembershipController.text.toString())
            .ceilToDouble()
            : 0,
        "civicAmenitiesCharges": (int.parse(
            salesOtherChargesCivicamentialController.text.length
                .toString()) !=
            0)
            ? double.parse(
            salesOtherChargesCivicamentialController.text.toString())
            .ceilToDouble()
            : 0,
        "externalDevelopmentCharges": (int.parse(
            salesOtherChargesExternalDevelopmentController.text.length
                .toString()) !=
            0)
            ? double.parse(salesOtherChargesExternalDevelopmentController.text
            .toString())
            .ceilToDouble()
            : 0,
        "infrastructureDevelopmentCharges": (int.parse(
            salesOtherChargesInfrastructureDevelopmentController
                .text.length
                .toString()) !=
            0)
            ? double.parse(salesOtherChargesInfrastructureDevelopmentController
            .text
            .toString())
            .ceilToDouble()
            : 0,
        "overheadCharges": (int.parse(salesOtherChargesOverheadController
            .text.length
            .toString()) !=
            0)
            ? double.parse(salesOtherChargesOverheadController.text.toString())
            .ceilToDouble()
            : 0,
        "insuranceFee": (int.parse(salesOtherChargesInsuranceController
            .text.length
            .toString()) !=
            0)
            ? double.parse(salesOtherChargesInsuranceController.text.toString())
            .ceilToDouble()
            : 0,
        "utilityCharges": (int.parse(salesOtherChargesUtilityController
            .text.length
            .toString()) !=
            0)
            ? double.parse(salesOtherChargesUtilityController.text.toString())
            .ceilToDouble()
            : 0,
        "homeInspectionCost": (int.parse(
            salesOtherChargesHomeInspectionController.text.length
                .toString()) !=
            0)
            ? double.parse(
            salesOtherChargesHomeInspectionController.text.toString())
            .ceilToDouble()
            : 0,
        "interiors": (int.parse(salesOtherChargesInteriorsController.text.length
            .toString()) !=
            0)
            ? double.parse(salesOtherChargesInteriorsController.text.toString())
            .ceilToDouble()
            : 0,
        "plumbing": (int.parse(salesOtherChargesPlumbingController.text.length
            .toString()) !=
            0)
            ? double.parse(salesOtherChargesPlumbingController.text.toString())
            .ceilToDouble()
            : 0,
        "furniture": (int.parse(salesOtherChargesFurnitureController.text.length
            .toString()) !=
            0)
            ? double.parse(salesOtherChargesFurnitureController.text.toString())
            .ceilToDouble()
            : 0,
        "electricWork": (int.parse(salesOtherChargesElectricWorkController
            .text.length
            .toString()) !=
            0)
            ? double.parse(
            salesOtherChargesElectricWorkController.text.toString())
            .ceilToDouble()
            : 0,
        "miscellaneousCharges": (int.parse(
            salesOtherChargesMiscellaneousController.text.length
                .toString()) !=
            0)
            ? double.parse(
            salesOtherChargesMiscellaneousController.text.toString())
            .ceilToDouble()
            : 0,
        "loanAmount": (int.parse(
            salesHomeLoanLoanAmountController.text.length.toString()) !=
            0)
            ? double.parse(salesHomeLoanLoanAmountController.text.toString())
            .ceilToDouble()
            : 0,
        "interestCharges": (int.parse(salesHomeLoanInterestChargesController
            .text.length
            .toString()) !=
            0)
            ? double.parse(
            salesHomeLoanInterestChargesController.text.toString())
            .ceilToDouble()
            : 0,
        "loanProcessingFee":
        (int.parse(salesHomeLoanLoanProcessingFee.text.length.toString()) !=
            0)
            ? double.parse(salesHomeLoanLoanProcessingFee.text.toString())
            .ceilToDouble()
            : 0,
        "prepaymentCharges": (int.parse(salesHomeLoanPrepaymentChargesController
            .text.length
            .toString()) !=
            0)
            ? double.parse(
            salesHomeLoanPrepaymentChargesController.text.toString())
            .ceilToDouble()
            : 0,
        "latePaymentCharges": (int.parse(
            salesHomeLoanLatePaymentChargesController.text.length
                .toString()) !=
            0)
            ? double.parse(
            salesHomeLoanLatePaymentChargesController.text.toString())
            .ceilToDouble()
            : 0,
        "applicationProcessingFee": (int.parse(
            salesHomeLoanApplicationProcessingController.text.length
                .toString()) !=
            0)
            ? double.parse(salesHomeLoanApplicationProcessingController.text
            .toString())
            .ceilToDouble()
            : 0,
      }
    };

    try {
      debugPrint('Add Sales Params => ${params}');
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
          cleanAllTextForm();
          CommonWidget().showToaster(msg: data["message"].toString());
          return getAllSalesModel;

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
      print('1-1-1-1 Get Sales ${e.toString()}');
    }
  }
}

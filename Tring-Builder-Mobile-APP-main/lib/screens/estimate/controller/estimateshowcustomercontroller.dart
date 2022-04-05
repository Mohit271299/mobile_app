import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:tring/AppDetails.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/estimate/model/getEstimateModel.dart';
import 'package:tring/screens/purchase/model/getAllCustomerDetails.dart';
import 'package:tring/screens/sales/model/GetSelectFlat.dart';
import 'package:tring/screens/sales/model/GetSelectTown.dart';
import 'package:tring/screens/sales/model/getSelectFloor.dart';
import 'package:tring/service/commonservice.dart';
import 'dart:convert' as convert;
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/getIdEstimateModel.dart';

class EstimateShowCustomeController extends GetxController {
  RxDouble getEstimateTotal = 0.0.obs;
  RxBool isTrue = true.obs;
  RxBool isSalesLoading = false.obs;
  RxBool isTowerLoading = false.obs;
  RxBool isFloorLoading = false.obs;
  RxBool isFlatLoading = false.obs;

  void countBasicAmount({required selectedIndex}) {
    getEstimateTotal.value = 0.0;
    totalAmountController[selectedIndex].text = '0.0';
    showTotalAmountBillWise[selectedIndex] = '';
    if (sqftController[selectedIndex].text.toString().isNotEmpty &&
        int.parse(sqftController[selectedIndex].text.length.toString()) != 0 &&
        pricePerSqController[selectedIndex].text.toString().isNotEmpty &&
        int.parse(pricePerSqController[selectedIndex].text.length.toString()) !=
            0) {
      double sqFtValue =
          double.parse(sqftController[selectedIndex].text.toString());
      double perSqFtValue =
          double.parse(pricePerSqController[selectedIndex].text.toString());
      basicAmountController[selectedIndex].text =
          (sqFtValue * perSqFtValue).toString();
      showTotalAmountBillWise[selectedIndex] =
          basicAmountController[selectedIndex].text.toString();
      totalAmountController[selectedIndex].text =
          showTotalAmountBillWise[selectedIndex].toString();
    }
    if (gstController[selectedIndex].text.toString().isNotEmpty &&
        int.parse(gstController[selectedIndex].text.length.toString()) != 0) {
      totalAmountController[selectedIndex].text =
          (double.parse(totalAmountController[selectedIndex].text.toString()) +
                  double.parse(gstController[selectedIndex].text.toString()))
              .toString();
    }
    if (otherChargesController[selectedIndex].text.toString().isNotEmpty &&
        int.parse(
                otherChargesController[selectedIndex].text.length.toString()) !=
            0) {
      totalAmountController[selectedIndex].text =
          (double.parse(totalAmountController[selectedIndex].text.toString()) +
                  double.parse(
                      otherChargesController[selectedIndex].text.toString()))
              .toString();
    }

    // HomeLoan
    if (homeLoanChargesController[selectedIndex].text.toString().isNotEmpty &&
        int.parse(homeLoanChargesController[selectedIndex]
                .text
                .length
                .toString()) !=
            0) {
      totalAmountController[selectedIndex].text =
          (double.parse(totalAmountController[selectedIndex].text.toString()) +
                  double.parse(
                      homeLoanChargesController[selectedIndex].text.toString()))
              .toString();
    }
    debugPrint('Length ${totalAmountController.length.toString()}');
    for (var element in totalAmountController) {
      getEstimateTotal.value = double.parse(element.text.toString());
    }
  }

  // get Sales Select Town
  GetSelectTown? getSelectTown;
  var getSelectTownModelList = GetSelectTown().obs;

  //Get Sales Select Floor
  GetSelectFloor? getSelectFloor;
  var getSelectFloorModelList = GetSelectFloor().obs;

  // Get Sales Select Flat
  GetSelectFlat? getSelectFlat;
  var getSelectFlatModeList = GetSelectFlat().obs;

  RxBool isEstimateLoading = false.obs;
  RxBool isEstimateCustomerLoading = false.obs;

  GetAllCustomerDetails? getAllEstimateCustomerDetails;
  var getAllEstimateCustomerModelList = GetAllCustomerDetails().obs;

  // Get All Estimate From API
  GetEstimateModel? getEstimateModel;
  var getEstimateModelList = GetEstimateModel().obs;

  RxInt lengthOfEstimate = 1.obs;
  final RxList selectFlatIndexId = [].obs;
  final RxList showTotalAmountBillWise = [].obs;
  final RxList showOtherChargesTotal = [].obs;
  final RxList showHomeLoanTotal = [].obs;
  final RxList estimateFormCheck = [].obs;
  final RxList frequentlyFormCheck = [].obs;
  final RxList otherChargesFormCheck = [].obs;
  final RxList homeLoanFormCheck = [].obs;
  RxBool isCheckEstimateValidation = false.obs;
  RxBool isCheckFrequentlyValidation = false.obs;
  RxBool isCheckHomeLoanValidation = false.obs;
  TextEditingController estimateEstimateDateDialogController =
      TextEditingController();
  TextEditingController estimateEstimateNoDialogController =
      TextEditingController();
  RxInt selectFlatIndex = 0.obs;
  RxString selectFlatNumber = '0'.obs;

  @override
  void onInit() {
    selectFlatIndexId.add(List.generate(1, (index) => '').obs);
    showTotalAmountBillWise.add(List.generate(1, (index) => '').obs);
    showOtherChargesTotal.add(List.generate(1, (index) => 0.0).obs);
    showHomeLoanTotal.add(List.generate(1, (index) => 0.0).obs);
    estimateFormCheck.add(List.generate(6, (index) => false).obs);
    frequentlyFormCheck.add(List.generate(11, (index) => false).obs);
    otherChargesFormCheck.add(List.generate(14, (index) => false).obs);
    homeLoanFormCheck.add(List.generate(10, (index) => false).obs);
    addEstimateFormController();
    addOtherChargesFrequently();
    addHomeLoanForm();
    addOtherFormToOtherForm();
    super.onInit();
  }

  countOtherCharges({required int selectOtherChargesIndex}) {
    debugPrint(
        '1-1-1-1-1-1-1 Other Chrages Index ${selectOtherChargesIndex.toString()}');
  }

  getSubTotalHomeLoanCharges({required int index}) {
    showHomeLoanTotal[index] = 0.0;
    if (int.parse(homeLoanLoanAmountController[int.parse(index.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showHomeLoanTotal[index] += double.parse(
              homeLoanLoanAmountController[int.parse(index.toString())].text)
          .ceilToDouble();
    }
    if (int.parse(homeLoanInterestChargesController[int.parse(index.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showHomeLoanTotal[index] += double.parse(
              homeLoanInterestChargesController[int.parse(index.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(homeLoanLoanProcessingFee[int.parse(index.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showHomeLoanTotal[index] += double.parse(
              homeLoanLoanProcessingFee[int.parse(index.toString())].text)
          .ceilToDouble();
    }
    if (int.parse(
            homeLoanPrepaymentChargesController[int.parse(index.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showHomeLoanTotal[index] += double.parse(
              homeLoanPrepaymentChargesController[int.parse(index.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            homeLoanLatePaymentChargesController[int.parse(index.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showHomeLoanTotal[index] += double.parse(
              homeLoanLatePaymentChargesController[int.parse(index.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            homeLoanApplicationProcessingController[int.parse(index.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showHomeLoanTotal[index] += double.parse(
              homeLoanApplicationProcessingController[
                      int.parse(index.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            homeLoanBrokerageChargesController[int.parse(index.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showHomeLoanTotal[index] += double.parse(
              homeLoanBrokerageChargesController[int.parse(index.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(homeLoanInsuranceFeeController[int.parse(index.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showHomeLoanTotal[index] += double.parse(
              homeLoanInsuranceFeeController[int.parse(index.toString())].text)
          .ceilToDouble();
    }
    if (int.parse(homeLoanMortgageChargesController[int.parse(index.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showHomeLoanTotal[index] += double.parse(
              homeLoanMortgageChargesController[int.parse(index.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(homeLoanOtherChargesController[int.parse(index.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showHomeLoanTotal[index] += double.parse(
              homeLoanOtherChargesController[int.parse(index.toString())].text)
          .ceilToDouble();
    }
  }

  getSubTotalOtherCharges({required int indexs}) {
    // debugPrint(
    //     '2-2-2-2-2-2 getSubTotalOtherCharges ${showOtherChargesTotal[indexs].toString()}');
    // debugPrint(
    //     '2-2-2-2-2-2 getSubTotalOtherCharges Index ${indexs.toString()}');
    showOtherChargesTotal[indexs] = 0.0;
    if (int.parse(otherFrequentlyGstController[int.parse(indexs.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherFrequentlyGstController[int.parse(indexs.toString())].text)
          .ceilToDouble();
    }
    if (int.parse(otherFrequentlyParkingController[int.parse(indexs.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherFrequentlyParkingController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherFrequentlyMaintenanceController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherFrequentlyMaintenanceController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherFrequentlyPreferentialController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherFrequentlyPreferentialController[
                      int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherFrequentlyRegistationController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherFrequentlyRegistationController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(otherFrequentlyStampController[int.parse(indexs.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherFrequentlyStampController[int.parse(indexs.toString())].text)
          .ceilToDouble();
    }
    if (int.parse(
            otherFrequentlyBrokerageController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherFrequentlyBrokerageController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherFrequentlyTitleSalesController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherFrequentlyTitleSalesController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(otherFrequentlyNotaryController[int.parse(indexs.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherFrequentlyNotaryController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherFrequentlyMortgageController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherFrequentlyMortgageController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(otherFrequentlyOtherController[int.parse(indexs.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherFrequentlyOtherController[int.parse(indexs.toString())].text)
          .ceilToDouble();
    }

    if (int.parse(otherChargeOtherClubmembershipController[
                int.parse(indexs.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherClubmembershipController[
                      int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(otherChargeOtherCivicamentialController[
                int.parse(indexs.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherCivicamentialController[
                      int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(otherChargeOtherExternalDevelopmentController[
                int.parse(indexs.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherExternalDevelopmentController[
                      int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(otherChargeOtherInfrastructureDevelopmentController[
                int.parse(indexs.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherInfrastructureDevelopmentController[
                      int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherChargeOtherOverheadController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherOverheadController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherChargeOtherInsuranceController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherInsuranceController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherChargeOtherUtilityController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherUtilityController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(otherChargeOtherHomeInspectionController[
                int.parse(indexs.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherHomeInspectionController[
                      int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherChargeOtherInteriorsController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherInteriorsController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherChargeOtherPlumbingController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherPlumbingController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherChargeOtherFurnitureController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherFurnitureController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherChargeOtherElectricWorkController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherElectricWorkController[
                      int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(otherChargeOtherMiscellaneousController[
                int.parse(indexs.toString())]
            .text
            .length
            .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherMiscellaneousController[
                      int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
    if (int.parse(
            otherChargeOtherBrokerageController[int.parse(indexs.toString())]
                .text
                .length
                .toString()) !=
        0) {
      showOtherChargesTotal[indexs] += double.parse(
              otherChargeOtherBrokerageController[int.parse(indexs.toString())]
                  .text)
          .ceilToDouble();
    }
  }

  addEstimateFormController() {
    flatNoController.add(TextEditingController());
    sqftController.add(TextEditingController());
    pricePerSqController.add(TextEditingController());
    basicAmountController.add(TextEditingController());
    gstController.add(TextEditingController());
    otherChargesController.add(TextEditingController());
    homeLoanChargesController.add(TextEditingController());
    totalAmountController.add(TextEditingController());
  }

  // add sub textEditing controller when click on on OtherChanges
  addOtherChargesFrequently() {
    otherFrequentlyGstController.add(TextEditingController());
    otherFrequentlyParkingController.add(TextEditingController());
    otherFrequentlyMaintenanceController.add(TextEditingController());
    otherFrequentlyPreferentialController.add(TextEditingController());
    otherFrequentlyRegistationController.add(TextEditingController());
    otherFrequentlyStampController.add(TextEditingController());
    otherFrequentlyBrokerageController.add(TextEditingController());
    otherFrequentlyTitleSalesController.add(TextEditingController());
    otherFrequentlyNotaryController.add(TextEditingController());
    otherFrequentlyMortgageController.add(TextEditingController());
    otherFrequentlyOtherController.add(TextEditingController());
  }

  addHomeLoanForm() {
    homeLoanLoanAmountController.add(TextEditingController());
    homeLoanInterestChargesController.add(TextEditingController());
    homeLoanLoanProcessingFee.add(TextEditingController());
    homeLoanPrepaymentChargesController.add(TextEditingController());
    homeLoanLatePaymentChargesController.add(TextEditingController());
    homeLoanApplicationProcessingController.add(TextEditingController());
    homeLoanBrokerageChargesController.add(TextEditingController());
    homeLoanInsuranceFeeController.add(TextEditingController());
    homeLoanMortgageChargesController.add(TextEditingController());
    homeLoanOtherChargesController.add(TextEditingController());
  }

  addOtherFormToOtherForm() {
    otherChargeOtherClubmembershipController.add(TextEditingController());
    otherChargeOtherCivicamentialController.add(TextEditingController());
    otherChargeOtherExternalDevelopmentController.add(TextEditingController());
    otherChargeOtherInfrastructureDevelopmentController
        .add(TextEditingController());
    otherChargeOtherOverheadController.add(TextEditingController());
    otherChargeOtherInsuranceController.add(TextEditingController());
    otherChargeOtherUtilityController.add(TextEditingController());
    otherChargeOtherHomeInspectionController.add(TextEditingController());
    otherChargeOtherInteriorsController.add(TextEditingController());
    otherChargeOtherPlumbingController.add(TextEditingController());
    otherChargeOtherFurnitureController.add(TextEditingController());
    otherChargeOtherElectricWorkController.add(TextEditingController());
    otherChargeOtherMiscellaneousController.add(TextEditingController());
    otherChargeOtherBrokerageController.add(TextEditingController());
  }

  removeOtherChargeOtherForms({required int index}) {
    otherChargeOtherClubmembershipController.removeAt(index);
    otherChargeOtherCivicamentialController.removeAt(index);
    otherChargeOtherExternalDevelopmentController.removeAt(index);
    otherChargeOtherInfrastructureDevelopmentController.removeAt(index);
    otherChargeOtherOverheadController.removeAt(index);
    otherChargeOtherInsuranceController.removeAt(index);
    otherChargeOtherUtilityController.removeAt(index);
    otherChargeOtherHomeInspectionController.removeAt(index);
    otherChargeOtherInteriorsController.removeAt(index);
    otherChargeOtherPlumbingController.removeAt(index);
    otherChargeOtherFurnitureController.removeAt(index);
    otherChargeOtherElectricWorkController.removeAt(index);
    otherChargeOtherMiscellaneousController.removeAt(index);
    otherChargeOtherBrokerageController.removeAt(index);
  }

  removeHomeLoanForm({required int index}) {
    homeLoanLoanAmountController.removeAt(index);
    homeLoanInterestChargesController.removeAt(index);
    homeLoanLoanProcessingFee.removeAt(index);
    homeLoanPrepaymentChargesController.removeAt(index);
    homeLoanLatePaymentChargesController.removeAt(index);
    homeLoanApplicationProcessingController.removeAt(index);
    homeLoanBrokerageChargesController.removeAt(index);
    homeLoanInsuranceFeeController.removeAt(index);
    homeLoanMortgageChargesController.removeAt(index);
    homeLoanOtherChargesController.removeAt(index);
  }

  removeOtherChargesFrequently({required int index}) {
    otherFrequentlyGstController.removeAt(index);
    otherFrequentlyParkingController.removeAt(index);
    otherFrequentlyMaintenanceController.removeAt(index);
    otherFrequentlyPreferentialController.removeAt(index);
    otherFrequentlyRegistationController.removeAt(index);
    otherFrequentlyStampController.removeAt(index);
    otherFrequentlyBrokerageController.removeAt(index);
    otherFrequentlyTitleSalesController.removeAt(index);
    otherFrequentlyNotaryController.removeAt(index);
    otherFrequentlyMortgageController.removeAt(index);
    otherFrequentlyOtherController.removeAt(index);
  }

  removeEstimateFormController({required int indexs}) {
    flatNoController.removeAt(indexs);
    sqftController.removeAt(indexs);
    pricePerSqController.removeAt(indexs);
    basicAmountController.removeAt(indexs);
    gstController.removeAt(indexs);
    otherChargesController.removeAt(indexs);
    homeLoanChargesController.removeAt(indexs);
    totalAmountController.removeAt(indexs);
  }

  RxList<TextEditingController> flatNoController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> sqftController = <TextEditingController>[].obs;
  RxList<TextEditingController> pricePerSqController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> basicAmountController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> gstController = <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargesController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> homeLoanChargesController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> totalAmountController =
      <TextEditingController>[].obs;

  // Other Charges Frequently
  RxList<TextEditingController> otherFrequentlyGstController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherFrequentlyParkingController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherFrequentlyMaintenanceController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherFrequentlyPreferentialController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherFrequentlyRegistationController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherFrequentlyStampController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherFrequentlyBrokerageController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherFrequentlyTitleSalesController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherFrequentlyNotaryController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherFrequentlyMortgageController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherFrequentlyOtherController =
      <TextEditingController>[].obs;

  // Other Charges Other Charge
  RxList<TextEditingController> otherChargeOtherClubmembershipController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargeOtherCivicamentialController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargeOtherExternalDevelopmentController =
      <TextEditingController>[].obs;
  RxList<TextEditingController>
      otherChargeOtherInfrastructureDevelopmentController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargeOtherOverheadController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargeOtherInsuranceController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargeOtherUtilityController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargeOtherHomeInspectionController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargeOtherInteriorsController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargeOtherPlumbingController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargeOtherFurnitureController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargeOtherElectricWorkController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargeOtherMiscellaneousController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> otherChargeOtherBrokerageController =
      <TextEditingController>[].obs;

  // HomeLoan Changes add
  RxList<TextEditingController> homeLoanLoanAmountController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> homeLoanInterestChargesController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> homeLoanLoanProcessingFee =
      <TextEditingController>[].obs;
  RxList<TextEditingController> homeLoanPrepaymentChargesController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> homeLoanLatePaymentChargesController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> homeLoanApplicationProcessingController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> homeLoanBrokerageChargesController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> homeLoanInsuranceFeeController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> homeLoanMortgageChargesController =
      <TextEditingController>[].obs;
  RxList<TextEditingController> homeLoanOtherChargesController =
      <TextEditingController>[].obs;

  addEstimateForm() {
    lengthOfEstimate.value += 1;
    selectFlatIndexId.add(List.generate(1, (index) => '').obs);
    showTotalAmountBillWise.add(List.generate(1, (index) => '').obs);
    showOtherChargesTotal.add(List.generate(1, (index) => 0.0).obs);
    showHomeLoanTotal.add(List.generate(1, (index) => 0.0).obs);
    estimateFormCheck.add(List.generate(6, (index) => false).obs);
    frequentlyFormCheck.add(List.generate(11, (index) => false).obs);
    otherChargesFormCheck.add(List.generate(14, (index) => false).obs);
    homeLoanFormCheck.add(List.generate(10, (index) => false).obs);
    // validateEstimateFormError.add(false);
    addEstimateFormController();
    addOtherChargesFrequently();
    addHomeLoanForm();
    addOtherFormToOtherForm();
  }

  removeEstimateForm({required int removeFormIndex}) {
    if (lengthOfEstimate.value != 1) {
      lengthOfEstimate.value -= 1;
      showTotalAmountBillWise.removeAt(removeFormIndex);
      showOtherChargesTotal.removeAt(removeFormIndex);
      selectFlatIndexId.removeAt(removeFormIndex);
      showHomeLoanTotal.removeAt(removeFormIndex);
      estimateFormCheck.removeAt(removeFormIndex);
      removeEstimateFormController(indexs: removeFormIndex);
      removeOtherChargesFrequently(index: removeFormIndex);
      removeHomeLoanForm(index: removeFormIndex);
      removeOtherChargeOtherForms(index: removeFormIndex);
    }
  }

  // Get All Town
  Future<dynamic> getAllTownFromApi() async {
    isTowerLoading(true);
    String url = (URLConstants.base_url + URLConstants.getAllTown);
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();

    // debugPrint('Get Sales Token ${tokens.toString()}');
    // try {
    // } catch (e) {
    //   print('1-1-1-1 Get Sales ${e.toString()}');
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
      getSelectTown = GetSelectTown.fromJson(data);
      getSelectTownModelList(getSelectTown);
      if (status == true) {
        isTowerLoading(false);
        // CommonWidget().showToaster(msg: msg.toString());
        return getSelectTown;
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

  //get Floor
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

  Future<dynamic> getAllEstimateFromAPI({
    int recordPerPage = 10,
    int pageNumber = 1,
    String sortBy = "estimateNo",
  }) async {
    isEstimateLoading(true);
    String url = (URLConstants.base_url +
        "estimate?recordsPerPage=${recordPerPage.toString()}&pageNumber=${pageNumber.toString()}&sortBy=${sortBy.toString()}");
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();

    // debugPrint('Get Sales Token ${tokens.toString()}');
    // try {
    // } catch (e) {
    //   print('1-1-1-1 Get Estimate ${e.toString()}');
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
      getEstimateModel = GetEstimateModel.fromJson(data);
      getEstimateModelList(getEstimateModel);
      if (status == true) {
        isEstimateLoading(false);
        // CommonWidget().showToaster(msg: msg.toString());
        return getEstimateModel;
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

  Future<dynamic> getAllCustomerFromAPIForEstimate() async {
    isEstimateCustomerLoading(true);
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
        getAllEstimateCustomerDetails = GetAllCustomerDetails.fromJson(data);
        getAllEstimateCustomerModelList(getAllEstimateCustomerDetails);
        if (status == true) {
          isEstimateCustomerLoading(false);
          // CommonWidget().showToaster(msg: msg.toString());
          return getEstimateModel;
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

  Future<dynamic> checkValidationEstimate(
    BuildContext context, {
    required String estimateNo,
    required String estimateDates,
    required contactId,
  }) async {
    String url = (URLConstants.base_url + URLConstants.storeEstimate);
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();
    List items = [];
    for (int i = 0; i < lengthOfEstimate.value; i++) {
      var maps = {
        "squareFeet": (int.parse(sqftController[i].text.length.toString()) != 0)
            ? double.parse(sqftController[i].text.toString()).ceilToDouble()
            : 0,
        "pricePerSquareFeet":
            (int.parse(pricePerSqController[i].text.length.toString()) != 0)
                ? double.parse(pricePerSqController[i].text.toString())
                    .ceilToDouble()
                : 0,
        "basicAmount":
            (int.parse(basicAmountController[i].text.length.toString()) != 0)
                ? double.parse(basicAmountController[i].text.toString())
                    .ceilToDouble()
                : 0,
        "gst": (int.parse(gstController[i].text.length.toString()) != 0)
            ? double.parse(gstController[i].text.toString()).ceilToDouble()
            : 0,
        "flatId": (int.parse(selectFlatIndexId[i].length.toString()) != 0)
            ? double.parse(selectFlatIndexId[i].toString())
            : 0,
        "otherCharges": {
          "parking": (int.parse(otherFrequentlyParkingController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      otherFrequentlyParkingController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "maintenanceDeposite": (int.parse(
                      otherFrequentlyMaintenanceController[i]
                          .text
                          .length
                          .toString()) !=
                  0)
              ? double.parse(
                      otherFrequentlyMaintenanceController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "preferentialLocationCharges": (int.parse(
                      otherFrequentlyPreferentialController[i]
                          .text
                          .length
                          .toString()) !=
                  0)
              ? double.parse(
                      otherFrequentlyPreferentialController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "registrationFee": (int.parse(otherFrequentlyRegistationController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      otherFrequentlyRegistationController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "stampDuty": (int.parse(otherFrequentlyStampController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(otherFrequentlyStampController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "brokerageCharges": (int.parse(otherFrequentlyBrokerageController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      otherFrequentlyBrokerageController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "titleSalesDeedCharges": (int.parse(
                      otherFrequentlyTitleSalesController[i]
                          .text
                          .length
                          .toString()) !=
                  0)
              ? double.parse(
                      otherFrequentlyTitleSalesController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "notaryFrankingCharges": (int.parse(otherFrequentlyNotaryController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(otherFrequentlyNotaryController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "mortgageCharges": (int.parse(otherFrequentlyMortgageController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      otherFrequentlyMortgageController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "otherCharges": (int.parse(otherFrequentlyOtherController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(otherFrequentlyOtherController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "clubMembership": (int.parse(
                      otherChargeOtherClubmembershipController[i]
                          .text
                          .length
                          .toString()) !=
                  0)
              ? double.parse(otherChargeOtherClubmembershipController[i]
                      .text
                      .toString())
                  .ceilToDouble()
              : 0,
          "civicAmenitiesCharges": (int.parse(
                      otherChargeOtherClubmembershipController[i]
                          .text
                          .length
                          .toString()) !=
                  0)
              ? double.parse(otherChargeOtherClubmembershipController[i]
                      .text
                      .toString())
                  .ceilToDouble()
              : 0,
          "externalDevelopmentCharges": (int.parse(
                      otherChargeOtherExternalDevelopmentController[i]
                          .text
                          .length
                          .toString()) !=
                  0)
              ? double.parse(otherChargeOtherExternalDevelopmentController[i]
                      .text
                      .toString())
                  .ceilToDouble()
              : 0,
          "infrastructureDevelopmentCharges": (int.parse(
                      otherChargeOtherInfrastructureDevelopmentController[i]
                          .text
                          .length
                          .toString()) !=
                  0)
              ? double.parse(
                      otherChargeOtherInfrastructureDevelopmentController[i]
                          .text
                          .toString())
                  .ceilToDouble()
              : 0,
          "overheadCharges": (int.parse(otherChargeOtherOverheadController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      otherChargeOtherOverheadController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "insuranceFee": (int.parse(otherChargeOtherInsuranceController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      otherChargeOtherInsuranceController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "utilityCharges": (int.parse(otherChargeOtherUtilityController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      otherChargeOtherUtilityController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "homeInspectionCost": (int.parse(
                      otherChargeOtherHomeInspectionController[i]
                          .text
                          .length
                          .toString()) !=
                  0)
              ? double.parse(otherChargeOtherHomeInspectionController[i]
                      .text
                      .toString())
                  .ceilToDouble()
              : 0,
          "interiors": (int.parse(otherChargeOtherInteriorsController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      otherChargeOtherInteriorsController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "plumbing": (int.parse(otherChargeOtherPlumbingController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      otherChargeOtherPlumbingController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "furniture": (int.parse(otherChargeOtherFurnitureController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      otherChargeOtherFurnitureController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "electricWork": (int.parse(otherChargeOtherElectricWorkController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      otherChargeOtherElectricWorkController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "miscellaneousCharges": (int.parse(
                      otherChargeOtherMiscellaneousController[i]
                          .text
                          .length
                          .toString()) !=
                  0)
              ? double.parse(otherChargeOtherMiscellaneousController[i]
                      .text
                      .toString())
                  .ceilToDouble()
              : 0,
          "loanAmount": (int.parse(
                      homeLoanLoanAmountController[i].text.length.toString()) !=
                  0)
              ? double.parse(homeLoanLoanAmountController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "interestCharges": (int.parse(homeLoanInterestChargesController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      homeLoanInterestChargesController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "loanProcessingFee":
              (int.parse(homeLoanLoanProcessingFee[i].text.length.toString()) !=
                      0)
                  ? double.parse(homeLoanLoanProcessingFee[i].text.toString())
                      .ceilToDouble()
                  : 0,
          "prepaymentCharges": (int.parse(homeLoanPrepaymentChargesController[i]
                      .text
                      .length
                      .toString()) !=
                  0)
              ? double.parse(
                      homeLoanPrepaymentChargesController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "latePaymentCharges": (int.parse(
                      homeLoanLatePaymentChargesController[i]
                          .text
                          .length
                          .toString()) !=
                  0)
              ? double.parse(
                      homeLoanLatePaymentChargesController[i].text.toString())
                  .ceilToDouble()
              : 0,
          "applicationProcessingFee": (int.parse(
                      homeLoanApplicationProcessingController[i]
                          .text
                          .length
                          .toString()) !=
                  0)
              ? double.parse(homeLoanApplicationProcessingController[i]
                      .text
                      .toString())
                  .ceilToDouble()
              : 0,
        }
      };
      items.add(maps);
    }
    print('5-5-5-5-5-5-5 Maps ${items.toString()}');
    if (int.parse(items.length.toString()) != 0) {
      Map params = {
        "estimateNo": estimateNo,
        "estimateDate": estimateDates,
        "contactId": 1,
        "totalAmount": getEstimateTotal.value,
        "estimateItems": items
      };
      try {
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

        if (response == null) {
          return null;
        } else if (response.statusCode == 200 || response.statusCode == 201) {
          final status = data["success"];
          if (status == true) {
            isEstimateCustomerLoading(false);
            CommonWidget().showToaster(msg: data["message"]);
            getAllEstimateFromAPI();
            return 'success';
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
        print('1-1-1-1 Get Estimates ${e.toString()}');
      }
    }
    // debugPrint('Get Sales Token ${tokens.toString()}');
  }

  //getestimatebyId details
  RxBool isIdestimateLoading = false.obs;
  GetIdEstimateModel? getIdEstimateModel;
  var getIdEstimateModelList = GetIdEstimateModel().obs;

  Future<dynamic> GetSalesById({
    required BuildContext context,
    required int estimateId,
  }) async {
    isIdestimateLoading(true);
    String url = (URLConstants.base_url + URLConstants.storeEstimate + '/$estimateId');
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
      getIdEstimateModel = GetIdEstimateModel.fromJson(data);
      getIdEstimateModelList(getIdEstimateModel);

      if (status == true) {
        isIdestimateLoading(false);

        for(var i=0; i<= getIdEstimateModelList.value.data!.estimateItems!.length; i++ ){
          flatNoController[i].text
          = getIdEstimateModelList.value.data!.estimateItems![i].flat!.blockNumber!;
        }
        // subjectController.text =
        //     getidtaskModelList.value.data!.subject.toString();

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
        return getIdEstimateModel;
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


  cleanAll() {
    
    flatNoController.clear();
    sqftController.clear();
    pricePerSqController.clear();
    basicAmountController.clear();
    gstController.clear();
    otherChargesController.clear();
    homeLoanChargesController.clear();
    totalAmountController.clear();
    otherFrequentlyGstController.clear();
    otherFrequentlyParkingController.clear();
    otherFrequentlyMaintenanceController.clear();
    otherFrequentlyPreferentialController.clear();
    otherFrequentlyRegistationController.clear();
    otherFrequentlyStampController.clear();
    otherFrequentlyBrokerageController.clear();
    otherFrequentlyTitleSalesController.clear();
    otherFrequentlyNotaryController.clear();
    otherFrequentlyMortgageController.clear();
    otherFrequentlyOtherController.clear();
    homeLoanLoanAmountController.clear();
    homeLoanInterestChargesController.clear();
    homeLoanLoanProcessingFee.clear();
    homeLoanPrepaymentChargesController.clear();
    homeLoanLatePaymentChargesController.clear();
    homeLoanApplicationProcessingController.clear();
    homeLoanBrokerageChargesController.clear();
    homeLoanInsuranceFeeController.clear();
    homeLoanMortgageChargesController.clear();
    homeLoanOtherChargesController.clear();
    otherChargeOtherClubmembershipController.clear();
    otherChargeOtherCivicamentialController.clear();
    otherChargeOtherExternalDevelopmentController.clear();
    otherChargeOtherInfrastructureDevelopmentController.clear();
    otherChargeOtherOverheadController.clear();
    otherChargeOtherInsuranceController.clear();
    otherChargeOtherUtilityController.clear();
    otherChargeOtherHomeInspectionController.clear();
    otherChargeOtherInteriorsController.clear();
    otherChargeOtherPlumbingController.clear();
    otherChargeOtherFurnitureController.clear();
    otherChargeOtherElectricWorkController.clear();
    otherChargeOtherMiscellaneousController.clear();
    otherChargeOtherBrokerageController.clear();
    showTotalAmountBillWise.clear();
    selectFlatIndexId.clear();
    showOtherChargesTotal.clear();
    showHomeLoanTotal.clear();
    estimateFormCheck.clear();
    frequentlyFormCheck.clear();
    otherChargesFormCheck.clear();
    homeLoanFormCheck.clear();
  }
}

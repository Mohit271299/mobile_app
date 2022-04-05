import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert' as convert;
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tring/AppDetails.dart';
import 'package:tring/common/common_widget.dart';
import 'package:tring/screens/sales/model/getAllCustomerDetails.dart';
import 'package:tring/screens/sales/model/getAllSalesModel.dart';
import 'package:tring/service/commonservice.dart';

import '../model/getAllPurchaseModel.dart';

class PusrhcaseController extends GetxController {
  RxBool isPurchaseLoading = false.obs;

  GetAllPurchaseModel? getAllPurchasesModel;
  var getAllPurchasesModelList = GetAllPurchaseModel().obs;

  // Get All Customer list model
  RxBool isCustomerLoading = false.obs;
  GetAllCustomerDetails? getAllCustomerDetails;
  var getAllCustomerModelList = GetAllCustomerDetails().obs;

  @override
  void onInit() {
    super.onInit();
    if (CommonService().getStoreValue(keys: 'token').toString().isNotEmpty &&
        CommonService().getStoreValue(keys: 'token').toString() != 'null') {
      getAllPurchaseFromAPI();
    }
    selectProductNameId.add(List.generate(1, (index) => '').obs);
    selectPurchaseProductNameController.add(TextEditingController());
    selectPurchaseProductName.add(TextEditingController());
    purchasesHsnControllers.add(TextEditingController());
    purchasesQtyControllers.add(TextEditingController());
    purchasesUnitControllers.add(TextEditingController());
    purchasesRateControllers.add(TextEditingController());
    purchasesDiscountControllers.add(TextEditingController());
    purchasesTaxableValueControllers.add(TextEditingController());
    purchasesTaxControllers.add(TextEditingController());
    purchasesTotalTaxCount.add(TextEditingController());
  }

  RxDouble totalTaxableValue = 0.0.obs;
  RxDouble totalTax = 0.0.obs;
  RxDouble totalAmount = 0.0.obs;

  // calTaxableAmount() {
  //   totalTaxableValue.value = 0.0;
  //   purchasesTaxableValueControllers.forEach((element) {
  //     totalTaxableValue.value += double.parse(element.text.toString());
  //     debugPrint(
  //         '1010101 Inside the purchasse value ${element.text.toString()}');
  //   });
  // }

  calculatePurchase({required selectedIndex}) {
    totalAmount.value = 0.0;
    totalTaxableValue.value = 0.0;
    totalTax.value = 0.0;
    purchasesTotalTaxCount[selectedIndex].text = '0.0';
    double qtyValue = (purchasesQtyControllers.toString().isNotEmpty &&
            int.parse(purchasesQtyControllers[selectedIndex]
                    .text
                    .length
                    .toString()) !=
                0)
        ? double.parse(purchasesQtyControllers[selectedIndex].text.toString())
        : 0.0;
    double rateValue = (purchasesRateControllers.toString().isNotEmpty &&
            int.parse(purchasesRateControllers[selectedIndex]
                    .text
                    .length
                    .toString()) !=
                0)
        ? double.parse(purchasesRateControllers[selectedIndex].text.toString())
        : 0.0;

    double discountValue =
        (purchasesDiscountControllers.toString().isNotEmpty &&
                int.parse(purchasesDiscountControllers[selectedIndex]
                        .text
                        .length
                        .toString()) !=
                    0)
            ? double.parse(
                purchasesDiscountControllers[selectedIndex].text.toString())
            : 0.0;

    double taxValue = (purchasesTaxControllers.toString().isNotEmpty &&
            int.parse(purchasesTaxControllers[selectedIndex]
                    .text
                    .length
                    .toString()) !=
                0)
        ? double.parse(purchasesTaxControllers[selectedIndex].text.toString())
        : 0.0;

    purchasesTaxableValueControllers[selectedIndex].text =
        (double.parse(rateValue.toString()) * double.parse(qtyValue.toString()))
            .toString();

    if (purchasesDiscountControllers[selectedIndex].text.toString() != '0' &&
        purchasesDiscountControllers[selectedIndex]
            .text
            .toString()
            .isNotEmpty) {
      // count the discont
      double applyDiscount = ((double.parse(
                  purchasesTaxableValueControllers[selectedIndex]
                      .text
                      .toString()) *
              discountValue) /
          100);
      // remove the discount from orignal price
      purchasesTaxableValueControllers[selectedIndex].text = (double.parse(
                  purchasesTaxableValueControllers[selectedIndex]
                      .text
                      .toString()) -
              applyDiscount)
          .toString();
      // again count the all taxabke value and additions
      purchasesTaxableValueControllers.forEach((element) {
        totalTaxableValue.value =
            double.parse(totalTaxableValue.value.toString()) +
                double.parse(element.text.toString());
      });
    } else {
      purchasesTaxableValueControllers[selectedIndex].text =
          (double.parse(rateValue.toString()) *
                  double.parse(qtyValue.toString()))
              .toString();
      purchasesTaxableValueControllers.forEach((element) {
        totalTaxableValue.value =
            double.parse(totalTaxableValue.value.toString()) +
                double.parse(element.text.toString());
      });
    }

    if (purchasesTaxControllers[selectedIndex].text.toString() != '0' &&
        purchasesTaxControllers[selectedIndex].text.toString().isNotEmpty) {
      debugPrint(
          '-----------------------------------------------------------------------------');
      double applyTax = ((double.parse(
                  purchasesTaxableValueControllers[selectedIndex]
                      .text
                      .toString()) *
              taxValue) /
          100);
      debugPrint(
          '1-1-1-1-1-1-1-1-1 Inside the TaxController Value ${applyTax.toString()}');
      purchasesTotalTaxCount[selectedIndex].text = applyTax.toString();
      purchasesTotalTaxCount.forEach((element) {
        totalTax.value = double.parse(totalTax.value.toString()) +
            double.parse(element.text.toString());
      });
    } else {
      purchasesTotalTaxCount.forEach((element) {
        debugPrint(
            '0-0-0-0-0-0-0-0-0 Inside the Purchases Total Tax Count ${element.text.toString()}');
        totalTax.value = double.parse(totalTax.value.toString()) +
            double.parse(element.text.toString());
      });
    }
    totalAmount.value = double.parse(totalTax.value.toString()) +
        double.parse(totalTaxableValue.value.toString());
  }

  RxString typeofSales = "One".obs;
  String typeOfSalesErrorMessage = "Please select type of sales";
  String flatnoErrorMessage = "Please enter flat no.";
  String sqftErroMessage = "Please enter sq.ft.";
  String pricePerSqErrorMessage = "Please enter price per sq.ft.";
  String gstErrorMessage = "Please enter gst no.";
  String otherChargesErrorMessage = "Please enter other charges.";
  String homeLoanErrorMessage = "Please enter home loan charges";
  RxBool isSalesCheckFormValidation = false.obs;

  final RxList selectPurchaseProductName = [].obs;
  RxList<TextEditingController> selectPurchaseProductNameController =
      <TextEditingController>[].obs;
  final RxList selectProductNameId = [].obs;
  RxList<TextEditingController> purchasesHsnControllers =
      <TextEditingController>[].obs;
  RxList<TextEditingController> purchasesQtyControllers =
      <TextEditingController>[].obs;
  RxList<TextEditingController> purchasesUnitControllers =
      <TextEditingController>[].obs;
  RxList<TextEditingController> purchasesRateControllers =
      <TextEditingController>[].obs;
  RxList<TextEditingController> purchasesDiscountControllers =
      <TextEditingController>[].obs;
  RxList<TextEditingController> purchasesTaxableValueControllers =
      <TextEditingController>[].obs;
  RxList<TextEditingController> purchasesTaxControllers =
      <TextEditingController>[].obs;

  RxList<TextEditingController> purchasesTotalTaxCount =
      <TextEditingController>[].obs;

  addEstimateForm() {
    lengthOfEstimate.value += 1;
    selectProductNameId.add(List.generate(1, (index) => '0').obs);
    selectPurchaseProductNameController.add(TextEditingController());
    selectPurchaseProductName.add(TextEditingController());
    purchasesHsnControllers.add(TextEditingController());
    purchasesQtyControllers.add(TextEditingController());
    purchasesUnitControllers.add(TextEditingController());
    purchasesRateControllers.add(TextEditingController());
    purchasesDiscountControllers.add(TextEditingController());
    purchasesTaxableValueControllers.add(TextEditingController());
    purchasesTaxControllers.add(TextEditingController());
    purchasesTotalTaxCount.add(TextEditingController());
  }

  cleanAllPurchase() {
    totalTax.value = 0.0;
    totalTaxableValue.value = 0.0;
    totalAmount.value = 0.0;

    for (int i = 0; i < lengthOfEstimate.value; i++) {
      selectProductNameId.removeAt(i);
      selectPurchaseProductNameController.removeAt(i);
      selectPurchaseProductName.removeAt(i);
      purchasesHsnControllers.removeAt(i);
      purchasesQtyControllers.removeAt(i);
      purchasesUnitControllers.removeAt(i);
      purchasesRateControllers.removeAt(i);
      purchasesDiscountControllers.removeAt(i);
      purchasesTaxableValueControllers.removeAt(i);
      purchasesTaxControllers.removeAt(i);
      purchasesTotalTaxCount.removeAt(i);
    }
    purchaseDescriptionController.clear();
    purchaseBillNoController.clear();
    onInit();


  }

  removeEstimateForm({required int removeFromIndex}) {
    if (lengthOfEstimate.value != 1) {
      lengthOfEstimate.value -= 1;
      selectProductNameId.removeAt(removeFromIndex);
      selectPurchaseProductNameController.removeAt(removeFromIndex);
      selectPurchaseProductName.removeAt(removeFromIndex);
      purchasesHsnControllers.removeAt(removeFromIndex);
      purchasesQtyControllers.removeAt(removeFromIndex);
      purchasesUnitControllers.removeAt(removeFromIndex);
      purchasesRateControllers.removeAt(removeFromIndex);
      purchasesDiscountControllers.removeAt(removeFromIndex);
      purchasesTaxableValueControllers.removeAt(removeFromIndex);
      purchasesTaxControllers.removeAt(removeFromIndex);
      purchasesTotalTaxCount.removeAt(removeFromIndex);
      totalTaxableValue.value = 0.0;
      totalTax.value = 0.0;
      totalAmount.value = 0.0;
      manuallyCalTax();
    }
  }

  manuallyCalTax() {
    purchasesTaxableValueControllers.forEach((element) {
      totalTaxableValue.value += double.parse(element.text.toString());
    });

    purchasesTotalTaxCount.forEach((element) {
      totalTax.value = double.parse(totalTax.value.toString()) +
          double.parse(element.text.toString());
    });
    totalAmount.value = totalTaxableValue.value + totalTax.value;
  }

  final TextEditingController purchaseDateDialogController =
      TextEditingController();

  RxInt lengthOfEstimate = 1.obs;
  final TextEditingController purchaseNoDialogController =
      TextEditingController();
  final TextEditingController purchaseDescriptionController =
      TextEditingController();
  final TextEditingController purchaseBillNoController =
      TextEditingController();
  final TextEditingController invoiceNoController = TextEditingController();
  final TextEditingController invoiceDateController = TextEditingController();
  final TextEditingController typeOfSalesController = TextEditingController();
  final TextEditingController flatNoController = TextEditingController();
  final TextEditingController sqftController = TextEditingController();
  final TextEditingController priceperSqftController = TextEditingController();
  final TextEditingController basicAmountController = TextEditingController();
  final TextEditingController gstController = TextEditingController();
  final TextEditingController otherChargesController = TextEditingController();
  final TextEditingController homeLoanChargeController =
      TextEditingController();

  // Get All Sales Fron API
  Future<dynamic> getAllPurchaseFromAPI({
    int recordPerPage = 10,
    int pageNumber = 1,
    String sortBy = "billNo",
  }) async {
    isPurchaseLoading(true);
    String url = (URLConstants.base_url +
        "purchase?recordsPerPage=${recordPerPage.toString()}&pageNumber=${pageNumber.toString()}&sortBy=${sortBy.toString()}");
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
        getAllPurchasesModel = GetAllPurchaseModel.fromJson(data);
        getAllPurchasesModelList(getAllPurchasesModel);
        if (status == true) {
          isPurchaseLoading(false);
          // CommonWidget().showToaster(msg: msg.toString());
          return getAllPurchasesModel;
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

  // Store the purchase details into API
  Future<dynamic> storePurchase({
    required String invoiceDates,
    required String dueDates,
    required String contactId,
  }) async {
    try {
      List items = [];
      for (int i = 0; i < lengthOfEstimate.value; i++) {
        debugPrint(
            '00-00-00-00-00-00-00- Selected Purchase Index Id ${selectProductNameId[i].toString()}');
        var maps = {
          "productId": (int.parse(selectProductNameId[i].toString()) != 0)
              ? int.parse(selectProductNameId[i].toString())
              : 0,
          "hsnCode":
              (int.parse(purchasesHsnControllers[i].text.length.toString()) !=
                      0)
                  ? purchasesHsnControllers[i].text.toString()
                  : '',
          "quantity":
              (int.parse(purchasesQtyControllers[i].text.length.toString()) !=
                      0)
                  ? int.parse(purchasesQtyControllers[i].text.toString())
                  : '',
          "unit":
              (int.parse(purchasesUnitControllers[i].text.length.toString()) !=
                      0)
                  ? double.parse(purchasesUnitControllers[i].text.toString())
                  : 0.0,
          "rate":
              (int.parse(purchasesRateControllers[i].text.length.toString()) !=
                      0)
                  ? double.parse(purchasesRateControllers[i].text.toString())
                  : 0.0,
          "discount": (int.parse(
                      purchasesDiscountControllers[i].text.length.toString()) !=
                  0)
              ? double.parse(purchasesDiscountControllers[i].text.toString())
              : 0.0,
          "tax":
              (int.parse(purchasesTaxControllers[i].text.length.toString()) !=
                      0)
                  ? double.parse(purchasesTaxControllers[i].text.toString())
                  : 0.0,
        };
        items.add(maps);
      }
      String url = (URLConstants.base_url + URLConstants.storePurchase);
      String msg = '';
      String tokens = CommonService().getStoreValue(keys: 'token').toString();
      if (int.parse(items.length.toString()) != 0) {
        Map params = {
          "billNo": purchaseBillNoController.text.toString().trim(),
          "invoiceDate": invoiceDates,
          "dueDate": dueDates,
          "description": purchaseDescriptionController.text.toString(),
          "contactId": int.parse(contactId.toString()),
          "totalAmount": double.parse(totalAmount.value.toString()),
          "totalTaxAmount": double.parse(totalTax.value.toString()),
          "totalTaxableAmount":
              double.parse(totalTaxableValue.value.toString()),
          "purchaseItems": items
        };
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
            cleanAllPurchase();
            CommonWidget().showToaster(msg: data["message"]);
            getAllPurchaseFromAPI();
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
      }
    } catch (e) {
      print('Purchase Store API Called ${e.toString()}');
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
          return getAllPurchasesModel;
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
}

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
import 'package:tring/screens/sales/model/getAllCustomerDetails.dart';
import 'package:tring/screens/sales/model/getAllSalesModel.dart';
import 'package:tring/service/commonservice.dart';

import '../../purchase/model/getAllPurchaseModel.dart';
import '../model/getAllProductModel.dart';
import '../model/getIdProductsModel.dart';

class ProductController extends GetxController {
  RxBool isProductLoading = false.obs;

  GetAllProductModel? getAllProductModel;
  var getAllPurchasesModelList = GetAllProductModel().obs;

  // Get All Customer list model
  RxBool isCustomerLoading = false.obs;
  GetAllCustomerDetails? getAllCustomerDetails;
  var getAllCustomerModelList = GetAllCustomerDetails().obs;

  @override
  void onInit() {
    super.onInit();
    // if (CommonService().getStoreValue(keys: 'token').toString().isNotEmpty &&
    //     CommonService().getStoreValue(keys: 'token').toString() != 'null') {
    //   getAllProduceFromAPI();
    // }
  }

  cleanAllTextForm() {
    productNameController.clear();
    productHSNCodeController.clear();
    productProductQtyController.clear();
    productDescriptionController.clear();
    productUnitController.clear();
    productPurchasePriceController.clear();
    productGSTPurchaseController.clear();
    productSalesPriceController.clear();
    productGSTSalesController.clear();
  }

  Future<dynamic> addProductFromAPI(BuildContext context, {params}) async {
    String url = (URLConstants.base_url + URLConstants.addProducts);
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();
    Map params = {
      "name": productNameController.text.toString().trim(),
      "hsnCode": productHSNCodeController.text.toString().trim(),
      "quantity": productProductQtyController.text.toString(),
      "description": productDescriptionController.text.toString(),
      "unit": productUnitController.text.toString().trim(),
      "purchasePrice": productPurchasePriceController.text.toString().trim(),
      "salesPrice": productSalesPriceController.text.toString().trim(),
      "gstPurchase": productGSTPurchaseController.text.toString().trim(),
      "gstSales": productGSTSalesController.text.toString().trim(),
    };
    try {
      debugPrint('Add Product Params => $params');
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
        final status = data["success"];
        if (status == true) {
          getAllProduceFromAPI();
          cleanAllTextForm();
          CommonWidget().showToaster(msg: data["message"].toString());
          return 'success';
        } else {
          // CommonWidget().showToaster(msg: msg.toString());
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

  final TextEditingController productNameController = TextEditingController();
  final TextEditingController productHSNCodeController = TextEditingController();
  final TextEditingController productProductQtyController = TextEditingController();
  final TextEditingController productDescriptionController = TextEditingController();
  final TextEditingController productUnitController = TextEditingController();
  final TextEditingController productPurchasePriceController = TextEditingController();
  final TextEditingController productGSTPurchaseController = TextEditingController();
  final TextEditingController productSalesPriceController = TextEditingController();
  final TextEditingController productGSTSalesController = TextEditingController();

  RxString typeofSales = "One".obs;
  String typeOfSalesErrorMessage = "Please select type of sales";
  String flatnoErrorMessage = "Please enter flat no.";
  String sqftErroMessage = "Please enter sq.ft.";
  String pricePerSqErrorMessage = "Please enter price per sq.ft.";
  String gstErrorMessage = "Please enter gst no.";
  String otherChargesErrorMessage = "Please enter other charges.";
  String homeLoanErrorMessage = "Please enter home loan charges";
  RxBool isSalesCheckFormValidation = false.obs;


  // Get All Sales Fron API
  Future<dynamic> getAllProduceFromAPI({
    int recordPerPage = 10,
    int pageNumber = 1,
    String sortBy = "name",
  }) async {
    isProductLoading(true);
    String url = (URLConstants.base_url +
        "product?recordsPerPage=${recordPerPage.toString()}&pageNumber=${pageNumber.toString()}&sortBy=${sortBy.toString()}");
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
        getAllProductModel = GetAllProductModel.fromJson(data);
        getAllPurchasesModelList(getAllProductModel);
        if (status == true) {
          debugPrint('2-2-2-2-2-2 Inside the product Controller Details ${getAllProductModel!.data!.length}');
          isProductLoading(false);
          // CommonWidget().showToaster(msg: data["success"].toString());
          return getAllProductModel;
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

  //getsalesbyId details
  RxBool isIdproductsLoading = false.obs;
  GetIdProdcutsModel? getIdProdcutsModel;
  var getIdProductsModelList = GetIdProdcutsModel().obs;

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
          return getAllProductModel;
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

  Future<dynamic> GetproductById({
    required BuildContext context,
    required int productId,
  }) async {
    isIdproductsLoading(true);
    String url = (URLConstants.base_url + URLConstants.addProducts + '/$productId');
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
      getIdProdcutsModel = GetIdProdcutsModel.fromJson(data);
      getIdProductsModelList(getIdProdcutsModel);

      // print("final_data : ${getActivityModelList.value.data!.subject}");

      // Datum _get = getAllCustomerModelList.value.data!.firstWhere((element) =>
      // element.id == getIdActivityModelList.value.data!.associatedLead!.id);
      // customer_name = _get.name!;
      // customer_id = _get.id!;
      // owner_id = getIdActivityModelList.value.data!.leadOwnerId!;

      if (status == true) {
        isIdproductsLoading(false);

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
        productNameController.text = getIdProductsModelList.value.data!.name!;
        productHSNCodeController.text = getIdProductsModelList.value.data!.hsnCode!;
        productProductQtyController.text = getIdProductsModelList.value.data!.quantity!.toString();
        productDescriptionController.text =getIdProductsModelList.value.data!.description!;
        productUnitController.text =getIdProductsModelList.value.data!.unit!.toString();
        productPurchasePriceController.text =getIdProductsModelList.value.data!.purchasePrice!.toString();
        productGSTPurchaseController.text =getIdProductsModelList.value.data!.gstPurchase!.toString();
        productSalesPriceController.text =getIdProductsModelList.value.data!.salesPrice!.toString();
        productGSTSalesController.text =getIdProductsModelList.value.data!.gstSales!.toString();

        return getIdProdcutsModel;
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

  Future<dynamic> addProductById({
    required BuildContext context,
    required int productId,
  }) async {
    String url = (URLConstants.base_url + URLConstants.addProducts + '/$productId');
    String msg = '';
    String tokens = CommonService().getStoreValue(keys: 'token').toString();
    Map params = {
      "name": productNameController.text.toString().trim(),
      "hsnCode": productHSNCodeController.text.toString().trim(),
      "quantity": productProductQtyController.text.toString(),
      "description": productDescriptionController.text.toString(),
      "unit": productUnitController.text.toString().trim(),
      "purchasePrice": productPurchasePriceController.text.toString().trim(),
      "salesPrice": productSalesPriceController.text.toString().trim(),
      "gstPurchase": productGSTPurchaseController.text.toString().trim(),
      "gstSales": productGSTSalesController.text.toString().trim(),
    };
    try {
      debugPrint('Add Product Params => $params');
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
        final status = data["success"];
        if (status == true) {
          getAllProduceFromAPI();
          cleanAllTextForm();
          CommonWidget().showToaster(msg: data["message"].toString());
          return 'success';
        } else {
          // CommonWidget().showToaster(msg: msg.toString());
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

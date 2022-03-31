import 'package:magnet_update/api/http_service/http_service.dart';
import 'package:magnet_update/api/url/api_url.dart';
import 'package:magnet_update/model_class/account_head_model.dart';
import 'package:magnet_update/model_class/cash_memo_model.dart';
import 'package:magnet_update/model_class/contra_model.dart';
import 'package:magnet_update/model_class/customer_ledger_model.dart';
import 'package:magnet_update/model_class/delivery_challan_model.dart';
import 'package:magnet_update/model_class/extimate_invoice_model.dart';
import 'package:magnet_update/model_class/inquiry_model.dart';
import 'package:magnet_update/model_class/other_ledger_model.dart';
import 'package:magnet_update/model_class/payment_model.dart';
import 'package:magnet_update/model_class/product_model.dart';
import 'package:magnet_update/model_class/proforma_invoice_model.dart';
import 'package:magnet_update/model_class/purchase_model.dart';
import 'package:magnet_update/model_class/purchase_order_model.dart';
import 'package:magnet_update/model_class/receipt_model.dart';
import 'package:magnet_update/model_class/credit_note_model.dart';
import 'package:magnet_update/model_class/debit_note_model.dart';
import 'package:magnet_update/model_class/expense_model.dart';
import 'package:magnet_update/model_class/journal_model.dart';
import 'package:magnet_update/model_class/all_ledger_model.dart';
import 'package:magnet_update/model_class/sales_order_model.dart';
import 'package:magnet_update/model_class/state_model.dart';
import 'package:magnet_update/model_class/tax_invoice_model.dart';
import 'package:magnet_update/model_class/vendor_ledger_model.dart';
import 'package:magnet_update/model_class/service_model.dart';
import 'package:magnet_update/model_class/bill_supply_model.dart';
import 'package:magnet_update/utils/preference.dart';

class call_api {
  static Future<List<Data_all_ledger>> get_all_ledger_List(String query) async {
    var url = Api_url.customer_listing_all_modal_api;
    final response = await http_service.get_Data(url);
    List books = response;
    return books.map((json) => Data_all_ledger.fromJson(json)).where((book) {
      final titleLower = book.customers.toString().toLowerCase();
      final authorLower = book.vendors.toString().toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_customers>> getCustomersList(String query) async {
    var url = Api_url.customer_listing_api;
    final response = await http_service.get_Data(url);
    print(response);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_customers.fromJson(json)).where((book) {
      final titleLower = book.billingName!.toLowerCase();
      final authorLower = book.accountName!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_customers>> getCustomers_modal_List(
      String query) async {
    var url = Api_url.customer_listing_modal_api;
    final response = await http_service.get_Data(url);
    print(response);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_customers.fromJson(json)).where((book) {
      final titleLower = book.billingName!.toLowerCase();
      final authorLower = book.accountName!.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_vendors>> getVendorsList(String query) async {
    var url = Api_url.vendors_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_vendors.fromJson(json)).where((book) {
      final titleLower = book.billingName!.toLowerCase();
      final authorLower = book.billingName!.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_vendors>> getVendors_modal_List(String query) async {
    var url = Api_url.vendors_listing_modal_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print('Vendors');
    return books.map((json) => Data_vendors.fromJson(json)).where((book) {
      final titleLower = book.billingName!.toLowerCase();
      final authorLower = book.accountName!.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_others>> getOthersList(String query) async {
    var url = Api_url.others_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_others.fromJson(json)).where((book) {
      final titleLower = book.billingName!.toLowerCase();
      final authorLower = book.accountName!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_others>> getOthers_modal_List(String query) async {
    var url = Api_url.others_listing_modal_api;

    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_others.fromJson(json)).where((book) {
      final titleLower = book.billingName!.toLowerCase();
      final authorLower = book.accountName!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_product>> getProductList(String query) async {
    var url = Api_url.product_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    // print('Product');
    return books.map((json) => Data_product.fromJson(json)).where((book) {
      final titleLower = book.productName!.toLowerCase();
      final authorLower = book.sku!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_service>> getServiceList(String query) async {
    var url = Api_url.service_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_service.fromJson(json)).where((book) {
      final titleLower = book.serviceName!.toLowerCase();
      final authorLower = book.serviceType!.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_purchase>> getPurchaseList(String query) async {
    var url = Api_url.purchase_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_purchase.fromJson(json)).where((book) {
      final titleLower = book.invoiceNumber;
      final authorLower = book.invoiceDate;
      final searchLower = query.toLowerCase();
      return titleLower!.contains(searchLower) ||
          authorLower!.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_tax_invoice>> getTax_invoiceList(String query) async {
    var url = Api_url.tax_invoice_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print("book");
    return books.map((json) => Data_tax_invoice.fromJson(json)).where((book) {
      final titleLower = book.invoiceNumber;
      final authorLower = book.invoiceDate;
      final searchLower = query.toLowerCase();

      return titleLower!.contains(searchLower) ||
          authorLower!.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_bill_supply>> getBill_supply_List(
      String query) async {
    var url = Api_url.bill_of_supply_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print("book");
    return books.map((json) => Data_bill_supply.fromJson(json)).where((book) {
      final titleLower = book.billOfSupplyNumber;
      final authorLower = book.invoiceDate;
      final searchLower = query.toLowerCase();
      return titleLower!.contains(searchLower) ||
          authorLower!.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_cash_memo>> getCash_memo_List(String query) async {
    var url = Api_url.cash_memo_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print("book");
    return books.map((json) => Data_cash_memo.fromJson(json)).where((book) {
      final titleLower = book.srNumber;
      final searchLower = query.toLowerCase();

      return titleLower!.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_proforma_invoice>> getProforma_invoice_List(
      String query) async {
    var url = Api_url.proforma_invoice_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print(books);
    return books
        .map((json) => Data_proforma_invoice.fromJson(json))
        .where((book) {
      final titleLower = book.invoiceNumber;
      final searchLower = query.toLowerCase();

      return titleLower!.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_estimate>> getEstimate_invoice_List(
      String query) async {
    var url = Api_url.estimate_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print("book");
    return books.map((json) => Data_estimate.fromJson(json)).where((book) {
      final titleLower = book.invoiceNumber;
      final searchLower = query.toLowerCase();

      return titleLower!.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_delivery_challan>> getDelivery_challan_List(
      String query) async {
    var url = Api_url.delivery_challan_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print("book");
    return books
        .map((json) => Data_delivery_challan.fromJson(json))
        .where((book) {
      final titleLower = book.challanNumber;
      final searchLower = query.toLowerCase();

      return titleLower!.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_expense>> getExpense_List(String query) async {
    var url = Api_url.expanse_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print(books);
    return books.map((json) => Data_expense.fromJson(json)).where((book) {
      final titleLower = book.srNumber.toString();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_credit_note>> getCredit_note_List(
      String query) async {
    var url = Api_url.credit_note_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print(books);
    return books.map((json) => Data_credit_note.fromJson(json)).where((book) {
      final titleLower = book.creditNoteNumber.toString();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_debit_note>> getdebit_note_List(String query) async {
    var url = Api_url.debit_note_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print(books);
    return books.map((json) => Data_debit_note.fromJson(json)).where((book) {
      final titleLower = book.debitNoteNumber.toString();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_sales_order>> getSales_order_List(
      String query) async {
    var url = Api_url.sells_order_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print(books);
    return books.map((json) => Data_sales_order.fromJson(json)).where((book) {
      final titleLower = book.salesOrderNumber.toString();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_purchase_order>> getPurchase_order_List(
      String query) async {
    var url = Api_url.purchase_order_listing_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print(books);
    return books
        .map((json) => Data_purchase_order.fromJson(json))
        .where((book) {
      final titleLower = book.purchaseOrderNumber.toString();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_receipt>> getreceipt_paymentList(String query) async {
    var url = Api_url.receipt_payment_list_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_receipt.fromJson(json)).where((book) {
      final titleLower = book.customer!.billingName!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_payment>> getpaymentList(String query) async {
    var url = Api_url.payment_list_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_payment.fromJson(json)).where((book) {
      final titleLower = book.entity!.billingName!.toLowerCase();
      final authorLower = book.refNumber!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_contra>> getcontraList(String query) async {
    var url = Api_url.contra_list_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_contra.fromJson(json)).where((book) {
      final titleLower = book.other!.billingName!.toLowerCase();
      final authorLower = book.refNumber!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_journal>> getJournal_List(String query) async {
    var url = Api_url.journal_list_api;
    final response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    print(books);
    return books.map((json) => Data_journal.fromJson(json)).where((book) {
      final titleLower = book.voucherNumber.toString();
      final authorLower = book.globalNarration!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_inquiry>> getInquiryList(String query) async {
    var url = Api_url.inquiry_list_api;
    final response = await http_service.get_Data(url);
    print(response);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_inquiry.fromJson(json)).where((book) {
      final titleLower = book.businessName!.toLowerCase();
      final authorLower = book.inquiryFor!.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();
  }

  static Future<List<Data_state>> state_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url = Api_url.state_list_api;
    var response = await http_service.get_Data(url);
    print(Token);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_state.fromJson(json)).toList();
    // var responseData = json.decode(response.body);
    // setState(() {
    //   stateData = responseData['data'];
    //   print("stateData");
    //   print(stateData);
    //   // SubgroupData = GroupData[1]["sub_groups"];
    // });
    // }
    // print(GroupData);
  }

  static Future<List<Data_ac_head>> accountHead_API() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url = Api_url.account_head_api;
    var response = await http_service.get_Data(url);
    print(Token);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_ac_head.fromJson(json)).toList();
  }

  static Future<List<Data_all_ledger>> all_ledger_List() async {
    Token = await PreferenceManager().getPref(Api_url.token);
    var url = Api_url.customer_listing_all_modal_api;
    var response = await http_service.get_Data(url);
    List books = [];
    if (response["success"]) {
      books = response["data"];
    }
    return books.map((json) => Data_all_ledger.fromJson(json)).toList();
  }
}

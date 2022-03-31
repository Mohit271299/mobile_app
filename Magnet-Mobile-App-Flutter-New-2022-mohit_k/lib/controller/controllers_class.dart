import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:magnet_update/Pagination/binding_utils.dart';

class Login_screen_controller extends GetxController {
  bool isPasswordVisible = false;
  isPasswordVisibleUpdate(bool value) {
    isPasswordVisible = value;
    update();
  }
}
class Otp_screen_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Registration_screen_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Company_profile_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class DashBoard_screen_controller extends GetxController {
  bool isFloatingAction = false;
  isFloatingActionUpdate(bool value) {
    isFloatingAction = value;
    update();
  }
}
class cash_bank_Setup_Controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Cash_bank_Listing_Controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
  bool isFloatingAction = false;
  isFloatingActionUpdate(bool value) {
    isFloatingAction = value;
    update();
  }
}
class Cash_Bank_Edit_controller
    extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Credit_Debit_Listing_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
  bool isFloatingAction = false;
  isFloatingActionUpdate(bool value) {
    isFloatingAction = value;
    update();
  }
}
class Credit_note_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Credit_note_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Debit_note_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Debit_note_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Expense_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Expanse_Listing_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Expense_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}


class Journal_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}

class Journal_Listing_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}

class Sales_Purchase_Listing_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
  bool isFloatingAction = false;
  isFloatingActionUpdate(bool value) {
    isFloatingAction = value;
    update();
  }
}

class Sales_order_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Purchase_order_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Sales_order_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Purchase_order_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}

class inquiry_Setup_controller extends GetxController {
  String pageIndex_customer = '01';
  pageIndexUpdate_customer(String? value) {
    pageIndex_customer = value!;
    update();
  }
}
class inquiry_Listing_controller extends GetxController {
}
class inquiry_Edit_controller extends GetxController {
  String pageIndex_customer = '01';
  pageIndexUpdate(String? value) {
    pageIndex_customer = value!;
    update();
  }
}
class Ledger_Setup_controller extends GetxController {
  String pageIndex_customer = '01';
  pageIndexUpdate_customer(String? value) {
    pageIndex_customer = value!;
    update();
  }
}
class Ledger_Listing_controller extends GetxController {
}
class Ledger_Edit_controller extends GetxController {
  String pageIndex_customer = '01';
  pageIndexUpdate_customer(String? value) {
    pageIndex_customer = value!;
    update();
  }
}
class Product_Service_Setup_controller extends GetxController {

  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Product_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Service_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Product_Service_Listing_controller extends GetxController {

}
class Purchase_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Purchase_Listing_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Purchase_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Sales_Listing_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
  bool isFloatingAction = false;
  isFloatingActionUpdate(bool value) {
    isFloatingAction = value;
    update();
  }
}
class CashMemo_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class BillSupply_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class DeliveryChallan_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }

}
class Estimate_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class ProformaInvoice_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class TaxInvoice_Edit_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Bill_supply_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Cash_memo_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}

class Delivery_challan_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Proforma_invoice_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}

class Tax_Invoice_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class Estimate_Setup_controller extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}

class userprofileScreenController extends GetxController {
  String pageIndex = '01';
  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
}
class SplashScreenController extends GetxController {
  checkForLogin() {
    Get.toNamed(BindingUtils.loginScreenRoute);
    // Get.toNamed(BindingUtils.purchaseRoute);
  }
}

class subscriptionScreenController extends GetxController {

}
class subscriptionScreenPaymentController
    extends GetxController {
  String pageIndex = '01';
  String pageIndex_one = '01';

  pageIndexUpdate(String? value) {
    pageIndex = value!;
    update();
  }
  pageIndexUpdate_one(String? value) {
    pageIndex_one = value!;
    update();
  }
}




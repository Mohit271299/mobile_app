
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:magnet_update/controller/controllers_class.dart';

class Splash_Bindnig implements Bindings {
  @override
  void dependencies() {
    Get.put(SplashScreenController(), tag: SplashScreenController().toString());
  }
}
class Login_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Login_screen_controller(), tag: Login_screen_controller().toString());
  }
}


class otp_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Otp_screen_conrtoller(), tag: Otp_screen_conrtoller().toString());
  }
}

class Otp_screen_conrtoller {
}
class Registration_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Registration_screen_controller(), tag: Registration_screen_controller().toString());
  }
}
class UserProfile_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(userprofileScreenController(), tag: userprofileScreenController().toString());
  }
}

class Cash_Bank_Listing_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Cash_bank_Listing_Controller(), tag: Cash_bank_Listing_Controller().toString());
  }
}
class Cash_Bank_Setup_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(cash_bank_Setup_Controller(), tag: cash_bank_Setup_Controller().toString());
  }
}
class Company_Details_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Company_profile_controller(), tag: Company_profile_controller().toString());
  }
}
class Credit_Debit_Listing_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Credit_Debit_Listing_controller(), tag: Credit_Debit_Listing_controller().toString());
  }
}
class Credit_Note_Edit_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Credit_note_Edit_controller(), tag: Credit_note_Edit_controller().toString());
  }
}
class Credit_Note_Setup_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Credit_note_Setup_controller(), tag: Credit_note_Setup_controller().toString());
  }
}
class Dashboard_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(DashBoard_screen_controller(), tag: DashBoard_screen_controller().toString());
  }
}
class Debit_Note_Edit_Bindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Debit_note_Edit_controller(), tag: Debit_note_Edit_controller().toString());
  }
}
class Debit_Note_Setup_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Debit_note_Setup_controller(), tag: Debit_note_Setup_controller().toString());
  }
}
class Expanse_Listing_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Expanse_Listing_controller(), tag: Expanse_Listing_controller().toString());
  }
}
class Expense_Edit_Bindings implements Bindings {
  @override
  void dependencies() {
    Get.put(Expense_Edit_controller(), tag: Expense_Edit_controller().toString());
  }
}
class Expense_Setup_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Expense_Setup_controller(), tag: Expense_Setup_controller().toString());
  }
}
class Inquiry_Edit_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(inquiry_Edit_controller(), tag: inquiry_Edit_controller().toString());
  }
}
class Inquiry_Listing_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(inquiry_Listing_controller(), tag: inquiry_Listing_controller().toString());
  }
}
class Inquiry_Setup_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(inquiry_Setup_controller(), tag: inquiry_Setup_controller().toString());
  }
}
class Journal_Listing_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Journal_Listing_controller(), tag: Journal_Listing_controller().toString());
  }
}
class Journal_Setup_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Journal_Setup_controller(), tag: Journal_Setup_controller().toString());
  }
}
class Ledger_Edit_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Ledger_Edit_controller(), tag: Ledger_Edit_controller().toString());
  }
}
class Ledger_Listing_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Ledger_Listing_controller(), tag: Ledger_Listing_controller().toString());
  }
}
class Ledger_Setup_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Ledger_Setup_controller(), tag: Ledger_Setup_controller().toString());
  }
}

class Purchase_Order_Edit_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Purchase_order_Edit_controller(), tag: Purchase_order_Edit_controller().toString());
  }
}
class Purchase_Order_Setup_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Purchase_order_Setup_controller(), tag: Purchase_order_Setup_controller().toString());
  }
}
class Sales_Purchase_Listing_Binding
    implements Bindings {
  @override
  void dependencies() {
    Get.put(Sales_Purchase_Listing_controller(), tag: Sales_Purchase_Listing_controller().toString());
  }
}
class Sales_Order_Edit_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Sales_order_Edit_controller(), tag: Sales_order_Edit_controller().toString());
  }
}class Sales_Order_Setup_Binding
    implements Bindings {
  @override
  void dependencies() {
    Get.put(Sales_order_Setup_controller(), tag: Sales_order_Setup_controller().toString());
  }
}

class Product_Service_Listing_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Product_Service_Listing_controller(), tag: Product_Service_Listing_controller().toString());
  }
}
class Product_Service_Setup_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Product_Service_Setup_controller(), tag: Product_Service_Setup_controller().toString());
  }
}
class Product_Edit_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Product_Edit_controller(), tag: Product_Edit_controller().toString());
  }
}
class Service_Edit_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Service_Edit_controller(), tag: Service_Edit_controller().toString());
  }
}
class Purchase_Edit_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Purchase_Edit_controller(), tag: Purchase_Edit_controller().toString());
  }
}
class Purchase_Listing_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Purchase_Listing_controller(), tag: Purchase_Listing_controller().toString());
  }
}
class Purchase_Setup_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Purchase_Setup_controller(), tag: Purchase_Setup_controller().toString());
  }
}
class Sales_Listing_binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Sales_Listing_controller(), tag: Sales_Listing_controller().toString());
  }
}
class Sales_Edit_BillSupply_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(BillSupply_Edit_controller(), tag: BillSupply_Edit_controller().toString());
  }
}
class Sales_Edit_CashMemo_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(CashMemo_Edit_controller(), tag: CashMemo_Edit_controller().toString());
  }
}
class Sales_Edit_DeliveryChallan_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(DeliveryChallan_Edit_controller(), tag: DeliveryChallan_Edit_controller().toString());
  }
}
class Sales_Edit_Estimate_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Estimate_Edit_controller(), tag: Estimate_Edit_controller().toString());
  }
}
class Sales_Edit_ProformaInvoice_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProformaInvoice_Edit_controller(), tag: ProformaInvoice_Edit_controller().toString());
  }
}
class Sales_TaxInvoice_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(TaxInvoice_Edit_controller(), tag: TaxInvoice_Edit_controller().toString());
  }
}
class Sales_setup_Bill_supply_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Bill_supply_Setup_controller(), tag: Bill_supply_Setup_controller().toString());
  }
}
class Sales_Setup_Cash_memo_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Cash_memo_Setup_controller(), tag: Cash_memo_Setup_controller().toString());
  }
}
class Sales_Setup_Delivery_challan_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Delivery_challan_Setup_controller(), tag: Delivery_challan_Setup_controller().toString());
  }
}
class Sales_Setup_Estimate_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Estimate_Setup_controller(), tag: Estimate_Setup_controller().toString());
  }
}
class Sales_Setup_Proforma_Invoice_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Proforma_invoice_Setup_controller(), tag: Proforma_invoice_Setup_controller().toString());
  }
}
class Sales_Setup_TaxInvoice_Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(Tax_Invoice_Setup_controller(), tag: Tax_Invoice_Setup_controller().toString());
  }
}

class subscriptionScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(subscriptionScreenController(), tag: subscriptionScreenController().toString());
  }
}
class subscriptionScreenPaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(subscriptionScreenPaymentController(), tag: subscriptionScreenPaymentController().toString());
  }
}






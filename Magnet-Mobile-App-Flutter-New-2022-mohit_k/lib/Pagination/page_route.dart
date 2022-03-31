
import 'package:get/route_manager.dart';
import 'package:magnet_update/bindings/Bindings_class.dart';
import 'package:magnet_update/screen/Cash_bank_Listing_screen.dart';
import 'package:magnet_update/screen/Cash_bank_Setup_screen.dart';
import 'package:magnet_update/screen/Credit_Debit_Listing_screen.dart';
import 'package:magnet_update/screen/Credit_note_Setup_screen.dart';
import 'package:magnet_update/screen/Debit_note_Setup_screen.dart';
import 'package:magnet_update/screen/Expanse_Listing_screen.dart';
import 'package:magnet_update/screen/Expense_Setup_screen.dart';
import 'package:magnet_update/screen/Inquiry_Listing_screen.dart';
import 'package:magnet_update/screen/Inquiry_Setup_screen.dart';
import 'package:magnet_update/screen/Journal_Listing_screen.dart';
import 'package:magnet_update/screen/Journal_Setup_screen.dart';
import 'package:magnet_update/screen/Ledger_Edit_screen.dart';
import 'package:magnet_update/screen/Ledger_Listing_screen.dart';
import 'package:magnet_update/screen/Ledger_Setup_screen.dart';
import 'package:magnet_update/screen/Product_Service_Listing_screen.dart';
import 'package:magnet_update/screen/Product_Service_Setup_screen.dart';
import 'package:magnet_update/screen/Purchase_Listing_screen.dart';
import 'package:magnet_update/screen/Purchase_Order_Setup_screen.dart';
import 'package:magnet_update/screen/Purchase_Setup_screen.dart';
import 'package:magnet_update/screen/Sales_Listing_screen.dart';
import 'package:magnet_update/screen/Sales_Order_Setup_screen.dart';
import 'package:magnet_update/screen/Sales_Purchase_Listing_screen.dart';
import 'package:magnet_update/screen/company_profile_screen.dart';
import 'package:magnet_update/screen/homapage/home_page_screen.dart';
import 'package:magnet_update/screen/log_in_screen.dart';

import 'package:magnet_update/screen/Sales_tax_invoice_Edit_screen.dart';
import 'package:magnet_update/screen/Sales_estimate_Setup_screen.dart';
import 'package:magnet_update/screen/Sales_bill_of_supply_Setup_screen.dart';
import 'package:magnet_update/screen/Sales_cash_memo_Setup_screen.dart';
import 'package:magnet_update/screen/Sales_delivery_challan_Setup_screen.dart';
import 'package:magnet_update/screen/Sales_proforma_invoice_Setup_screen.dart';
import 'package:magnet_update/screen/Sales_tax_invoice_Setup_screen.dart';
import 'package:magnet_update/screen/User_profile_screen.dart';
import 'package:magnet_update/screen/registration_screen.dart';
import 'package:magnet_update/screen/splash_screen.dart';
import 'package:magnet_update/screen/subscription_screen.dart';
import 'package:magnet_update/screen/subscription_screen_payment.dart';

import 'binding_utils.dart';

class AppPages {
  static final getPageList = [
    GetPage(
      name: BindingUtils.splashRoute,
      page: () => SplashScreen(),
      binding: Splash_Bindnig(),
    ),
    // GetPage(
    //   name: BindingUtils.welcomeScreenRoute,
    //   page: () => WelComeScreen(),
    // ),
    GetPage(
      name: BindingUtils.loginScreenRoute,
      page: () => loginScreen(),
      binding: Login_Binding(),
    ),
    // GetPage(
    //   name: BindingUtils.otpVerificationScreenRoute,
    //   page: () => OTPVerificationScreen(),
    //   binding: OTPVerificationBindings(),
    // ),
    GetPage(
      name: BindingUtils.add_company,
      page: () => addCompanyScreen(),
      binding: Company_Details_Binding(),
    ),

    GetPage(
      name: BindingUtils.registrationScreenRoute,
      page: () => registrationScreen(),
      binding: Registration_Binding(),
    ),
    // GetPage(
    //   name: BindingUtils.purchaseRoute,
    //   page: () => PurchaseScreen(),
    //   binding: PurchaseBindnigs(),
    // ),
    GetPage(
      name: BindingUtils.dashBoardScreenRoute,
      page: () => DashBoardScreen(),
      binding: Dashboard_Binding(),
    ),
    GetPage(
      name: BindingUtils.subscriptionRoute,
      page: () => subscription_Screen(),
      binding: subscriptionScreenBinding(),
    ),
    GetPage(
      name: BindingUtils.subscriptionPaymentRoute,
      page: () => subscriptionPayment_screen(),
      binding: subscriptionScreenPaymentBinding(),
    ),

    GetPage(
      name: BindingUtils.ledgerScreenRoute,
      page: () => ledgerScreen(),
      binding: Ledger_Listing_Binding(),
    ),
    GetPage(
          name: BindingUtils.ledgerScreenEditRoute,
          page: () => ledgerEditScreen(),
          binding: Ledger_Edit_Binding(),
        ),

    GetPage(
      name: BindingUtils.ledgerSetupScreenRoute,
      page: () => ledgerSetupScreen(),
      binding: Ledger_Setup_Binding(),
    ),
    GetPage(
      name: BindingUtils.purchaseRoute,
      page: () => purchaseScreen(),
      binding: Purchase_Listing_Binding(),
    ),
    GetPage(
      name: BindingUtils.purchase_setup_Route,
      page: () => purchaseSetupScreen(),
      binding: Purchase_Setup_Binding(),
    ),

    GetPage(
      name: BindingUtils.cash_bankScreenRoute,
      page: () => cash_bank_entry_Screen(),
      binding: Cash_Bank_Listing_Binding(),
    ),
    GetPage(
      name: BindingUtils.cash_bank_setupScreenRoute,
      page: () => cash_bankSetupScreen(),
      binding: Cash_Bank_Setup_Binding(),
    ),

    GetPage(
      name: BindingUtils.sales_ScreenRoute,
      page: () => salesScreen(),
      binding: Sales_Listing_binding(),
    ),

    GetPage(
      name: BindingUtils.user_profile_ScreenRoute,
      page: () => user_profileScreen(),
      binding: UserProfile_Binding(),
    ),
    GetPage(
      name: BindingUtils.product_service_ScreenRoute,
      page: () => product_serviceScreen(),
      binding: Product_Service_Listing_Binding(),
    ),
    GetPage(
      name: BindingUtils.product_service_setup_ScreenRoute,
      page: () => product_setup(),
      binding: Product_Service_Setup_Binding(),
    ),
    GetPage(
      name: BindingUtils.sales_ScreenRoute,
      page: () => salesScreen(),
      binding: Sales_Listing_binding(),
    ),
    GetPage(
      name: BindingUtils.tax_invoice_setup_ScreenRoute,
      page: () => taxInvoiceScreen(),
      binding: Sales_Setup_TaxInvoice_Binding(),
    ),
    GetPage(
      name: BindingUtils.tax_invoice_edit_ScreenRoute,
      page: () => taxInvoiceEditScreen(),
      binding: Sales_TaxInvoice_Binding(),
    ),

    GetPage(
      name: BindingUtils.bill_supply_setup_ScreenRoute,
      page: () => billSupplyScreen(),
      binding: Sales_setup_Bill_supply_Binding(),
    ),
    GetPage(
      name: BindingUtils.cash_memo_setup_ScreenRoute,
      page: () => cash_memoScreen(),
      binding: Sales_Setup_Cash_memo_Binding(),
    ),
    GetPage(
      name: BindingUtils.proforma_invoice_ScreenRoute,
      page: () => proformaInvoiceScreen(),
      binding: Sales_Setup_Proforma_Invoice_Binding(),
    ),
    GetPage(
      name: BindingUtils.estimate_ScreenRoute,
      page: () => estimateScreen(),
      binding: Sales_Setup_Estimate_Binding(),
    ),
    GetPage(
      name: BindingUtils.delivery_challan_ScreenRoute,
      page: () => delivery_challanScreen(),
      binding: Sales_Setup_Delivery_challan_Binding(),
    ),
    GetPage(
      name: BindingUtils.expanses_ScreenRoute,
      page: () => expanseScreen(),
      binding: Expanse_Listing_Binding(),
    ),
    GetPage(
      name: BindingUtils.expanses_Screen_SetupRoute,
      page: () => expenseSetupScreen(),
      binding: Expense_Setup_Binding(),
    ),
    GetPage(
      name: BindingUtils.credit_debit_Screen_Route,
      page: () => credit_debitScreen(),
      binding: Credit_Debit_Listing_Binding(),
    ),
    GetPage(
      name: BindingUtils.credit_note_Screen_SetupRoute,
      page: () => credit_noteScreen(),
      binding: Credit_Note_Setup_Binding(),
    ),
    GetPage(
      name: BindingUtils.debit_note_Screen_SetupRoute,
      page: () => debit_noteScreen(),
      binding: Debit_Note_Setup_Binding(),
    ),
    GetPage(
      name: BindingUtils.sales_purchase_Screen_Route,
      page: () => sales_purchaseScreen(),
      binding: Sales_Purchase_Listing_Binding(),
    ),
    GetPage(
      name: BindingUtils.sales_order_Screen_SetupRoute,
      page: () => sales_orderScreen(),
      binding: Sales_Order_Setup_Binding(),
    ),
    GetPage(
      name: BindingUtils.purchase_order_Screen_SetupRoute,
      page: () => purchase_orderScreen(),
      binding: Purchase_Order_Setup_Binding(),
    ),
    GetPage(
      name: BindingUtils.journal_Screen_Route,
      page: () => journalScreen(),
      binding: Journal_Listing_Binding(),
    ),
    GetPage(
      name: BindingUtils.journal_Screen_SetupRoute,
      page: () => journalSetupScreen(),
      binding: Journal_Setup_Binding(),
    ),
   GetPage(
        name: BindingUtils.inquiry_Screen_Route,
        page: () => inquiryScreen(),
        binding: Inquiry_Listing_Binding(),
      ),
    GetPage(
            name: BindingUtils.inquiry_Screen_SetupRoute,
            page: () => inquirySetupScreen(),
            binding: Inquiry_Setup_Binding(),
          ),

  ];
}

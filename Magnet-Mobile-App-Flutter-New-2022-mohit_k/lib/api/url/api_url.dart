
class Api_url{
  static final main_magnet_url = 'https://magnetbackend.fsp.media/api/';

  static final Registration_api =  main_magnet_url + 'account/register';
  static final Login_api = main_magnet_url+ 'auth/login';
  static final Company_profile_api = main_magnet_url+ 'company-profile';
  static final skip_api = main_magnet_url+ 'subscription/free-trial';

  static final customer_ledger_api = main_magnet_url+ 'customers';
  static final vendors_ledger_api = main_magnet_url+ 'vendors';
  static final others_ledger_api = main_magnet_url+ 'others';
  static final company_list_api = main_magnet_url+ '/company-profile/all-company/';
  static final company_switch_api = main_magnet_url+ '/company-profile/switchCompany/';

  static final customer_listing_api = main_magnet_url+ 'customers?recordsPerPage=10&pageNumber=1&sortBy=company_name&sortOrder=ASC';
  static final customer_listing_modal_api = main_magnet_url+ 'customers/modal?recordsPerPage=10&pageNumber=1&sortBy=company_name&sortOrder=ASC';
  static final customer_listing_all_modal_api = main_magnet_url+ 'customers/all-ledgers/modal?recordsPerPage=10';

  static final vendors_listing_api = main_magnet_url+ 'vendors?recordsPerPage=10&pageNumber=1&sortBy=company_name&sortOrder=ASC';
  static final vendors_listing_modal_api = main_magnet_url+ 'vendors/modal?recordsPerPage=10&pageNumber=1&sortBy=company_name&sortOrder=ASC';

  static final others_listing_api = main_magnet_url+ 'others?recordsPerPage=10&pageNumber=1&sortBy=company_name&sortOrder=ASC';
  static final others_listing_modal_api = main_magnet_url+ 'others/modal?recordsPerPage=10&pageNumber=1&sortBy=company_name&sortOrder=ASC';

  static final product_add_api = main_magnet_url+ 'product';
  static final service_add_api = main_magnet_url+ 'service-master';

  static final product_listing_api = main_magnet_url+ 'product?recordsPerPage=10&pageNumber=1&sortBy=product_name&sortOrder=ASC';
  static final service_listing_api = main_magnet_url+ 'service-master?recordsPerPage=10&pageNumber=1&sortBy=service_name&sortOrder=ASC';

  static final purchase_add_api = main_magnet_url+ 'purchase';
  static final purchase_listing_api = main_magnet_url+ 'purchase?recordsPerPage=10&pageNumber=1&sortBy=invoice_date&sortOrder=ASC';

  static final tax_invoice_add_api = main_magnet_url+ 'taxinvoice';
    static final tax_invoice_listing_api = main_magnet_url+ 'taxinvoice?recordsPerPage=10&pageNumber=1&sortBy=invoice_date&sortOrder=ASC';

  static final bill_of_supply_add_api = main_magnet_url+ 'bill-of-supply';
  static final bill_of_supply_listing_api = main_magnet_url+ 'bill-of-supply?recordsPerPage=10&pageNumber=1&sortBy=invoice_date&sortOrder=ASC';

  static final cash_memo_add_api = main_magnet_url+ 'cashmemo';
  static final cash_memo_listing_api = main_magnet_url+ 'cashmemo?recordsPerPage=10&pageNumber=1&sortBy=invoice_date&sortOrder=ASC';

  static final proforma_invoice_add_api = main_magnet_url+ 'proforma-invoice';
  static final proforma_invoice_listing_api = main_magnet_url+ 'proforma-invoice?recordsPerPage=10&pageNumber=1&sortBy=invoice_date&sortOrder=ASC';

  static final estimate_add_api = main_magnet_url+ 'estimate-invoice';
  static final estimate_listing_api = main_magnet_url+ 'estimate-invoice?recordsPerPage=10&pageNumber=1&sortBy=invoice_date&sortOrder=ASC';

  static final delivery_challan_add_api = main_magnet_url+ 'delivery-challan';
  static final delivery_challan_listing_api = main_magnet_url+ 'delivery-challan?recordsPerPage=10&pageNumber=1&sortBy=challan_date&sortOrder=ASC';

  static final expanse_add_api = main_magnet_url+ 'expense';
  static final expanse_listing_api = main_magnet_url+ 'expense?recordsPerPage=10&pageNumber=1&sortBy=sr_number&sortOrder=ASC';

  static final credit_note_add_api = main_magnet_url+ 'credit-note';
  static final credit_note_listing_api = main_magnet_url+ 'credit-note?recordsPerPage=10&pageNumber=1&sortBy=credit_note_date&sortOrder=ASC';

  static final debit_note_add_api = main_magnet_url+ 'debit-note';
  static final debit_note_listing_api = main_magnet_url+ 'debit-note?recordsPerPage=10&pageNumber=1&sortBy=debit_note_date&sortOrder=ASC';

  static final sells_order_add_api = main_magnet_url+ 'sales-order';
  static final sells_order_listing_api = main_magnet_url+ 'sales-order?recordsPerPage=10&pageNumber=1&sortBy=sales_order_number&sortOrder=ASC';

  static final purchase_order_add_api = main_magnet_url+ 'purchase-order';
  static final purchase_order_listing_api = main_magnet_url+ 'purchase-order?recordsPerPage=10&pageNumber=1&sortBy=purchase_order_number&sortOrder=ASC';

  static final receipt_payment_add_api = main_magnet_url+ 'receipt';
  static final receipt_payment_list_api = main_magnet_url+ 'receipt?recordsPerPage=10&pageNumber=1&sortBy=date&sortOrder=ASC';

  static final payment_add_api = main_magnet_url+ 'payment';
  static final payment_list_api = main_magnet_url+ 'payment?recordsPerPage=10&pageNumber=1&sortBy=date&sortOrder=ASC';

  static final contra_add_api = main_magnet_url+ 'contra';
  static final contra_list_api = main_magnet_url+ 'contra?recordsPerPage=10&pageNumber=1&sortBy=date&sortOrder=ASC';

  static final journal_add_api = main_magnet_url+ 'journal';
  static final journal_list_api = main_magnet_url+ 'journal?recordsPerPage=10&pageNumber=1&sortBy=date&sortOrder=ASC';

  static final inquiry_add_api = main_magnet_url+ 'inquiry';
  static final inquiry_list_api = main_magnet_url+ 'inquiry?recordsPerPage=10&pageNumber=1&sortBy=name&sortOrder=ASC';

  static final state_list_api = main_magnet_url+ 'state';

  static final customer_group_api = main_magnet_url+ 'group?groupType=ledger';
  static final account_head_api = main_magnet_url+ 'others/account-heads';
  static final trans_type_api = main_magnet_url+ 'transaction-type/modal';

  static String token = "token";
  static String user_id = "user";
  static String account_id = "account";
  static String user_role = "userrole";

}


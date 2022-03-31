class taxinvoiceList {
  bool? success;
  List<Data_tax_invoice>? data;

  taxinvoiceList({this.success, this.data});

  taxinvoiceList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_tax_invoice>[];
      json['data'].forEach((v) {
        data!.add(new Data_tax_invoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data_tax_invoice {
  int? id;
  String? invoiceNumber;
  int? customerId;
  String? invoiceDate;
  String? gstNumber;
  String? placeOfSupply;
  num? totalAmt;
  num? balanceDue;
  List<ProductItems>? productItems;
  Customer? customer;

  Data_tax_invoice(
      {this.id,
        this.invoiceNumber,
        this.customerId,
        this.invoiceDate,
        this.gstNumber,
        this.placeOfSupply,
        this.totalAmt,
        this.balanceDue,
        this.productItems,
        this.customer});

  Data_tax_invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoice_number'];
    customerId = json['customer_id'];
    invoiceDate = json['invoice_date'];
    gstNumber = json['gst_number'];
    placeOfSupply = json['place_of_supply'];
    totalAmt = json['total_amt'];
    balanceDue = json['balance_due'];
    if (json['product_items'] != null) {
      productItems = <ProductItems>[];
      json['product_items'].forEach((v) {
        productItems!.add(new ProductItems.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_number'] = this.invoiceNumber;
    data['customer_id'] = this.customerId;
    data['invoice_date'] = this.invoiceDate;
    data['gst_number'] = this.gstNumber;
    data['place_of_supply'] = this.placeOfSupply;
    data['total_amt'] = this.totalAmt;
    data['balance_due'] = this.balanceDue;
    if (this.productItems != null) {
      data['product_items'] =
          this.productItems!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class ProductItems {
  int? id;
  int? productQty;
  String? hsnCode;
  String? productUnit;
  int? productRate;
  String? productDiscount;
  num? productTaxableVal;
  String? productTax;
  String? invoiceDate;
  String? invoiceNumber;
  int? companyProfileId;
  int? taxInvoiceId;
  Null? billOfSupplyId;
  int? purchaseId;
  Null? cashMemoId;
  Null? estimateInvoiceId;
  Null? proformaInvoiceId;
  Null? deliveryChallanId;
  Null? creditNoteId;
  Null? debitNoteId;
  Null? salesOrderId;
  int? purchaseOrderId;
  int? customerId;
  int? vendorId;
  int? otherId;
  int? productId;
  String? entityType;

  ProductItems(
      {this.id,
        this.productQty,
        this.hsnCode,
        this.productUnit,
        this.productRate,
        this.productDiscount,
        this.productTaxableVal,
        this.productTax,
        this.invoiceDate,
        this.invoiceNumber,
        this.companyProfileId,
        this.taxInvoiceId,
        this.billOfSupplyId,
        this.purchaseId,
        this.cashMemoId,
        this.estimateInvoiceId,
        this.proformaInvoiceId,
        this.deliveryChallanId,
        this.creditNoteId,
        this.debitNoteId,
        this.salesOrderId,
        this.purchaseOrderId,
        this.customerId,
        this.vendorId,
        this.otherId,
        this.productId,
        this.entityType});

  ProductItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productQty = json['product_qty'];
    hsnCode = json['hsn_code'];
    productUnit = json['product_unit'];
    productRate = json['product_rate'];
    productDiscount = json['product_discount'];
    productTaxableVal = json['product_taxable_val'];
    productTax = json['product_tax'];
    invoiceDate = json['invoice_date'];
    invoiceNumber = json['invoice_number'];
    companyProfileId = json['company_profile_id'];
    taxInvoiceId = json['tax_invoice_id'];
    billOfSupplyId = json['bill_of_supply_id'];
    purchaseId = json['purchase_id'];
    cashMemoId = json['cash_memo_id'];
    estimateInvoiceId = json['estimate_invoice_id'];
    proformaInvoiceId = json['proforma_invoice_id'];
    deliveryChallanId = json['delivery_challan_id'];
    creditNoteId = json['credit_note_id'];
    debitNoteId = json['debit_note_id'];
    salesOrderId = json['sales_order_id'];
    purchaseOrderId = json['purchase_order_id'];
    customerId = json['customer_id'];
    vendorId = json['vendor_id'];
    otherId = json['other_id'];
    productId = json['product_id'];
    entityType = json['entity_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_qty'] = this.productQty;
    data['hsn_code'] = this.hsnCode;
    data['product_unit'] = this.productUnit;
    data['product_rate'] = this.productRate;
    data['product_discount'] = this.productDiscount;
    data['product_taxable_val'] = this.productTaxableVal;
    data['product_tax'] = this.productTax;
    data['invoice_date'] = this.invoiceDate;
    data['invoice_number'] = this.invoiceNumber;
    data['company_profile_id'] = this.companyProfileId;
    data['tax_invoice_id'] = this.taxInvoiceId;
    data['bill_of_supply_id'] = this.billOfSupplyId;
    data['purchase_id'] = this.purchaseId;
    data['cash_memo_id'] = this.cashMemoId;
    data['estimate_invoice_id'] = this.estimateInvoiceId;
    data['proforma_invoice_id'] = this.proformaInvoiceId;
    data['delivery_challan_id'] = this.deliveryChallanId;
    data['credit_note_id'] = this.creditNoteId;
    data['debit_note_id'] = this.debitNoteId;
    data['sales_order_id'] = this.salesOrderId;
    data['purchase_order_id'] = this.purchaseOrderId;
    data['customer_id'] = this.customerId;
    data['vendor_id'] = this.vendorId;
    data['other_id'] = this.otherId;
    data['product_id'] = this.productId;
    data['entity_type'] = this.entityType;
    return data;
  }
}

class Customer {
  String? ledgerType;
  int? id;
  String? profilePhoto;
  String? accountName;
  String? companyName;
  String? billingName;
  int? accountHeadId;
  int? groupId;
  int? subGroupId;
  String? asOfDate;
  int? openingBalance;
  String? openingType;
  String? gstType;
  String? panNumber;
  String? gstIn;
  String? ifscCode;
  String? bankName;
  String? accountNo;
  String? accountHolderName;
  bool? status;
  int? companyProfileId;
  String? createdAt;
  String? updateAt;
  int? createdBy;
  Null? updatedBy;
  Null? userId;

  Customer(
      {this.ledgerType,
        this.id,
        this.profilePhoto,
        this.accountName,
        this.companyName,
        this.billingName,
        this.accountHeadId,
        this.groupId,
        this.subGroupId,
        this.asOfDate,
        this.openingBalance,
        this.openingType,
        this.gstType,
        this.panNumber,
        this.gstIn,
        this.ifscCode,
        this.bankName,
        this.accountNo,
        this.accountHolderName,
        this.status,
        this.companyProfileId,
        this.createdAt,
        this.updateAt,
        this.createdBy,
        this.updatedBy,
        this.userId});

  Customer.fromJson(Map<String, dynamic> json) {
    ledgerType = json['ledger_type'];
    id = json['id'];
    profilePhoto = json['profile_photo'];
    accountName = json['account_name'];
    companyName = json['company_name'];
    billingName = json['billing_name'];
    accountHeadId = json['account_head_id'];
    groupId = json['group_id'];
    subGroupId = json['sub_group_id'];
    asOfDate = json['as_of_date'];
    openingBalance = json['opening_balance'];
    openingType = json['opening_type'];
    gstType = json['gst_type'];
    panNumber = json['pan_number'];
    gstIn = json['gst_in'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    accountNo = json['account_no'];
    accountHolderName = json['account_holder_name'];
    status = json['status'];
    companyProfileId = json['company_profile_id'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ledger_type'] = this.ledgerType;
    data['id'] = this.id;
    data['profile_photo'] = this.profilePhoto;
    data['account_name'] = this.accountName;
    data['company_name'] = this.companyName;
    data['billing_name'] = this.billingName;
    data['account_head_id'] = this.accountHeadId;
    data['group_id'] = this.groupId;
    data['sub_group_id'] = this.subGroupId;
    data['as_of_date'] = this.asOfDate;
    data['opening_balance'] = this.openingBalance;
    data['opening_type'] = this.openingType;
    data['gst_type'] = this.gstType;
    data['pan_number'] = this.panNumber;
    data['gst_in'] = this.gstIn;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['account_no'] = this.accountNo;
    data['account_holder_name'] = this.accountHolderName;
    data['status'] = this.status;
    data['company_profile_id'] = this.companyProfileId;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['user_id'] = this.userId;
    return data;
  }
}
class purchaseList {
  bool? success;
  List<Data_purchase>? data;

  purchaseList({this.success, this.data});

  purchaseList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_purchase>[];
      json['data'].forEach((v) {
        data!.add(new Data_purchase.fromJson(v));
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

class Data_purchase {
  int? id;
  String? invoiceNumber;
  int? vendorId;
  String? invoiceDate;
  num? totalAmt;
  num? balanceDue;
  Vendor? vendor;
  List<ProductItems>? productItems;

  Data_purchase(
      {this.id,
        this.invoiceNumber,
        this.vendorId,
        this.invoiceDate,
        this.totalAmt,
        this.balanceDue,
        this.vendor,
        this.productItems});

  Data_purchase.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoice_number'];
    vendorId = json['vendor_id'];
    invoiceDate = json['invoice_date'];
    totalAmt = json['total_amt'];
    balanceDue = json['balance_due'];
    vendor =
    json['vendor'] != null ? new Vendor.fromJson(json['vendor']) : null;
    if (json['product_items'] != null) {
      productItems = <ProductItems>[];
      json['product_items'].forEach((v) {
        productItems!.add(new ProductItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_number'] = this.invoiceNumber;
    data['vendor_id'] = this.vendorId;
    data['invoice_date'] = this.invoiceDate;
    data['total_amt'] = this.totalAmt;
    data['balance_due'] = this.balanceDue;
    if (this.vendor != null) {
      data['vendor'] = this.vendor!.toJson();
    }
    if (this.productItems != null) {
      data['product_items'] =
          this.productItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vendor {
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

  Vendor(
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
        this.updatedBy});

  Vendor.fromJson(Map<String, dynamic> json) {
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
  int? companyProfileId;
  int? taxInvoiceId;
  Null? billOfSupplyId;
  int? purchaseId;
 int? cashMemoId;
 int? estimateInvoiceId;
 int? proformaInvoiceId;
 int? deliveryChallanId;
 int? creditNoteId;
 int? debitNoteId;
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
    data['customer_id'] = this.customerId;
    data['vendor_id'] = this.vendorId;
    data['other_id'] = this.otherId;
    data['product_id'] = this.productId;
    data['entity_type'] = this.entityType;
    return data;
  }
}
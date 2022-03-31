class estimate_invoiceList {
  bool? success;
  List<Data_estimate>? data;

  estimate_invoiceList({this.success, this.data});

  estimate_invoiceList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_estimate>[];
      json['data'].forEach((v) {
        data!.add(new Data_estimate.fromJson(v));
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

class Data_estimate {
  int? id;
  String? invoiceNumber;
  String? invoiceDate;
  num? totalAmt;
  List<ProductItems>? productItems;

  Data_estimate(
      {this.id,
        this.invoiceNumber,
        this.invoiceDate,
        this.totalAmt,
        this.productItems});

  Data_estimate.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoice_number'];
    invoiceDate = json['invoice_date'];
    totalAmt = json['total_amt'];
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
    data['invoice_date'] = this.invoiceDate;
    data['total_amt'] = this.totalAmt;
    if (this.productItems != null) {
      data['product_items'] =
          this.productItems!.map((v) => v.toJson()).toList();
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
  int? companyProfileId;
  Null? taxInvoiceId;
  Null? billOfSupplyId;
  Null? purchaseId;
  Null? cashMemoId;
  int? estimateInvoiceId;
  Null? proformaInvoiceId;
  Null? deliveryChallanId;
  Null? creditNoteId;
  Null? debitNoteId;
  int? customerId;
  Null? vendorId;
  Null? otherId;
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
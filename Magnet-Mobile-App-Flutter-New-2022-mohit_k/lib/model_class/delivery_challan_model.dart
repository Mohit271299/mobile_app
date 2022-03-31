class delivery_challanList {
  bool? success;
  List<Data_delivery_challan>? data;

  delivery_challanList({this.success, this.data});

  delivery_challanList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_delivery_challan>[];
      json['data'].forEach((v) {
        data!.add(new Data_delivery_challan.fromJson(v));
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

class Data_delivery_challan {
  int? id;
  String? challanNumber;
  String? challanDate;
  String? dateOfRemoval;
  num? totalAmt;
  List<ProductItems>? productItems;

  Data_delivery_challan(
      {this.id,
        this.challanNumber,
        this.challanDate,
        this.dateOfRemoval,
        this.totalAmt,
        this.productItems});

  Data_delivery_challan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    challanNumber = json['challan_number'];
    challanDate = json['challan_date'];
    dateOfRemoval = json['date_of_removal'];
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
    data['challan_number'] = this.challanNumber;
    data['challan_date'] = this.challanDate;
    data['date_of_removal'] = this.dateOfRemoval;
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
  Null? estimateInvoiceId;
  Null? proformaInvoiceId;
  int? deliveryChallanId;
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
class PurchaseModel {
  PurchaseModel({
      bool? success, 
      List<Data_purchase_order>? data,}){
    _success = success;
    _data = data;
}

  PurchaseModel.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data_purchase_order.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Data_purchase_order>? _data;

  bool? get success => _success;
  List<Data_purchase_order>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data_purchase_order {
  Data_purchase_order({
      int? id, 
      String? purchaseOrderNumber, 
      String? purchaseOrderDate, 
      int? vendorId, 
      int? totalAmt, 
      Vendor? vendor, 
      List<Product_items>? productItems,}){
    _id = id;
    _purchaseOrderNumber = purchaseOrderNumber;
    _purchaseOrderDate = purchaseOrderDate;
    _vendorId = vendorId;
    _totalAmt = totalAmt;
    _vendor = vendor;
    _productItems = productItems;
}

  Data_purchase_order.fromJson(dynamic json) {
    _id = json['id'];
    _purchaseOrderNumber = json['purchase_order_number'];
    _purchaseOrderDate = json['purchase_order_date'];
    _vendorId = json['vendor_id'];
    _totalAmt = json['total_amt'];
    _vendor = json['vendor'] != null ? Vendor.fromJson(json['vendor']) : null;
    if (json['product_items'] != null) {
      _productItems = [];
      json['product_items'].forEach((v) {
        _productItems?.add(Product_items.fromJson(v));
      });
    }
  }
  int? _id;
  String? _purchaseOrderNumber;
  String? _purchaseOrderDate;
  int? _vendorId;
  num? _totalAmt;
  Vendor? _vendor;
  List<Product_items>? _productItems;

  int? get id => _id;
  String? get purchaseOrderNumber => _purchaseOrderNumber;
  String? get purchaseOrderDate => _purchaseOrderDate;
  int? get vendorId => _vendorId;
  num? get totalAmt => _totalAmt;
  Vendor? get vendor => _vendor;
  List<Product_items>? get productItems => _productItems;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['purchase_order_number'] = _purchaseOrderNumber;
    map['purchase_order_date'] = _purchaseOrderDate;
    map['vendor_id'] = _vendorId;
    map['total_amt'] = _totalAmt;
    if (_vendor != null) {
      map['vendor'] = _vendor?.toJson();
    }
    if (_productItems != null) {
      map['product_items'] = _productItems?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Product_items {
  Product_items({
      int? id, 
      int? productQty, 
      String? hsnCode, 
      String? productUnit, 
      int? productRate, 
      String? productDiscount, 
      int? productTaxableVal, 
      String? productTax, 
      int? companyProfileId, 
      dynamic taxInvoiceId, 
      dynamic billOfSupplyId, 
      dynamic purchaseId, 
      dynamic cashMemoId, 
      dynamic estimateInvoiceId, 
      dynamic proformaInvoiceId, 
      dynamic deliveryChallanId, 
      dynamic creditNoteId, 
      dynamic debitNoteId, 
      dynamic salesOrderId, 
      int? purchaseOrderId, 
      dynamic customerId, 
      int? vendorId, 
      dynamic otherId, 
      int? productId, 
      String? entityType,}){
    _id = id;
    _productQty = productQty;
    _hsnCode = hsnCode;
    _productUnit = productUnit;
    _productRate = productRate;
    _productDiscount = productDiscount;
    _productTaxableVal = productTaxableVal;
    _productTax = productTax;
    _companyProfileId = companyProfileId;
    _taxInvoiceId = taxInvoiceId;
    _billOfSupplyId = billOfSupplyId;
    _purchaseId = purchaseId;
    _cashMemoId = cashMemoId;
    _estimateInvoiceId = estimateInvoiceId;
    _proformaInvoiceId = proformaInvoiceId;
    _deliveryChallanId = deliveryChallanId;
    _creditNoteId = creditNoteId;
    _debitNoteId = debitNoteId;
    _salesOrderId = salesOrderId;
    _purchaseOrderId = purchaseOrderId;
    _customerId = customerId;
    _vendorId = vendorId;
    _otherId = otherId;
    _productId = productId;
    _entityType = entityType;
}

  Product_items.fromJson(dynamic json) {
    _id = json['id'];
    _productQty = json['product_qty'];
    _hsnCode = json['hsn_code'];
    _productUnit = json['product_unit'];
    _productRate = json['product_rate'];
    _productDiscount = json['product_discount'];
    _productTaxableVal = json['product_taxable_val'];
    _productTax = json['product_tax'];
    _companyProfileId = json['company_profile_id'];
    _taxInvoiceId = json['tax_invoice_id'];
    _billOfSupplyId = json['bill_of_supply_id'];
    _purchaseId = json['purchase_id'];
    _cashMemoId = json['cash_memo_id'];
    _estimateInvoiceId = json['estimate_invoice_id'];
    _proformaInvoiceId = json['proforma_invoice_id'];
    _deliveryChallanId = json['delivery_challan_id'];
    _creditNoteId = json['credit_note_id'];
    _debitNoteId = json['debit_note_id'];
    _salesOrderId = json['sales_order_id'];
    _purchaseOrderId = json['purchase_order_id'];
    _customerId = json['customer_id'];
    _vendorId = json['vendor_id'];
    _otherId = json['other_id'];
    _productId = json['product_id'];
    _entityType = json['entity_type'];
  }
  int? _id;
  int? _productQty;
  String? _hsnCode;
  String? _productUnit;
  int? _productRate;
  String? _productDiscount;
  num? _productTaxableVal;
  String? _productTax;
  int? _companyProfileId;
  dynamic _taxInvoiceId;
  dynamic _billOfSupplyId;
  dynamic _purchaseId;
  dynamic _cashMemoId;
  dynamic _estimateInvoiceId;
  dynamic _proformaInvoiceId;
  dynamic _deliveryChallanId;
  dynamic _creditNoteId;
  dynamic _debitNoteId;
  dynamic _salesOrderId;
  int? _purchaseOrderId;
  dynamic _customerId;
  int? _vendorId;
  dynamic _otherId;
  int? _productId;
  String? _entityType;

  int? get id => _id;
  int? get productQty => _productQty;
  String? get hsnCode => _hsnCode;
  String? get productUnit => _productUnit;
  int? get productRate => _productRate;
  String? get productDiscount => _productDiscount;
  num? get productTaxableVal => _productTaxableVal;
  String? get productTax => _productTax;
  int? get companyProfileId => _companyProfileId;
  dynamic get taxInvoiceId => _taxInvoiceId;
  dynamic get billOfSupplyId => _billOfSupplyId;
  dynamic get purchaseId => _purchaseId;
  dynamic get cashMemoId => _cashMemoId;
  dynamic get estimateInvoiceId => _estimateInvoiceId;
  dynamic get proformaInvoiceId => _proformaInvoiceId;
  dynamic get deliveryChallanId => _deliveryChallanId;
  dynamic get creditNoteId => _creditNoteId;
  dynamic get debitNoteId => _debitNoteId;
  dynamic get salesOrderId => _salesOrderId;
  int? get purchaseOrderId => _purchaseOrderId;
  dynamic get customerId => _customerId;
  int? get vendorId => _vendorId;
  dynamic get otherId => _otherId;
  int? get productId => _productId;
  String? get entityType => _entityType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['product_qty'] = _productQty;
    map['hsn_code'] = _hsnCode;
    map['product_unit'] = _productUnit;
    map['product_rate'] = _productRate;
    map['product_discount'] = _productDiscount;
    map['product_taxable_val'] = _productTaxableVal;
    map['product_tax'] = _productTax;
    map['company_profile_id'] = _companyProfileId;
    map['tax_invoice_id'] = _taxInvoiceId;
    map['bill_of_supply_id'] = _billOfSupplyId;
    map['purchase_id'] = _purchaseId;
    map['cash_memo_id'] = _cashMemoId;
    map['estimate_invoice_id'] = _estimateInvoiceId;
    map['proforma_invoice_id'] = _proformaInvoiceId;
    map['delivery_challan_id'] = _deliveryChallanId;
    map['credit_note_id'] = _creditNoteId;
    map['debit_note_id'] = _debitNoteId;
    map['sales_order_id'] = _salesOrderId;
    map['purchase_order_id'] = _purchaseOrderId;
    map['customer_id'] = _customerId;
    map['vendor_id'] = _vendorId;
    map['other_id'] = _otherId;
    map['product_id'] = _productId;
    map['entity_type'] = _entityType;
    return map;
  }

}

class Vendor {
  Vendor({
      String? ledgerType, 
      int? id, 
      String? profilePhoto, 
      String? accountName, 
      String? companyName, 
      String? billingName, 
      int? accountHeadId, 
      int? groupId, 
      int? subGroupId, 
      String? asOfDate, 
      int? openingBalance, 
      String? openingType, 
      String? gstType, 
      String? panNumber, 
      String? gstIn, 
      String? ifscCode, 
      String? bankName, 
      String? accountNo, 
      String? accountHolderName, 
      bool? status, 
      int? companyProfileId, 
      String? createdAt, 
      String? updateAt, 
      int? createdBy, 
      dynamic updatedBy,}){
    _ledgerType = ledgerType;
    _id = id;
    _profilePhoto = profilePhoto;
    _accountName = accountName;
    _companyName = companyName;
    _billingName = billingName;
    _accountHeadId = accountHeadId;
    _groupId = groupId;
    _subGroupId = subGroupId;
    _asOfDate = asOfDate;
    _openingBalance = openingBalance;
    _openingType = openingType;
    _gstType = gstType;
    _panNumber = panNumber;
    _gstIn = gstIn;
    _ifscCode = ifscCode;
    _bankName = bankName;
    _accountNo = accountNo;
    _accountHolderName = accountHolderName;
    _status = status;
    _companyProfileId = companyProfileId;
    _createdAt = createdAt;
    _updateAt = updateAt;
    _createdBy = createdBy;
    _updatedBy = updatedBy;
}

  Vendor.fromJson(dynamic json) {
    _ledgerType = json['ledger_type'];
    _id = json['id'];
    _profilePhoto = json['profile_photo'];
    _accountName = json['account_name'];
    _companyName = json['company_name'];
    _billingName = json['billing_name'];
    _accountHeadId = json['account_head_id'];
    _groupId = json['group_id'];
    _subGroupId = json['sub_group_id'];
    _asOfDate = json['as_of_date'];
    _openingBalance = json['opening_balance'];
    _openingType = json['opening_type'];
    _gstType = json['gst_type'];
    _panNumber = json['pan_number'];
    _gstIn = json['gst_in'];
    _ifscCode = json['ifsc_code'];
    _bankName = json['bank_name'];
    _accountNo = json['account_no'];
    _accountHolderName = json['account_holder_name'];
    _status = json['status'];
    _companyProfileId = json['company_profile_id'];
    _createdAt = json['created_at'];
    _updateAt = json['update_at'];
    _createdBy = json['created_by'];
    _updatedBy = json['updated_by'];
  }
  String? _ledgerType;
  int? _id;
  String? _profilePhoto;
  String? _accountName;
  String? _companyName;
  String? _billingName;
  int? _accountHeadId;
  int? _groupId;
  int? _subGroupId;
  String? _asOfDate;
  int? _openingBalance;
  String? _openingType;
  String? _gstType;
  String? _panNumber;
  String? _gstIn;
  String? _ifscCode;
  String? _bankName;
  String? _accountNo;
  String? _accountHolderName;
  bool? _status;
  int? _companyProfileId;
  String? _createdAt;
  String? _updateAt;
  int? _createdBy;
  dynamic _updatedBy;

  String? get ledgerType => _ledgerType;
  int? get id => _id;
  String? get profilePhoto => _profilePhoto;
  String? get accountName => _accountName;
  String? get companyName => _companyName;
  String? get billingName => _billingName;
  int? get accountHeadId => _accountHeadId;
  int? get groupId => _groupId;
  int? get subGroupId => _subGroupId;
  String? get asOfDate => _asOfDate;
  int? get openingBalance => _openingBalance;
  String? get openingType => _openingType;
  String? get gstType => _gstType;
  String? get panNumber => _panNumber;
  String? get gstIn => _gstIn;
  String? get ifscCode => _ifscCode;
  String? get bankName => _bankName;
  String? get accountNo => _accountNo;
  String? get accountHolderName => _accountHolderName;
  bool? get status => _status;
  int? get companyProfileId => _companyProfileId;
  String? get createdAt => _createdAt;
  String? get updateAt => _updateAt;
  int? get createdBy => _createdBy;
  dynamic get updatedBy => _updatedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ledger_type'] = _ledgerType;
    map['id'] = _id;
    map['profile_photo'] = _profilePhoto;
    map['account_name'] = _accountName;
    map['company_name'] = _companyName;
    map['billing_name'] = _billingName;
    map['account_head_id'] = _accountHeadId;
    map['group_id'] = _groupId;
    map['sub_group_id'] = _subGroupId;
    map['as_of_date'] = _asOfDate;
    map['opening_balance'] = _openingBalance;
    map['opening_type'] = _openingType;
    map['gst_type'] = _gstType;
    map['pan_number'] = _panNumber;
    map['gst_in'] = _gstIn;
    map['ifsc_code'] = _ifscCode;
    map['bank_name'] = _bankName;
    map['account_no'] = _accountNo;
    map['account_holder_name'] = _accountHolderName;
    map['status'] = _status;
    map['company_profile_id'] = _companyProfileId;
    map['created_at'] = _createdAt;
    map['update_at'] = _updateAt;
    map['created_by'] = _createdBy;
    map['updated_by'] = _updatedBy;
    return map;
  }

}
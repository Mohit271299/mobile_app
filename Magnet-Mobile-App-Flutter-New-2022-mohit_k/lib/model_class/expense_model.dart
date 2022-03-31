class expenseList {
  bool? success;
  List<Data_expense>? data;

  expenseList({this.success, this.data});

  expenseList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_expense>[];
      json['data'].forEach((v) {
        data!.add(new Data_expense.fromJson(v));
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

class Data_expense {
  int? id;
  String? srNumber;
  String? invoiceDate;
  int? entityId;
  String? entityType;
  num? totalAmt;
  num? balanceDue;
  List<ExpenseItems>? expenseItems;
  String? billingName;
  String? accountName;
  String? companyName;

  Data_expense(
      {this.id,
        this.srNumber,
        this.invoiceDate,
        this.entityId,
        this.entityType,
        this.totalAmt,
        this.balanceDue,
        this.expenseItems,
        this.billingName,
        this.accountName,
        this.companyName});

  Data_expense.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    srNumber = json['sr_number'];
    invoiceDate = json['invoice_date'];
    entityId = json['entity_id'];
    entityType = json['entity_type'];
    totalAmt = json['total_amt'];
    balanceDue = json['balance_due'];
    if (json['expense_items'] != null) {
      expenseItems = <ExpenseItems>[];
      json['expense_items'].forEach((v) {
        expenseItems!.add(new ExpenseItems.fromJson(v));
      });
    }
    billingName = json['billing_name'];
    accountName = json['account_name'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sr_number'] = this.srNumber;
    data['invoice_date'] = this.invoiceDate;
    data['entity_id'] = this.entityId;
    data['entity_type'] = this.entityType;
    data['total_amt'] = this.totalAmt;
    data['balance_due'] = this.balanceDue;
    if (this.expenseItems != null) {
      data['expense_items'] =
          this.expenseItems!.map((v) => v.toJson()).toList();
    }
    data['billing_name'] = this.billingName;
    data['account_name'] = this.accountName;
    data['company_name'] = this.companyName;
    return data;
  }
}

class ExpenseItems {
  int? id;
  int? productQty;
  String? hsnCode;
  int? voucherId;
  String? productUnit;
  int? productRate;
  String? productDiscount;
  int? productTaxableVal;
  String? srNumber;
  String? invoiceDate;
  String? productTax;
  int? companyProfileId;
  int? otherLedgerId;
  int? expenseId;
  String? paymentType;
  String? createdAt;
  int? createdBy;

  ExpenseItems(
      {this.id,
        this.productQty,
        this.hsnCode,
        this.voucherId,
        this.productUnit,
        this.productRate,
        this.productDiscount,
        this.productTaxableVal,
        this.srNumber,
        this.invoiceDate,
        this.productTax,
        this.companyProfileId,
        this.otherLedgerId,
        this.expenseId,
        this.paymentType,
        this.createdAt,
        this.createdBy});

  ExpenseItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productQty = json['product_qty'];
    hsnCode = json['hsn_code'];
    voucherId = json['voucher_id'];
    productUnit = json['product_unit'];
    productRate = json['product_rate'];
    productDiscount = json['product_discount'];
    productTaxableVal = json['product_taxable_val'];
    srNumber = json['sr_number'];
    invoiceDate = json['invoice_date'];
    productTax = json['product_tax'];
    companyProfileId = json['company_profile_id'];
    otherLedgerId = json['other_ledger_id'];
    expenseId = json['expense_id'];
    paymentType = json['payment_type'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_qty'] = this.productQty;
    data['hsn_code'] = this.hsnCode;
    data['voucher_id'] = this.voucherId;
    data['product_unit'] = this.productUnit;
    data['product_rate'] = this.productRate;
    data['product_discount'] = this.productDiscount;
    data['product_taxable_val'] = this.productTaxableVal;
    data['sr_number'] = this.srNumber;
    data['invoice_date'] = this.invoiceDate;
    data['product_tax'] = this.productTax;
    data['company_profile_id'] = this.companyProfileId;
    data['other_ledger_id'] = this.otherLedgerId;
    data['expense_id'] = this.expenseId;
    data['payment_type'] = this.paymentType;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    return data;
  }
}
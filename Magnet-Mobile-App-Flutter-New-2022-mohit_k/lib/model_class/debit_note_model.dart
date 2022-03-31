class debitNoteList {
  bool? success;
  List<Data_debit_note>? data;

  debitNoteList({this.success, this.data});

  debitNoteList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_debit_note>[];
      json['data'].forEach((v) {
        data!.add(new Data_debit_note.fromJson(v));
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

class Data_debit_note {
  int? id;
  String? debitNoteNumber;
  String? debitNoteDate;
  int? entityId;
  String? entityType;
  int? voucherId;
  num? totalAmt;
  Invoice? invoice;
  String? billingName;
  String? accountName;
  String? companyName;

  Data_debit_note(
      {this.id,
        this.debitNoteNumber,
        this.debitNoteDate,
        this.entityId,
        this.entityType,
        this.voucherId,
        this.totalAmt,
        this.invoice,
        this.billingName,
        this.accountName,
        this.companyName});

  Data_debit_note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    debitNoteNumber = json['debit_note_number'];
    debitNoteDate = json['debit_note_date'];
    entityId = json['entity_id'];
    entityType = json['entity_type'];
    voucherId = json['voucher_id'];
    totalAmt = json['total_amt'];
    invoice =
    json['invoice'] != null ? new Invoice.fromJson(json['invoice']) : null;
    billingName = json['billing_name'];
    accountName = json['account_name'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['debit_note_number'] = this.debitNoteNumber;
    data['debit_note_date'] = this.debitNoteDate;
    data['entity_id'] = this.entityId;
    data['entity_type'] = this.entityType;
    data['voucher_id'] = this.voucherId;
    data['total_amt'] = this.totalAmt;
    if (this.invoice != null) {
      data['invoice'] = this.invoice!.toJson();
    }
    data['billing_name'] = this.billingName;
    data['account_name'] = this.accountName;
    data['company_name'] = this.companyName;
    return data;
  }
}

class Invoice {
  int? id;
  String? invoiceNumber;
  int? vendorId;
  String? invoiceDate;
  String? address;
  String? gstNumber;
  String? placeOfSupply;
  String? terms;
  String? dueDate;
  String? poNumber;
  String? poDate;
  bool? sendInvoiceToSms;
  String? taxType;
  String? paymentType;
  int? voucherId;
  num? taxableValue;
  int? totalDiscount;
  int? otherExpenses;
  int? totalCgst;
  int? totalSgst;
  int? totalIgst;
  num? totalTax;
  num? totalAmt;
  String? totalAmtWord;
  num? balanceDue;
  String? termsConditionInvoice;
  String? note;
  String? ifscCode;
  String? bankName;
  String? accountNumber;
  String? accountHolderName;
  bool? invoiceStatus;
  int? companyProfileId;
  String? createdAt;
  String? updateAt;
  int? createdBy;
  int? updateBy;

  Invoice(
      {this.id,
        this.invoiceNumber,
        this.vendorId,
        this.invoiceDate,
        this.address,
        this.gstNumber,
        this.placeOfSupply,
        this.terms,
        this.dueDate,
        this.poNumber,
        this.poDate,
        this.sendInvoiceToSms,
        this.taxType,
        this.paymentType,
        this.voucherId,
        this.taxableValue,
        this.totalDiscount,
        this.otherExpenses,
        this.totalCgst,
        this.totalSgst,
        this.totalIgst,
        this.totalTax,
        this.totalAmt,
        this.totalAmtWord,
        this.balanceDue,
        this.termsConditionInvoice,
        this.note,
        this.ifscCode,
        this.bankName,
        this.accountNumber,
        this.accountHolderName,
        this.invoiceStatus,
        this.companyProfileId,
        this.createdAt,
        this.updateAt,
        this.createdBy,
        this.updateBy});

  Invoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoice_number'];
    vendorId = json['vendor_id'];
    invoiceDate = json['invoice_date'];
    address = json['address'];
    gstNumber = json['gst_number'];
    placeOfSupply = json['place_of_supply'];
    terms = json['terms'];
    dueDate = json['due_date'];
    poNumber = json['po_number'];
    poDate = json['po_date'];
    sendInvoiceToSms = json['send_invoice_to_sms'];
    taxType = json['tax_type'];
    paymentType = json['payment_type'];
    voucherId = json['voucher_id'];
    taxableValue = json['taxable_value'];
    totalDiscount = json['total_discount'];
    otherExpenses = json['other_expenses'];
    totalCgst = json['total_cgst'];
    totalSgst = json['total_sgst'];
    totalIgst = json['total_igst'];
    totalTax = json['total_tax'];
    totalAmt = json['total_amt'];
    totalAmtWord = json['total_amt_word'];
    balanceDue = json['balance_due'];
    termsConditionInvoice = json['terms_condition_invoice'];
    note = json['note'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    accountHolderName = json['account_holder_name'];
    invoiceStatus = json['invoice_status'];
    companyProfileId = json['company_profile_id'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    createdBy = json['created_by'];
    updateBy = json['update_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_number'] = this.invoiceNumber;
    data['vendor_id'] = this.vendorId;
    data['invoice_date'] = this.invoiceDate;
    data['address'] = this.address;
    data['gst_number'] = this.gstNumber;
    data['place_of_supply'] = this.placeOfSupply;
    data['terms'] = this.terms;
    data['due_date'] = this.dueDate;
    data['po_number'] = this.poNumber;
    data['po_date'] = this.poDate;
    data['send_invoice_to_sms'] = this.sendInvoiceToSms;
    data['tax_type'] = this.taxType;
    data['payment_type'] = this.paymentType;
    data['voucher_id'] = this.voucherId;
    data['taxable_value'] = this.taxableValue;
    data['total_discount'] = this.totalDiscount;
    data['other_expenses'] = this.otherExpenses;
    data['total_cgst'] = this.totalCgst;
    data['total_sgst'] = this.totalSgst;
    data['total_igst'] = this.totalIgst;
    data['total_tax'] = this.totalTax;
    data['total_amt'] = this.totalAmt;
    data['total_amt_word'] = this.totalAmtWord;
    data['balance_due'] = this.balanceDue;
    data['terms_condition_invoice'] = this.termsConditionInvoice;
    data['note'] = this.note;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['account_holder_name'] = this.accountHolderName;
    data['invoice_status'] = this.invoiceStatus;
    data['company_profile_id'] = this.companyProfileId;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    data['created_by'] = this.createdBy;
    data['update_by'] = this.updateBy;
    return data;
  }
}
class cash_bank_list {
  bool? success;
  List<Data_receipt>? data;

  cash_bank_list({this.success, this.data});

  cash_bank_list.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_receipt>[];
      json['data'].forEach((v) {
        data!.add(new Data_receipt.fromJson(v));
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

class Data_receipt {
  int? id;
  String? voucherNumber;
  int? customerId;
  int? transactionTypeId;
  int? paymentAmount;
  String? refNumber;
  String? date;
  int? cashBankId;
  Customer? customer;
  CashBank? cashBank;
  TransactionType? transactionType;

  Data_receipt(
      {this.id,
        this.voucherNumber,
        this.customerId,
        this.transactionTypeId,
        this.paymentAmount,
        this.refNumber,
        this.date,
        this.cashBankId,
        this.customer,
        this.cashBank,
        this.transactionType});

  Data_receipt.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voucherNumber = json['voucher_number'];
    customerId = json['customer_id'];
    transactionTypeId = json['transaction_type_id'];
    paymentAmount = json['payment_amount'];
    refNumber = json['ref_number'];
    date = json['date'];
    cashBankId = json['cash_bank_id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    cashBank = json['cash_bank'] != null
        ? new CashBank.fromJson(json['cash_bank'])
        : null;
    transactionType = json['transaction_type'] != null
        ? new TransactionType.fromJson(json['transaction_type'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['voucher_number'] = this.voucherNumber;
    data['customer_id'] = this.customerId;
    data['transaction_type_id'] = this.transactionTypeId;
    data['payment_amount'] = this.paymentAmount;
    data['ref_number'] = this.refNumber;
    data['date'] = this.date;
    data['cash_bank_id'] = this.cashBankId;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.cashBank != null) {
      data['cash_bank'] = this.cashBank!.toJson();
    }
    if (this.transactionType != null) {
      data['transaction_type'] = this.transactionType!.toJson();
    }
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

class CashBank {
  String? ledgerType;
  int? id;
  String? profilePhoto;
  String? accountName;
  Null? companyName;
  String? billingName;
  int? accountHeadId;
  Null? groupId;
  Null? subGroupId;
  Null? asOfDate;
  int? openingBalance;
  String? openingType;
  String? gstType;
  Null? panNumber;
  String? gstIn;
  Null? ifscCode;
  Null? bankName;
  Null? accountNo;
  Null? accountHolderName;
  bool? status;
  int? companyProfileId;
  String? createdAt;
  String? updateAt;
  int? createdBy;
  int? updatedBy;

  CashBank(
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
        this.updatedBy});

  CashBank.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}

class TransactionType {
  int? id;
  String? transactionType;
  int? superAdminId;
  String? createdAt;
  String? updatedAt;

  TransactionType(
      {this.id,
        this.transactionType,
        this.superAdminId,
        this.createdAt,
        this.updatedAt});

  TransactionType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transactionType = json['transaction_type'];
    superAdminId = json['super_admin_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['transaction_type'] = this.transactionType;
    data['super_admin_id'] = this.superAdminId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
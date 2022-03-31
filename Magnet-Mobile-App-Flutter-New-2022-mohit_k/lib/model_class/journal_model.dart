class journal_list {
  bool? success;
  List<Data_journal>? data;

  journal_list({this.success, this.data});

  journal_list.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_journal>[];
      json['data'].forEach((v) {
        data!.add(new Data_journal.fromJson(v));
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

class Data_journal {
  int? id;
  String? voucherNumber;
  String? date;
  int? totalCreditAmount;
  int? totalDebitAmount;
  String? globalNarration;
  List<JournalItems>? journalItems;

  Data_journal(
      {this.id,
        this.voucherNumber,
        this.date,
        this.totalCreditAmount,
        this.totalDebitAmount,
        this.globalNarration,
        this.journalItems});

  Data_journal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voucherNumber = json['voucher_number'];
    date = json['date'];
    totalCreditAmount = json['total_credit_amount'];
    totalDebitAmount = json['total_debit_amount'];
    globalNarration = json['global_narration'];
    if (json['journal_items'] != null) {
      journalItems = <JournalItems>[];
      json['journal_items'].forEach((v) {
        journalItems!.add(new JournalItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['voucher_number'] = this.voucherNumber;
    data['date'] = this.date;
    data['total_credit_amount'] = this.totalCreditAmount;
    data['total_debit_amount'] = this.totalDebitAmount;
    data['global_narration'] = this.globalNarration;
    if (this.journalItems != null) {
      data['journal_items'] =
          this.journalItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JournalItems {
  int? id;
  int? journalId;
  String? voucherNumber;
  String? date;
  int? entityId;
  String? entityType;
  int? voucherId;
  String? paymentType;
  int? creditAmount;
  int? debitAmount;
  String? narration;
  int? companyProfileId;
  String? createdAt;
  int? createdBy;
  String? billingName;
  String? accountName;
  String? companyName;

  JournalItems(
      {this.id,
        this.journalId,
        this.voucherNumber,
        this.date,
        this.entityId,
        this.entityType,
        this.voucherId,
        this.paymentType,
        this.creditAmount,
        this.debitAmount,
        this.narration,
        this.companyProfileId,
        this.createdAt,
        this.createdBy,
        this.billingName,
        this.accountName,
        this.companyName});

  JournalItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    journalId = json['journal_id'];
    voucherNumber = json['voucher_number'];
    date = json['date'];
    entityId = json['entity_id'];
    entityType = json['entity_type'];
    voucherId = json['voucher_id'];
    paymentType = json['payment_type'];
    creditAmount = json['credit_amount'];
    debitAmount = json['debit_amount'];
    narration = json['narration'];
    companyProfileId = json['company_profile_id'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    billingName = json['billing_name'];
    accountName = json['account_name'];
    companyName = json['company_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['journal_id'] = this.journalId;
    data['voucher_number'] = this.voucherNumber;
    data['date'] = this.date;
    data['entity_id'] = this.entityId;
    data['entity_type'] = this.entityType;
    data['voucher_id'] = this.voucherId;
    data['payment_type'] = this.paymentType;
    data['credit_amount'] = this.creditAmount;
    data['debit_amount'] = this.debitAmount;
    data['narration'] = this.narration;
    data['company_profile_id'] = this.companyProfileId;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['billing_name'] = this.billingName;
    data['account_name'] = this.accountName;
    data['company_name'] = this.companyName;
    return data;
  }
}
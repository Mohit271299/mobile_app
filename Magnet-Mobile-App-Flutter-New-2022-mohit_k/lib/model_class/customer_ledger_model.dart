class customerList {
  bool? success;
  List<Data_customers>? data;

  customerList({this.success, this.data});

  customerList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_customers>[];
      json['data'].forEach((v) {
        data!.add(new Data_customers.fromJson(v));
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

class Data_customers {
  String? ledgerType;
  int? id;
  String? accountName;
  String? companyName;
  String? billingName;
  int? accountHeadId;
  String? gstType;
  String? gstIn;
  AccountHead? accountHead;
  List<Addresse_customer>? addresses;
  int? openingBalance;
  String? openingType;
  num? closingBalance;
  String? closingType;
  int? totalSales;

  Data_customers(
      {this.ledgerType,
        this.id,
        this.accountName,
        this.companyName,
        this.billingName,
        this.accountHeadId,
        this.gstType,
        this.gstIn,
        this.accountHead,
        this.addresses,
        this.openingBalance,
        this.openingType,
        this.closingBalance,
        this.closingType,
        this.totalSales});

  Data_customers.fromJson(Map<String, dynamic> json) {
    ledgerType = json['ledger_type'];
    id = json['id'];
    accountName = json['account_name'];
    companyName = json['company_name'];
    billingName = json['billing_name'];
    accountHeadId = json['account_head_id'];
    gstType = json['gst_type'];
    gstIn = json['gst_in'];
    accountHead = json['account_head'] != null
        ? new AccountHead.fromJson(json['account_head'])
        : null;
    if (json['addresses'] != null) {
      addresses = <Addresse_customer>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresse_customer.fromJson(v));
      });
    }
    openingBalance = json['opening_balance'];
    openingType = json['opening_type'];
    closingBalance = json['closing_balance'];
    closingType = json['closing_type'];
    totalSales = json['total_sales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ledger_type'] = this.ledgerType;
    data['id'] = this.id;
    data['account_name'] = this.accountName;
    data['company_name'] = this.companyName;
    data['billing_name'] = this.billingName;
    data['account_head_id'] = this.accountHeadId;
    data['gst_type'] = this.gstType;
    data['gst_in'] = this.gstIn;
    if (this.accountHead != null) {
      data['account_head'] = this.accountHead!.toJson();
    }
    if (this.addresses != null) {
      data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    }
    data['opening_balance'] = this.openingBalance;
    data['opening_type'] = this.openingType;
    data['closing_balance'] = this.closingBalance;
    data['closing_type'] = this.closingType;
    data['total_sales'] = this.totalSales;
    return data;
  }
}

class AccountHead {
  int? id;
  String? accountHeadName;
  bool? isDefault;
  int? superAdminId;
  int? companyProfileId;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updateBy;

  AccountHead(
      {this.id,
        this.accountHeadName,
        this.isDefault,
        this.superAdminId,
        this.companyProfileId,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updateBy});

  AccountHead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountHeadName = json['account_head_name'];
    isDefault = json['is_default'];
    superAdminId = json['super_admin_id'];
    companyProfileId = json['company_profile_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updateBy = json['update_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_head_name'] = this.accountHeadName;
    data['is_default'] = this.isDefault;
    data['super_admin_id'] = this.superAdminId;
    data['company_profile_id'] = this.companyProfileId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['update_by'] = this.updateBy;
    return data;
  }
}

class Addresse_customer {
  int? id;
  String? address;
  String? pincode;
  String? city;
  String? state;
  String? stateCode;
  String? country;
  String? stdCode;
  String? officeNo;
  String? mobileNo;
  String? email;
  String? addressType;
  int? customerId;
  Null? vendorId;
  Null? otherLedgerId;

  Addresse_customer(
      {this.id,
        this.address,
        this.pincode,
        this.city,
        this.state,
        this.stateCode,
        this.country,
        this.stdCode,
        this.officeNo,
        this.mobileNo,
        this.email,
        this.addressType,
        this.customerId,
        this.vendorId,
        this.otherLedgerId});

  Addresse_customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    pincode = json['pincode'];
    city = json['city'];
    state = json['state'];
    stateCode = json['state_code'];
    country = json['country'];
    stdCode = json['std_code'];
    officeNo = json['office_no'];
    mobileNo = json['mobile_no'];
    email = json['email'];
    addressType = json['address_type'];
    customerId = json['customer_id'];
    vendorId = json['vendor_id'];
    otherLedgerId = json['other_ledger_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['city'] = this.city;
    data['state'] = this.state;
    data['state_code'] = this.stateCode;
    data['country'] = this.country;
    data['std_code'] = this.stdCode;
    data['office_no'] = this.officeNo;
    data['mobile_no'] = this.mobileNo;
    data['email'] = this.email;
    data['address_type'] = this.addressType;
    data['customer_id'] = this.customerId;
    data['vendor_id'] = this.vendorId;
    data['other_ledger_id'] = this.otherLedgerId;
    return data;
  }
}
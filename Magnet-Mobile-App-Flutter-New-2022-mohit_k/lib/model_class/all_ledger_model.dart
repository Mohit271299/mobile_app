class all_ledger_list {
  bool? success;
  Data_all_ledger? data;

  all_ledger_list({this.success, this.data});

  all_ledger_list.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data_all_ledger.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data_all_ledger {
  List<Data_all_Customers>? customers;
  List<Data_all_Vendors>? vendors;
  List<Data_all_Others>? others;

  Data_all_ledger({this.customers, this.vendors, this.others});

  Data_all_ledger.fromJson(Map<String, dynamic> json) {
    if (json['customers'] != null) {
      customers = <Data_all_Customers>[];
      json['customers'].forEach((v) {
        customers!.add(new Data_all_Customers.fromJson(v));
      });
    }
    if (json['vendors'] != null) {
      vendors = <Data_all_Vendors>[];
      json['vendors'].forEach((v) {
        vendors!.add(new Data_all_Vendors.fromJson(v));
      });
    }
    if (json['others'] != null) {
      others = <Data_all_Others>[];
      json['others'].forEach((v) {
        others!.add(new Data_all_Others.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    if (this.vendors != null) {
      data['vendors'] = this.vendors!.map((v) => v.toJson()).toList();
    }
    if (this.others != null) {
      data['others'] = this.others!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data_all_Customers {
  String? ledgerType;
  int? id;
  String? accountName;
  String? companyName;
  String? billingName;
  AccountHead_Customers? accountHead;
  List<Addresses_customer>? addresses;
  int? openingBalance;
  String? openingType;
  num? closingBalance;
  String? closingType;

  Data_all_Customers(
      {this.ledgerType,
        this.id,
        this.accountName,
        this.companyName,
        this.billingName,
        this.accountHead,
        this.addresses,
        this.openingBalance,
        this.openingType,
        this.closingBalance,
        this.closingType});

  Data_all_Customers.fromJson(Map<String, dynamic> json) {
    ledgerType = json['ledger_type'];
    id = json['id'];
    accountName = json['account_name'];
    companyName = json['company_name'];
    billingName = json['billing_name'];
    accountHead = json['account_head'] != null
        ? new AccountHead_Customers.fromJson(json['account_head'])
        : null;
    if (json['addresses'] != null) {
      addresses = <Addresses_customer>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses_customer.fromJson(v));
      });
    }
    openingBalance = json['opening_balance'];
    openingType = json['opening_type'];
    closingBalance = json['closing_balance'];
    closingType = json['closing_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ledger_type'] = this.ledgerType;
    data['id'] = this.id;
    data['account_name'] = this.accountName;
    data['company_name'] = this.companyName;
    data['billing_name'] = this.billingName;
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
    return data;
  }
}
class AccountHead_Customers {
  int? id;
  String? accountHeadName;
  bool? isDefault;
  int? superAdminId;
  int? companyProfileId;
  String? createdAt;
  String? updatedAt;
  num? createdBy;
  num? updateBy;

  AccountHead_Customers(
      {this.id,
        this.accountHeadName,
        this.isDefault,
        this.superAdminId,
        this.companyProfileId,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updateBy});

  AccountHead_Customers.fromJson(Map<String, dynamic> json) {
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
class Addresses_customer {
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

  Addresses_customer(
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

  Addresses_customer.fromJson(Map<String, dynamic> json) {
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

class Data_all_Vendors {
  String? ledgerType;
  int? id;
  String? accountName;
  String? companyName;
  String? billingName;
  AccountHead_Vendors? accountHead;
  List<Addresses_Vendors>? addresses;
  int? openingBalance;
  String? openingType;
  num? closingBalance;
  String? closingType;

  Data_all_Vendors(
      {this.ledgerType,
        this.id,
        this.accountName,
        this.companyName,
        this.billingName,
        this.accountHead,
        this.addresses,
        this.openingBalance,
        this.openingType,
        this.closingBalance,
        this.closingType});

  Data_all_Vendors.fromJson(Map<String, dynamic> json) {
    ledgerType = json['ledger_type'];
    id = json['id'];
    accountName = json['account_name'];
    companyName = json['company_name'];
    billingName = json['billing_name'];
    accountHead = json['account_head'] != null
        ? new AccountHead_Vendors.fromJson(json['account_head'])
        : null;
    if (json['addresses'] != null) {
      addresses = <Addresses_Vendors>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses_Vendors.fromJson(v));
      });
    }
    openingBalance = json['opening_balance'];
    openingType = json['opening_type'];
    closingBalance = json['closing_balance'];
    closingType = json['closing_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ledger_type'] = this.ledgerType;
    data['id'] = this.id;
    data['account_name'] = this.accountName;
    data['company_name'] = this.companyName;
    data['billing_name'] = this.billingName;
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
    return data;
  }
}
class AccountHead_Vendors {
  int? id;
  String? accountHeadName;
  bool? isDefault;
  int? superAdminId;
  int? companyProfileId;
  String? createdAt;
  String? updatedAt;
  num? createdBy;
  num? updateBy;

  AccountHead_Vendors(
      {this.id,
        this.accountHeadName,
        this.isDefault,
        this.superAdminId,
        this.companyProfileId,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updateBy});

  AccountHead_Vendors.fromJson(Map<String, dynamic> json) {
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
class Addresses_Vendors {
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
  num? vendorId;
  num? otherLedgerId;

  Addresses_Vendors(
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

  Addresses_Vendors.fromJson(Map<String, dynamic> json) {
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


class Data_all_Others {
  String? ledgerType;
  int? id;
  String? accountName;
  Null? companyName;
  String? billingName;
  AccountHead_Others? accountHead;
  List<Addresses_Others>? addresses;
  int? openingBalance;
  String? openingType;
  num? closingBalance;
  String? closingType;

  Data_all_Others(
      {this.ledgerType,
        this.id,
        this.accountName,
        this.companyName,
        this.billingName,
        this.accountHead,
        this.addresses,
        this.openingBalance,
        this.openingType,
        this.closingBalance,
        this.closingType});

  Data_all_Others.fromJson(Map<String, dynamic> json) {
    ledgerType = json['ledger_type'];
    id = json['id'];
    accountName = json['account_name'];
    companyName = json['company_name'];
    billingName = json['billing_name'];
    accountHead = json['account_head'] != null
        ? new AccountHead_Others.fromJson(json['account_head'])
        : null;
    if (json['addresses'] != null) {
      addresses = <Addresses_Others>[];
      json['addresses'].forEach((v) {
        addresses!.add(new Addresses_Others.fromJson(v));
      });
    }
    openingBalance = json['opening_balance'];
    openingType = json['opening_type'];
    closingBalance = json['closing_balance'];
    closingType = json['closing_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ledger_type'] = this.ledgerType;
    data['id'] = this.id;
    data['account_name'] = this.accountName;
    data['company_name'] = this.companyName;
    data['billing_name'] = this.billingName;
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
    return data;
  }
}
class AccountHead_Others {
  int? id;
  String? accountHeadName;
  bool? isDefault;
  int? superAdminId;
  int? companyProfileId;
  String? createdAt;
  String? updatedAt;
  Null? createdBy;
  Null? updateBy;

  AccountHead_Others(
      {this.id,
        this.accountHeadName,
        this.isDefault,
        this.superAdminId,
        this.companyProfileId,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updateBy});

  AccountHead_Others.fromJson(Map<String, dynamic> json) {
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
class Addresses_Others {
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
  Null? customerId;
  int? vendorId;
  Null? otherLedgerId;

  Addresses_Others(
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

  Addresses_Others.fromJson(Map<String, dynamic> json) {
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


class companyList {
  bool? success;
  List<Data_company>? data;

  companyList({this.success, this.data});

  companyList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_company>[];
      json['data'].forEach((v) {
        data!.add(new Data_company.fromJson(v));
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

class Data_company {
  int? id;
  String? logo;
  int? userId;
  String? companyName;
  String? panNumber;
  String? tanNumber;
  String? financialYearStartDate;
  String? financialYearEndDate;
  String? incorporationDate;
  String? bookStartDate;
  String? startPrefix;
  String? middleSymbol;
  String? numberStart;
  String? invoiceFormat;
  String? cin;
  bool? isDefault;
  String? createdAt;
  String? updatedAt;
  BusinessAddress? businessAddress;
  BusinessGst? businessGst;

  Data_company(
      {this.id,
        this.logo,
        this.userId,
        this.companyName,
        this.panNumber,
        this.tanNumber,
        this.financialYearStartDate,
        this.financialYearEndDate,
        this.incorporationDate,
        this.bookStartDate,
        this.startPrefix,
        this.middleSymbol,
        this.numberStart,
        this.invoiceFormat,
        this.cin,
        this.isDefault,
        this.createdAt,
        this.updatedAt,
        this.businessAddress,
        this.businessGst});

  Data_company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logo = json['logo'];
    userId = json['user_id'];
    companyName = json['company_name'];
    panNumber = json['pan_number'];
    tanNumber = json['tan_number'];
    financialYearStartDate = json['financial_year_start_date'];
    financialYearEndDate = json['financial_year_end_date'];
    incorporationDate = json['incorporation_date'];
    bookStartDate = json['book_start_date'];
    startPrefix = json['start_prefix'];
    middleSymbol = json['middle_symbol'];
    numberStart = json['number_start'];
    invoiceFormat = json['invoice_format'];
    cin = json['cin'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    businessAddress = json['business_address'] != null
        ? new BusinessAddress.fromJson(json['business_address'])
        : null;
    businessGst = json['business_gst'] != null
        ? new BusinessGst.fromJson(json['business_gst'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['logo'] = this.logo;
    data['user_id'] = this.userId;
    data['company_name'] = this.companyName;
    data['pan_number'] = this.panNumber;
    data['tan_number'] = this.tanNumber;
    data['financial_year_start_date'] = this.financialYearStartDate;
    data['financial_year_end_date'] = this.financialYearEndDate;
    data['incorporation_date'] = this.incorporationDate;
    data['book_start_date'] = this.bookStartDate;
    data['start_prefix'] = this.startPrefix;
    data['middle_symbol'] = this.middleSymbol;
    data['number_start'] = this.numberStart;
    data['invoice_format'] = this.invoiceFormat;
    data['cin'] = this.cin;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.businessAddress != null) {
      data['business_address'] = this.businessAddress!.toJson();
    }
    if (this.businessGst != null) {
      data['business_gst'] = this.businessGst!.toJson();
    }
    return data;
  }
}

class BusinessAddress {
  int? id;
  int? companyProfileId;
  String? address;
  String? city;
  String? pincode;
  String? state;
  String? country;
  String? stdCode;
  String? officeNumber;
  String? mobileNumber;
  String? countryCode;
  String? businessEmail;
  String? responsiblePerson;
  String? designationResponsiblePerson;
  String? createdAt;
  String? updatedAt;

  BusinessAddress(
      {this.id,
        this.companyProfileId,
        this.address,
        this.city,
        this.pincode,
        this.state,
        this.country,
        this.stdCode,
        this.officeNumber,
        this.mobileNumber,
        this.countryCode,
        this.businessEmail,
        this.responsiblePerson,
        this.designationResponsiblePerson,
        this.createdAt,
        this.updatedAt});

  BusinessAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyProfileId = json['company_profile_id'];
    address = json['address'];
    city = json['city'];
    pincode = json['pincode'];
    state = json['state'];
    country = json['country'];
    stdCode = json['std_code'];
    officeNumber = json['office_number'];
    mobileNumber = json['mobile_number'];
    countryCode = json['country_code'];
    businessEmail = json['business_email'];
    responsiblePerson = json['responsible_person'];
    designationResponsiblePerson = json['designation_responsible_person'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_profile_id'] = this.companyProfileId;
    data['address'] = this.address;
    data['city'] = this.city;
    data['pincode'] = this.pincode;
    data['state'] = this.state;
    data['country'] = this.country;
    data['std_code'] = this.stdCode;
    data['office_number'] = this.officeNumber;
    data['mobile_number'] = this.mobileNumber;
    data['country_code'] = this.countryCode;
    data['business_email'] = this.businessEmail;
    data['responsible_person'] = this.responsiblePerson;
    data['designation_responsible_person'] = this.designationResponsiblePerson;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class BusinessGst {
  int? id;
  int? companyProfileId;
  String? gstRegistrationType;
  String? gstNo;
  String? registrationDate;
  String? natureOfBusiness;
  String? ifscCode;
  String? bankName;
  String? accountNumber;
  String? accountHolderName;
  String? createdAt;
  String? updatedAt;

  BusinessGst(
      {this.id,
        this.companyProfileId,
        this.gstRegistrationType,
        this.gstNo,
        this.registrationDate,
        this.natureOfBusiness,
        this.ifscCode,
        this.bankName,
        this.accountNumber,
        this.accountHolderName,
        this.createdAt,
        this.updatedAt});

  BusinessGst.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyProfileId = json['company_profile_id'];
    gstRegistrationType = json['gst_registration_type'];
    gstNo = json['gst_no'];
    registrationDate = json['registration_date'];
    natureOfBusiness = json['nature_of_business'];
    ifscCode = json['ifsc_code'];
    bankName = json['bank_name'];
    accountNumber = json['account_number'];
    accountHolderName = json['account_holder_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['company_profile_id'] = this.companyProfileId;
    data['gst_registration_type'] = this.gstRegistrationType;
    data['gst_no'] = this.gstNo;
    data['registration_date'] = this.registrationDate;
    data['nature_of_business'] = this.natureOfBusiness;
    data['ifsc_code'] = this.ifscCode;
    data['bank_name'] = this.bankName;
    data['account_number'] = this.accountNumber;
    data['account_holder_name'] = this.accountHolderName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
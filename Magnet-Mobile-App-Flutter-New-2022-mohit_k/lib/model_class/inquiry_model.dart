class inquiryList {
  bool? success;
  List<Data_inquiry>? data;

  inquiryList({this.success, this.data});

  inquiryList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_inquiry>[];
      json['data'].forEach((v) {
        data!.add(new Data_inquiry.fromJson(v));
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

class Data_inquiry {
  int? id;
  String? businessName;
  String? mobileNo;
  String? inquiryDate;
  String? followupDate;
  String? email;
  String? name;
  String? inquiryFor;
  String? estimationPrice;
  String? sourceOfPromotion;
  String? inquiryStatus;
  String? response;
  String? assignTo;
  String? birthDate;
  String? referredBy;
  String? createdAt;
  String? updatedAt;

  Data_inquiry(
      {this.id,
        this.businessName,
        this.mobileNo,
        this.inquiryDate,
        this.followupDate,
        this.email,
        this.name,
        this.inquiryFor,
        this.estimationPrice,
        this.sourceOfPromotion,
        this.inquiryStatus,
        this.response,
        this.assignTo,
        this.birthDate,
        this.referredBy,
        this.createdAt,
        this.updatedAt});

  Data_inquiry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    businessName = json['business_name'];
    mobileNo = json['mobile_no'];
    inquiryDate = json['inquiry_date'];
    followupDate = json['followup_date'];
    email = json['email'];
    name = json['name'];
    inquiryFor = json['inquiry_for'];
    estimationPrice = json['estimation_price'];
    sourceOfPromotion = json['source_of_promotion'];
    inquiryStatus = json['inquiry_status'];
    response = json['response'];
    assignTo = json['assign_to'];
    birthDate = json['birth_date'];
    referredBy = json['referred_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['business_name'] = this.businessName;
    data['mobile_no'] = this.mobileNo;
    data['inquiry_date'] = this.inquiryDate;
    data['followup_date'] = this.followupDate;
    data['email'] = this.email;
    data['name'] = this.name;
    data['inquiry_for'] = this.inquiryFor;
    data['estimation_price'] = this.estimationPrice;
    data['source_of_promotion'] = this.sourceOfPromotion;
    data['inquiry_status'] = this.inquiryStatus;
    data['response'] = this.response;
    data['assign_to'] = this.assignTo;
    data['birth_date'] = this.birthDate;
    data['referred_by'] = this.referredBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
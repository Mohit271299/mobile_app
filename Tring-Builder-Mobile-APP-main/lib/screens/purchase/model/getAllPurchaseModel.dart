// To parse this JSON data, do
//
//     final getAllSalesModel = getAllSalesModelFromJson(jsonString);

import 'dart:convert';

GetAllPurchaseModel getAllPurchasesModelFromJson(String str) => GetAllPurchaseModel.fromJson(json.decode(str));

String getAllSalesModelToJson(GetAllPurchaseModel data) => json.encode(data.toJson());

class GetAllPurchaseModel {
  GetAllPurchaseModel({
    this.success,
    this.data,
  });

  bool? success;
  List<Datup>? data;

  factory GetAllPurchaseModel.fromJson(Map<String, dynamic> json) => GetAllPurchaseModel(
    success: json["success"],
    data: List<Datup>.from(json["data"].map((x) => Datup.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datup {
  int? id;
  String? billNo;
  String? invoiceDate;
  int? contactId;
  int? totalAmount;
  Contact? contact;

  Datup(
      {this.id,
        this.billNo,
        this.invoiceDate,
        this.contactId,
        this.totalAmount,
        this.contact});

  Datup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    billNo = json['billNo'];
    invoiceDate = json['invoiceDate'];
    contactId = json['contactId'];
    totalAmount = json['totalAmount'];
    contact =
    json['contact'] != null ? Contact.fromJson(json['contact']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['billNo'] = billNo;
    data['invoiceDate'] = invoiceDate;
    data['contactId'] = contactId;
    data['totalAmount'] = totalAmount;
    if (contact != null) {
      data['contact'] = contact!.toJson();
    }
    return data;
  }
}

class Contact {
  int? id;
  String? name;
  String? contactType;
  String? mobileNo;
  String? emailId;
  String? businessName;
  String? businessType;
  String? alternateMobileNo;
  String? phoneNo;
  String? contactOn;
  String? fax;
  String? website;
  String? birthDate;
  String? marriageDate;
  String? socialMediaAccountLinks;
  bool? sameAddress;
  String? sourceOfPromotion;
  String? sourceCampaign;
  String? descriptionInformation;
  int? createdBy;
  Null? updatedBy;
  String? createdAt;
  String? updatedAt;

  Contact(
      {this.id,
        this.name,
        this.contactType,
        this.mobileNo,
        this.emailId,
        this.businessName,
        this.businessType,
        this.alternateMobileNo,
        this.phoneNo,
        this.contactOn,
        this.fax,
        this.website,
        this.birthDate,
        this.marriageDate,
        this.socialMediaAccountLinks,
        this.sameAddress,
        this.sourceOfPromotion,
        this.sourceCampaign,
        this.descriptionInformation,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt});

  Contact.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    contactType = json['contactType'];
    mobileNo = json['mobileNo'];
    emailId = json['emailId'];
    businessName = json['businessName'];
    businessType = json['businessType'];
    alternateMobileNo = json['alternateMobileNo'];
    phoneNo = json['phoneNo'];
    contactOn = json['contactOn'];
    fax = json['fax'];
    website = json['website'];
    birthDate = json['birthDate'];
    marriageDate = json['marriageDate'];
    socialMediaAccountLinks = json['socialMediaAccountLinks'];
    sameAddress = json['sameAddress'];
    sourceOfPromotion = json['sourceOfPromotion'];
    sourceCampaign = json['sourceCampaign'];
    descriptionInformation = json['descriptionInformation'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['contactType'] = contactType;
    data['mobileNo'] = mobileNo;
    data['emailId'] = emailId;
    data['businessName'] = businessName;
    data['businessType'] = businessType;
    data['alternateMobileNo'] = alternateMobileNo;
    data['phoneNo'] = phoneNo;
    data['contactOn'] = contactOn;
    data['fax'] = fax;
    data['website'] = website;
    data['birthDate'] = birthDate;
    data['marriageDate'] = marriageDate;
    data['socialMediaAccountLinks'] = socialMediaAccountLinks;
    data['sameAddress'] = sameAddress;
    data['sourceOfPromotion'] = sourceOfPromotion;
    data['sourceCampaign'] = sourceCampaign;
    data['descriptionInformation'] = descriptionInformation;
    data['created_by'] = createdBy;
    data['updated_by'] = updatedBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
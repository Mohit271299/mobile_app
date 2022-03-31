// To parse this JSON data, do
//
//     final getAllCustomerDetails = getAllCustomerDetailsFromJson(jsonString);

import 'dart:convert';

GetAllCustomerDetails getAllCustomerDetailsFromJson(String str) => GetAllCustomerDetails.fromJson(json.decode(str));

String getAllCustomerDetailsToJson(GetAllCustomerDetails data) => json.encode(data.toJson());

class GetAllCustomerDetails {
  GetAllCustomerDetails({
    this.success,
    this.data,
  });

  bool? success;
  List<Datum>? data;

  factory GetAllCustomerDetails.fromJson(Map<String, dynamic> json) => GetAllCustomerDetails(
    success: json["success"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
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
    this.updatedAt,
  });

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
  dynamic updatedBy;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    contactType: json["contactType"],
    mobileNo: json["mobileNo"],
    emailId: json["emailId"],
    businessName: json["businessName"],
    businessType: json["businessType"],
    alternateMobileNo: json["alternateMobileNo"],
    phoneNo: json["phoneNo"],
    contactOn: json["contactOn"],
    fax: json["fax"],
    website: json["website"],
    birthDate: json["birthDate"],
    marriageDate: json["marriageDate"],
    socialMediaAccountLinks: json["socialMediaAccountLinks"],
    sameAddress: json["sameAddress"],
    sourceOfPromotion: json["sourceOfPromotion"],
    sourceCampaign: json["sourceCampaign"],
    descriptionInformation: json["descriptionInformation"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "contactType": contactType,
    "mobileNo": mobileNo,
    "emailId": emailId,
    "businessName": businessName,
    "businessType": businessType,
    "alternateMobileNo": alternateMobileNo,
    "phoneNo": phoneNo,
    "contactOn": contactOn,
    "fax": fax,
    "website": website,
    "birthDate": birthDate,
    "marriageDate": marriageDate,
    "socialMediaAccountLinks": socialMediaAccountLinks,
    "sameAddress": sameAddress,
    "sourceOfPromotion": sourceOfPromotion,
    "sourceCampaign": sourceCampaign,
    "descriptionInformation": descriptionInformation,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}

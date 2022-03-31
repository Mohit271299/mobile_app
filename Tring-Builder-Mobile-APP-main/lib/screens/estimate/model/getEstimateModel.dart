class GetEstimateModel {
  bool? success;
  List<Data>? data;

  GetEstimateModel({this.success, this.data});

  GetEstimateModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  num? estimateNo;
  int? totalAmount;
  String? estimateDate;
  int? contactId;
  Contact? contact;
  List<EstimateItems>? estimateItems;

  Data(
      {this.id,
        this.estimateNo,
        this.totalAmount,
        this.estimateDate,
        this.contactId,
        this.contact,
        this.estimateItems});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estimateNo = json['estimateNo'];
    totalAmount = json['totalAmount'];
    estimateDate = json['estimateDate'];
    contactId = json['contactId'];
    contact =
    json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
    if (json['estimateItems'] != null) {
      estimateItems = <EstimateItems>[];
      json['estimateItems'].forEach((v) {
        estimateItems!.add(new EstimateItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['estimateNo'] = this.estimateNo;
    data['totalAmount'] = this.totalAmount;
    data['estimateDate'] = this.estimateDate;
    data['contactId'] = this.contactId;
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    if (this.estimateItems != null) {
      data['estimateItems'] =
          this.estimateItems!.map((v) => v.toJson()).toList();
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
    data['id'] = this.id;
    data['name'] = this.name;
    data['contactType'] = this.contactType;
    data['mobileNo'] = this.mobileNo;
    data['emailId'] = this.emailId;
    data['businessName'] = this.businessName;
    data['businessType'] = this.businessType;
    data['alternateMobileNo'] = this.alternateMobileNo;
    data['phoneNo'] = this.phoneNo;
    data['contactOn'] = this.contactOn;
    data['fax'] = this.fax;
    data['website'] = this.website;
    data['birthDate'] = this.birthDate;
    data['marriageDate'] = this.marriageDate;
    data['socialMediaAccountLinks'] = this.socialMediaAccountLinks;
    data['sameAddress'] = this.sameAddress;
    data['sourceOfPromotion'] = this.sourceOfPromotion;
    data['sourceCampaign'] = this.sourceCampaign;
    data['descriptionInformation'] = this.descriptionInformation;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class EstimateItems {
  int? id;
  int? squareFeet;
  int? pricePerSquareFeet;
  int? basicAmount;
  int? otherChargeAmount;
  int? gst;
  int? estimateId;
  int? flatId;
  OtherCharges? otherCharges;
  Flat? flat;

  EstimateItems(
      {this.id,
        this.squareFeet,
        this.pricePerSquareFeet,
        this.basicAmount,
        this.otherChargeAmount,
        this.gst,
        this.estimateId,
        this.flatId,
        this.otherCharges,
        this.flat});

  EstimateItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    squareFeet = json['squareFeet'];
    pricePerSquareFeet = json['pricePerSquareFeet'];
    basicAmount = json['basicAmount'];
    otherChargeAmount = json['otherChargeAmount'];
    gst = json['gst'];
    estimateId = json['estimateId'];
    flatId = json['flatId'];
    otherCharges = json['otherCharges'] != null
        ? new OtherCharges.fromJson(json['otherCharges'])
        : null;
    flat = json['flat'] != null ? new Flat.fromJson(json['flat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['squareFeet'] = this.squareFeet;
    data['pricePerSquareFeet'] = this.pricePerSquareFeet;
    data['basicAmount'] = this.basicAmount;
    data['otherChargeAmount'] = this.otherChargeAmount;
    data['gst'] = this.gst;
    data['estimateId'] = this.estimateId;
    data['flatId'] = this.flatId;
    if (this.otherCharges != null) {
      data['otherCharges'] = this.otherCharges!.toJson();
    }
    if (this.flat != null) {
      data['flat'] = this.flat!.toJson();
    }
    return data;
  }
}

class OtherCharges {
  int? id;
  int? estimateItemId;
  Null? saleId;
  int? parking;
  int? maintenanceDeposite;
  int? preferentialLocationCharges;
  int? registrationFee;
  int? stampDuty;
  int? brokerageCharges;
  int? titleSalesDeedCharges;
  int? notaryFrankingCharges;
  int? mortgageCharges;
  int? otherCharges;
  int? clubMembership;
  int? civicAmenitiesCharges;
  int? externalDevelopmentCharges;
  int? infrastructureDevelopmentCharges;
  int? overheadCharges;
  int? insuranceFee;
  int? utilityCharges;
  int? homeInspectionCost;
  int? interiors;
  int? plumbing;
  int? furniture;
  int? electricWork;
  int? miscellaneousCharges;
  int? loanAmount;
  int? interestCharges;
  int? loanProcessingFee;
  int? prepaymentCharges;
  int? latePaymentCharges;
  int? applicationProcessingFee;

  OtherCharges(
      {this.id,
        this.estimateItemId,
        this.saleId,
        this.parking,
        this.maintenanceDeposite,
        this.preferentialLocationCharges,
        this.registrationFee,
        this.stampDuty,
        this.brokerageCharges,
        this.titleSalesDeedCharges,
        this.notaryFrankingCharges,
        this.mortgageCharges,
        this.otherCharges,
        this.clubMembership,
        this.civicAmenitiesCharges,
        this.externalDevelopmentCharges,
        this.infrastructureDevelopmentCharges,
        this.overheadCharges,
        this.insuranceFee,
        this.utilityCharges,
        this.homeInspectionCost,
        this.interiors,
        this.plumbing,
        this.furniture,
        this.electricWork,
        this.miscellaneousCharges,
        this.loanAmount,
        this.interestCharges,
        this.loanProcessingFee,
        this.prepaymentCharges,
        this.latePaymentCharges,
        this.applicationProcessingFee});

  OtherCharges.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    estimateItemId = json['estimateItemId'];
    saleId = json['saleId'];
    parking = json['parking'];
    maintenanceDeposite = json['maintenanceDeposite'];
    preferentialLocationCharges = json['preferentialLocationCharges'];
    registrationFee = json['registrationFee'];
    stampDuty = json['stampDuty'];
    brokerageCharges = json['brokerageCharges'];
    titleSalesDeedCharges = json['titleSalesDeedCharges'];
    notaryFrankingCharges = json['notaryFrankingCharges'];
    mortgageCharges = json['mortgageCharges'];
    otherCharges = json['otherCharges'];
    clubMembership = json['clubMembership'];
    civicAmenitiesCharges = json['civicAmenitiesCharges'];
    externalDevelopmentCharges = json['externalDevelopmentCharges'];
    infrastructureDevelopmentCharges = json['infrastructureDevelopmentCharges'];
    overheadCharges = json['overheadCharges'];
    insuranceFee = json['insuranceFee'];
    utilityCharges = json['utilityCharges'];
    homeInspectionCost = json['homeInspectionCost'];
    interiors = json['interiors'];
    plumbing = json['plumbing'];
    furniture = json['furniture'];
    electricWork = json['electricWork'];
    miscellaneousCharges = json['miscellaneousCharges'];
    loanAmount = json['loanAmount'];
    interestCharges = json['interestCharges'];
    loanProcessingFee = json['loanProcessingFee'];
    prepaymentCharges = json['prepaymentCharges'];
    latePaymentCharges = json['latePaymentCharges'];
    applicationProcessingFee = json['applicationProcessingFee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['estimateItemId'] = this.estimateItemId;
    data['saleId'] = this.saleId;
    data['parking'] = this.parking;
    data['maintenanceDeposite'] = this.maintenanceDeposite;
    data['preferentialLocationCharges'] = this.preferentialLocationCharges;
    data['registrationFee'] = this.registrationFee;
    data['stampDuty'] = this.stampDuty;
    data['brokerageCharges'] = this.brokerageCharges;
    data['titleSalesDeedCharges'] = this.titleSalesDeedCharges;
    data['notaryFrankingCharges'] = this.notaryFrankingCharges;
    data['mortgageCharges'] = this.mortgageCharges;
    data['otherCharges'] = this.otherCharges;
    data['clubMembership'] = this.clubMembership;
    data['civicAmenitiesCharges'] = this.civicAmenitiesCharges;
    data['externalDevelopmentCharges'] = this.externalDevelopmentCharges;
    data['infrastructureDevelopmentCharges'] =
        this.infrastructureDevelopmentCharges;
    data['overheadCharges'] = this.overheadCharges;
    data['insuranceFee'] = this.insuranceFee;
    data['utilityCharges'] = this.utilityCharges;
    data['homeInspectionCost'] = this.homeInspectionCost;
    data['interiors'] = this.interiors;
    data['plumbing'] = this.plumbing;
    data['furniture'] = this.furniture;
    data['electricWork'] = this.electricWork;
    data['miscellaneousCharges'] = this.miscellaneousCharges;
    data['loanAmount'] = this.loanAmount;
    data['interestCharges'] = this.interestCharges;
    data['loanProcessingFee'] = this.loanProcessingFee;
    data['prepaymentCharges'] = this.prepaymentCharges;
    data['latePaymentCharges'] = this.latePaymentCharges;
    data['applicationProcessingFee'] = this.applicationProcessingFee;
    return data;
  }
}

class Flat {
  int? id;
  int? projectId;
  int? towerId;
  int? numberOfFlats;
  int? flatNumber;
  String? blockNumber;
  int? floorNumber;
  int? squareFeet;
  int? bhk;
  int? floorId;

  Flat(
      {this.id,
        this.projectId,
        this.towerId,
        this.numberOfFlats,
        this.flatNumber,
        this.blockNumber,
        this.floorNumber,
        this.squareFeet,
        this.bhk,
        this.floorId});

  Flat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectId = json['projectId'];
    towerId = json['towerId'];
    numberOfFlats = json['numberOfFlats'];
    flatNumber = json['flatNumber'];
    blockNumber = json['blockNumber'];
    floorNumber = json['floorNumber'];
    squareFeet = json['squareFeet'];
    bhk = json['bhk'];
    floorId = json['floorId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['projectId'] = this.projectId;
    data['towerId'] = this.towerId;
    data['numberOfFlats'] = this.numberOfFlats;
    data['flatNumber'] = this.flatNumber;
    data['blockNumber'] = this.blockNumber;
    data['floorNumber'] = this.floorNumber;
    data['squareFeet'] = this.squareFeet;
    data['bhk'] = this.bhk;
    data['floorId'] = this.floorId;
    return data;
  }
}
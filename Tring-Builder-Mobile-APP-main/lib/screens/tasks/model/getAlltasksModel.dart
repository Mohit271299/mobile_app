class GetAllTasksModel {
  bool? success;
  List<Data_tasks>? data;

  GetAllTasksModel({this.success, this.data});

  GetAllTasksModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_tasks>[];
      json['data'].forEach((v) {
        data!.add(new Data_tasks.fromJson(v));
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

class Data_tasks {
  int? id;
  int? typeId;
  String? subject;
  Null? ownerId;
  String? assignTo;
  int? contactId;
  String? address;
  String? fromDate;
  String? toDate;
  String? reminder;
  String? priority;
  String? description;
  int? addedBy;
  Null? updatedBy;
  Type? type;
  Contact? contact;

  Data_tasks(
      {this.id,
        this.typeId,
        this.subject,
        this.ownerId,
        this.assignTo,
        this.contactId,
        this.address,
        this.fromDate,
        this.toDate,
        this.reminder,
        this.priority,
        this.description,
        this.addedBy,
        this.updatedBy,
        this.type,
        this.contact});

  Data_tasks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    typeId = json['typeId'];
    subject = json['subject'];
    ownerId = json['ownerId'];
    assignTo = json['assignTo'];
    contactId = json['contactId'];
    address = json['address'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    reminder = json['reminder'];
    priority = json['priority'];
    description = json['description'];
    addedBy = json['addedBy'];
    updatedBy = json['updatedBy'];
    type = json['type'] != null ? new Type.fromJson(json['type']) : null;
    contact =
    json['contact'] != null ? new Contact.fromJson(json['contact']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['typeId'] = this.typeId;
    data['subject'] = this.subject;
    data['ownerId'] = this.ownerId;
    data['assignTo'] = this.assignTo;
    data['contactId'] = this.contactId;
    data['address'] = this.address;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['reminder'] = this.reminder;
    data['priority'] = this.priority;
    data['description'] = this.description;
    data['addedBy'] = this.addedBy;
    data['updatedBy'] = this.updatedBy;
    if (this.type != null) {
      data['type'] = this.type!.toJson();
    }
    if (this.contact != null) {
      data['contact'] = this.contact!.toJson();
    }
    return data;
  }
}

class Type {
  int? id;
  String? type;

  Type({this.id, this.type});

  Type.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
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
  Null? alternateMobileNo;
  Null? phoneNo;
  String? contactOn;
  Null? fax;
  Null? website;
  String? birthDate;
  Null? marriageDate;
  Null? socialMediaAccountLinks;
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

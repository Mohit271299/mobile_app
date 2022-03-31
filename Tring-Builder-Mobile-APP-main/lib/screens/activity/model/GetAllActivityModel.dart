class GetAllActivityModel {
  bool? success;
  List<Data_activity>? data;

  GetAllActivityModel({this.success, this.data});

  GetAllActivityModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_activity>[];
      json['data'].forEach((v) {
        data!.add(new Data_activity.fromJson(v));
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

class Data_activity {
  int? id;
  int? activityTypeId;
  int? associatedLeadId;
  String? activityDate;
  String? activityTime;
  String? description;
  String? timeNeeded;
  Null? priority;
  AssociatedLead? associatedLead;
  ActivityType? activityType;

  Data_activity(
      {this.id,
        this.activityTypeId,
        this.associatedLeadId,
        this.activityDate,
        this.activityTime,
        this.description,
        this.timeNeeded,
        this.priority,
        this.associatedLead,
        this.activityType});

  Data_activity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    activityTypeId = json['activityTypeId'];
    associatedLeadId = json['associatedLeadId'];
    activityDate = json['activityDate'];
    activityTime = json['activityTime'];
    description = json['description'];
    timeNeeded = json['timeNeeded'];
    priority = json['priority'];
    associatedLead = json['associatedLead'] != null
        ? new AssociatedLead.fromJson(json['associatedLead'])
        : null;
    activityType = json['activityType'] != null
        ? new ActivityType.fromJson(json['activityType'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['activityTypeId'] = this.activityTypeId;
    data['associatedLeadId'] = this.associatedLeadId;
    data['activityDate'] = this.activityDate;
    data['activityTime'] = this.activityTime;
    data['description'] = this.description;
    data['timeNeeded'] = this.timeNeeded;
    data['priority'] = this.priority;
    if (this.associatedLead != null) {
      data['associatedLead'] = this.associatedLead!.toJson();
    }
    if (this.activityType != null) {
      data['activityType'] = this.activityType!.toJson();
    }
    return data;
  }
}

class AssociatedLead {
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

  AssociatedLead(
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

  AssociatedLead.fromJson(Map<String, dynamic> json) {
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

class ActivityType {
  int? id;
  String? type;

  ActivityType({this.id, this.type});

  ActivityType.fromJson(Map<String, dynamic> json) {
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
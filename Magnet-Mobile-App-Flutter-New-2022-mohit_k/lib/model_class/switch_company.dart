class swithcompanyList {
  bool? success;
  Data_switchCompany? data;

  swithcompanyList({this.success, this.data});

  swithcompanyList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data_switchCompany.fromJson(json['data']) : null;
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

class Data_switchCompany {
  String? token;
  User? user;

  Data_switchCompany({this.token, this.user});

  Data_switchCompany.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  int? accountId;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  Null? profileImage;
  String? contactNo;
  int? companyProfileId;
  int? roleId;
  String? role;
  bool? verifyOtp;
  String? createdAt;
  String? updatedAt;
  String? firebaseUid;
  String? appReferralCode;
  Null? step;
  Subscription? subscription;
  String? companyName;
  List<String>? permissions;

  User(
      {this.id,
        this.accountId,
        this.firstName,
        this.lastName,
        this.email,
        this.username,
        this.profileImage,
        this.contactNo,
        this.companyProfileId,
        this.roleId,
        this.role,
        this.verifyOtp,
        this.createdAt,
        this.updatedAt,
        this.firebaseUid,
        this.appReferralCode,
        this.step,
        this.subscription,
        this.companyName,
        this.permissions});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['account_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    username = json['username'];
    profileImage = json['profile_image'];
    contactNo = json['contact_no'];
    companyProfileId = json['company_profile_id'];
    roleId = json['role_id'];
    role = json['role'];
    verifyOtp = json['verify_otp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    firebaseUid = json['firebase_uid'];
    appReferralCode = json['app_referral_code'];
    step = json['step'];
    subscription = json['subscription'] != null
        ? new Subscription.fromJson(json['subscription'])
        : null;
    companyName = json['company_name'];
    permissions = json['permissions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['account_id'] = this.accountId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['username'] = this.username;
    data['profile_image'] = this.profileImage;
    data['contact_no'] = this.contactNo;
    data['company_profile_id'] = this.companyProfileId;
    data['role_id'] = this.roleId;
    data['role'] = this.role;
    data['verify_otp'] = this.verifyOtp;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['firebase_uid'] = this.firebaseUid;
    data['app_referral_code'] = this.appReferralCode;
    data['step'] = this.step;
    if (this.subscription != null) {
      data['subscription'] = this.subscription!.toJson();
    }
    data['company_name'] = this.companyName;
    data['permissions'] = this.permissions;
    return data;
  }
}

class Subscription {
  String? startDate;
  String? endDate;
  int? payableAmount;
  int? paidAmount;
  String? createdAt;
  String? subscriptionPlanName;

  Subscription(
      {this.startDate,
        this.endDate,
        this.payableAmount,
        this.paidAmount,
        this.createdAt,
        this.subscriptionPlanName});

  Subscription.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    payableAmount = json['payable_amount'];
    paidAmount = json['paid_amount'];
    createdAt = json['created_at'];
    subscriptionPlanName = json['subscription_plan_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['payable_amount'] = this.payableAmount;
    data['paid_amount'] = this.paidAmount;
    data['created_at'] = this.createdAt;
    data['subscription_plan_name'] = this.subscriptionPlanName;
    return data;
  }
}
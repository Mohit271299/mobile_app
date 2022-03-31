class Account_head_model {
  Account_head_model({
      bool? success, 
      List<Data_ac_head>? data,}){
    _success = success;
    _data = data;
}

  Account_head_model.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data_ac_head.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Data_ac_head>? _data;

  bool? get success => _success;
  List<Data_ac_head>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data_ac_head {
  Data_ac_head({
      int? id, 
      String? accountHeadName, 
      bool? isDefault, 
      int? superAdminId, 
      int? companyProfileId, 
      String? createdAt, 
      String? updatedAt, 
      int? createdBy, 
      int? updateBy,}){
    _id = id;
    _accountHeadName = accountHeadName;
    _isDefault = isDefault;
    _superAdminId = superAdminId;
    _companyProfileId = companyProfileId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _createdBy = createdBy;
    _updateBy = updateBy;
}

  Data_ac_head.fromJson(dynamic json) {
    _id = json['id'];
    _accountHeadName = json['account_head_name'];
    _isDefault = json['is_default'];
    _superAdminId = json['super_admin_id'];
    _companyProfileId = json['company_profile_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _createdBy = json['created_by'];
    _updateBy = json['update_by'];
  }
  int? _id;
  String? _accountHeadName;
  bool? _isDefault;
  int? _superAdminId;
  int? _companyProfileId;
  String? _createdAt;
  String? _updatedAt;
  int? _createdBy;
  int? _updateBy;

  int? get id => _id;
  String? get accountHeadName => _accountHeadName;
  bool? get isDefault => _isDefault;
  int? get superAdminId => _superAdminId;
  int? get companyProfileId => _companyProfileId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  int? get createdBy => _createdBy;
  int? get updateBy => _updateBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['account_head_name'] = _accountHeadName;
    map['is_default'] = _isDefault;
    map['super_admin_id'] = _superAdminId;
    map['company_profile_id'] = _companyProfileId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['created_by'] = _createdBy;
    map['update_by'] = _updateBy;
    return map;
  }

}
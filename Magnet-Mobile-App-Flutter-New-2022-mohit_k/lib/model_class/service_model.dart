class serviceList {
  bool? success;
  List<Data_service>? data;

  serviceList({this.success, this.data});

  serviceList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_service>[];
      json['data'].forEach((v) {
        data!.add(new Data_service.fromJson(v));
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

class Data_service {
  int? id;
  String? serviceName;
  String? sacCode;
  String? serviceType;
  int? salesPrice;
  String? incomeAccount;
  int? totalSales;
  int? companyProfileId;
  String? createdAt;
  String? updateAt;
  int? createdBy;
  int? updateBy;

  Data_service(
      {this.id,
        this.serviceName,
        this.sacCode,
        this.serviceType,
        this.salesPrice,
        this.incomeAccount,
        this.totalSales,
        this.companyProfileId,
        this.createdAt,
        this.updateAt,
        this.createdBy,
        this.updateBy});

  Data_service.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
    sacCode = json['sac_code'];
    serviceType = json['service_type'];
    salesPrice = json['sales_price'];
    incomeAccount = json['income_account'];
    totalSales = json['total_sales'];
    companyProfileId = json['company_profile_id'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    createdBy = json['created_by'];
    updateBy = json['update_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['service_name'] = this.serviceName;
    data['sac_code'] = this.sacCode;
    data['service_type'] = this.serviceType;
    data['sales_price'] = this.salesPrice;
    data['income_account'] = this.incomeAccount;
    data['total_sales'] = this.totalSales;
    data['company_profile_id'] = this.companyProfileId;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    data['created_by'] = this.createdBy;
    data['update_by'] = this.updateBy;
    return data;
  }
}
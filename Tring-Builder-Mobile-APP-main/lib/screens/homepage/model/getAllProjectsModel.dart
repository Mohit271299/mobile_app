class GetAllProjcetsModel {
  bool? success;
  List<Data>? data;

  GetAllProjcetsModel({this.success, this.data});

  GetAllProjcetsModel.fromJson(Map<String, dynamic> json) {
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
  String? tower;
  List<tower_data>? data_tower;

  Data({this.tower, this.data_tower});

  Data.fromJson(Map<String, dynamic> json) {
    tower = json['tower'];
    if (json['data'] != null) {
      data_tower = <tower_data>[];
      json['data'].forEach((v) {
        data_tower!.add(new tower_data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tower'] = this.tower;
    if (this.data_tower != null) {
      data['data'] = this.data_tower!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class tower_data {
  int? id;
  String? tower;
  String? blockNumber;
  int? salesAmount;
  String? invoiceDate;
  Null? dueDate;
  String? contactName;
  String? leads;
  String? estimateItems;

  tower_data(
      {this.id,
        this.tower,
        this.blockNumber,
        this.salesAmount,
        this.invoiceDate,
        this.dueDate,
        this.contactName,
        this.leads,
        this.estimateItems});

  tower_data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tower = json['tower'];
    blockNumber = json['blockNumber'];
    salesAmount = json['salesAmount'];
    invoiceDate = json['invoiceDate'];
    dueDate = json['dueDate'];
    contactName = json['contactName'];
    leads = json['leads'];
    estimateItems = json['estimateItems'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tower'] = this.tower;
    data['blockNumber'] = this.blockNumber;
    data['salesAmount'] = this.salesAmount;
    data['invoiceDate'] = this.invoiceDate;
    data['dueDate'] = this.dueDate;
    data['contactName'] = this.contactName;
    data['leads'] = this.leads;
    data['estimateItems'] = this.estimateItems;
    return data;
  }
}
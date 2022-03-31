class GetAllActivityTypeModel {
  bool? success;
  List<Data_activityType>? data;

  GetAllActivityTypeModel({this.success, this.data});

  GetAllActivityTypeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_activityType>[];
      json['data'].forEach((v) {
        data!.add(new Data_activityType.fromJson(v));
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

class Data_activityType {
  int? id;
  String? type;

  Data_activityType({this.id, this.type});

  Data_activityType.fromJson(Map<String, dynamic> json) {
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
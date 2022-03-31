class State_model {
  State_model({
      bool? success, 
      List<Data_state>? data,}){
    _success = success;
    _data = data;
}

  State_model.fromJson(dynamic json) {
    _success = json['success'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data_state.fromJson(v));
      });
    }
  }
  bool? _success;
  List<Data_state>? _data;

  bool? get success => _success;
  List<Data_state>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Data_state {
  Data_state({
      int? id, 
      int? stateCode, 
      String? name,}){
    _id = id;
    _stateCode = stateCode;
    _name = name;
}

  Data_state.fromJson(dynamic json) {
    _id = json['id'];
    _stateCode = json['stateCode'];
    _name = json['name'];
  }
  int? _id;
  int? _stateCode;
  String? _name;

  int? get id => _id;
  int? get stateCode => _stateCode;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['stateCode'] = _stateCode;
    map['name'] = _name;
    return map;
  }

}
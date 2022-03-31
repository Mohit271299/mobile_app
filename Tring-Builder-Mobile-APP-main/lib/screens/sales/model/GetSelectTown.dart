import 'dart:convert';

GetSelectTown getSelectTownFromJson(String str) => GetSelectTown.fromJson(json.decode(str));

String getSelectTownToJson(GetSelectTown data) => json.encode(data.toJson());

class GetSelectTown {
  GetSelectTown({
    this.success,
    this.data,
  });

  bool? success;
  List<Datum>? data;

  factory GetSelectTown.fromJson(Map<String, dynamic> json) => GetSelectTown(
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
    this.projectId,
    this.tower,
    this.numberOfFloors,
  });

  int? id;
  int? projectId;
  String? tower;
  int? numberOfFloors;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    projectId: json["projectId"],
    tower: json["tower"],
    numberOfFloors: json["numberOfFloors"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "projectId": projectId,
    "tower": tower,
    "numberOfFloors": numberOfFloors,
  };
}

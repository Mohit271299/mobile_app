// To parse this JSON data, do
//
//     final getSelectFloor = getSelectFloorFromJson(jsonString);

import 'dart:convert';

GetSelectFloor getSelectFloorFromJson(String str) => GetSelectFloor.fromJson(json.decode(str));

String getSelectFloorToJson(GetSelectFloor data) => json.encode(data.toJson());

class GetSelectFloor {
  GetSelectFloor({
    this.success,
    this.data,
  });

  bool? success;
  List<Datum>? data;

  factory GetSelectFloor.fromJson(Map<String, dynamic> json) => GetSelectFloor(
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
    this.towerId,
    this.numberOfFlats,
    this.floorNumber,
  });

  int? id;
  int? projectId;
  int? towerId;
  int? numberOfFlats;
  int? floorNumber;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    projectId: json["projectId"],
    towerId: json["towerId"],
    numberOfFlats: json["numberOfFlats"],
    floorNumber: json["floorNumber"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "projectId": projectId,
    "towerId": towerId,
    "numberOfFlats": numberOfFlats,
    "floorNumber": floorNumber,
  };
}

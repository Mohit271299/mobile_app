// To parse this JSON data, do
//
//     final getSelectFlat = getSelectFlatFromJson(jsonString);

import 'dart:convert';

GetSelectFlat getSelectFlatFromJson(String str) => GetSelectFlat.fromJson(json.decode(str));

String getSelectFlatToJson(GetSelectFlat data) => json.encode(data.toJson());

class GetSelectFlat {
  GetSelectFlat({
    this.success,
    this.data,
  });

  bool? success;
  List<Datum>? data;

  factory GetSelectFlat.fromJson(Map<String, dynamic> json) => GetSelectFlat(
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
    this.flatNumber,
    this.blockNumber,
    this.floorNumber,
    this.squareFeet,
    this.bhk,
    this.floorId,
  });

  int? id;
  int? projectId;
  int? towerId;
  int? numberOfFlats;
  int? flatNumber;
  String? blockNumber;
  int? floorNumber;
  int? squareFeet;
  int? bhk;
  int? floorId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    projectId: json["projectId"],
    towerId: json["towerId"],
    numberOfFlats: json["numberOfFlats"],
    flatNumber: json["flatNumber"],
    blockNumber: json["blockNumber"],
    floorNumber: json["floorNumber"],
    squareFeet: json["squareFeet"],
    bhk: json["bhk"],
    floorId: json["floorId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "projectId": projectId,
    "towerId": towerId,
    "numberOfFlats": numberOfFlats,
    "flatNumber": flatNumber,
    "blockNumber": blockNumber,
    "floorNumber": floorNumber,
    "squareFeet": squareFeet,
    "bhk": bhk,
    "floorId": floorId,
  };
}

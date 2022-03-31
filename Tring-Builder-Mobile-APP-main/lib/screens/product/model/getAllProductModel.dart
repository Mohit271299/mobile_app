// To parse this JSON data, do
//
//     final getAllSalesModel = getAllSalesModelFromJson(jsonString);

import 'dart:convert';

GetAllProductModel getAllPurchasesModelFromJson(String str) => GetAllProductModel.fromJson(json.decode(str));

String getAllProductModelToJson(GetAllProductModel data) => json.encode(data.toJson());

class GetAllProductModel {
  bool? success;
  List<Data_product>? data;

  GetAllProductModel({this.success, this.data});

  GetAllProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_product>[];
      json['data'].forEach((v) {
        data!.add(new Data_product.fromJson(v));
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

class Data_product {
  int? id;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? hsnCode;
  int? quantity;
  String? description;
  int? unit;
  int? purchasePrice;
  int? salesPrice;
  int? gstPurchase;
  int? gstSales;

  Data_product(
      {this.id,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.hsnCode,
        this.quantity,
        this.description,
        this.unit,
        this.purchasePrice,
        this.salesPrice,
        this.gstPurchase,
        this.gstSales});

  Data_product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    hsnCode = json['hsnCode'];
    quantity = json['quantity'];
    description = json['description'];
    unit = json['unit'];
    purchasePrice = json['purchasePrice'];
    salesPrice = json['salesPrice'];
    gstPurchase = json['gstPurchase'];
    gstSales = json['gstSales'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['hsnCode'] = this.hsnCode;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['unit'] = this.unit;
    data['purchasePrice'] = this.purchasePrice;
    data['salesPrice'] = this.salesPrice;
    data['gstPurchase'] = this.gstPurchase;
    data['gstSales'] = this.gstSales;
    return data;
  }
}
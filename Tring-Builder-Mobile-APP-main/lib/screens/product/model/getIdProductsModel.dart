class GetIdProdcutsModel {
  bool? success;
  Data? data;

  GetIdProdcutsModel({this.success, this.data});

  GetIdProdcutsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
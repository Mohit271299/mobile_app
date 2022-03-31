class product_list {
  bool? success;
  List<Data_product>? data;

  product_list({this.success, this.data});

  product_list.fromJson(Map<String, dynamic> json) {
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
  String? productName;
  String? description;
  String? sku;
  int? groupId;
  int? subGroupId;
  num? totalSales;
  int? salesQty;
  int? totalQty;
  String? hsnCode;
  int? productQuantityOnHand;
  String? productUnit;
  int? productLowStockAlert;
  String? productAsOfDate;
  int? purchasePrice;
  int? salesPrice;
  int? gstSales;
  int? gstPurchase;
  String? incomeAccount;
  String? expenseAccount;
  String? productCreatedDate;
  int? batchNo;
  String? expiryDate;
  int? companyProfileId;
  String? createdAt;
  String? updateAt;
  int? createdBy;
  Null? updateBy;

  Data_product(
      {this.id,
        this.productName,
        this.description,
        this.sku,
        this.groupId,
        this.subGroupId,
        this.totalSales,
        this.salesQty,
        this.totalQty,
        this.hsnCode,
        this.productQuantityOnHand,
        this.productUnit,
        this.productLowStockAlert,
        this.productAsOfDate,
        this.purchasePrice,
        this.salesPrice,
        this.gstSales,
        this.gstPurchase,
        this.incomeAccount,
        this.expenseAccount,
        this.productCreatedDate,
        this.batchNo,
        this.expiryDate,
        this.companyProfileId,
        this.createdAt,
        this.updateAt,
        this.createdBy,
        this.updateBy});

  Data_product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    description = json['description'];
    sku = json['sku'];
    groupId = json['group_id'];
    subGroupId = json['sub_group_id'];
    totalSales = json['total_sales'];
    salesQty = json['sales_qty'];
    totalQty = json['total_qty'];
    hsnCode = json['hsn_code'];
    productQuantityOnHand = json['product_quantity_on_hand'];
    productUnit = json['product_unit'];
    productLowStockAlert = json['product_low_stock_alert'];
    productAsOfDate = json['product_as_of_date'];
    purchasePrice = json['purchase_price'];
    salesPrice = json['sales_price'];
    gstSales = json['gst_sales'];
    gstPurchase = json['gst_purchase'];
    incomeAccount = json['income_account'];
    expenseAccount = json['expense_account'];
    productCreatedDate = json['product_created_date'];
    batchNo = json['batch_no'];
    expiryDate = json['expiry_date'];
    companyProfileId = json['company_profile_id'];
    createdAt = json['created_at'];
    updateAt = json['update_at'];
    createdBy = json['created_by'];
    updateBy = json['update_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['description'] = this.description;
    data['sku'] = this.sku;
    data['group_id'] = this.groupId;
    data['sub_group_id'] = this.subGroupId;
    data['total_sales'] = this.totalSales;
    data['sales_qty'] = this.salesQty;
    data['total_qty'] = this.totalQty;
    data['hsn_code'] = this.hsnCode;
    data['product_quantity_on_hand'] = this.productQuantityOnHand;
    data['product_unit'] = this.productUnit;
    data['product_low_stock_alert'] = this.productLowStockAlert;
    data['product_as_of_date'] = this.productAsOfDate;
    data['purchase_price'] = this.purchasePrice;
    data['sales_price'] = this.salesPrice;
    data['gst_sales'] = this.gstSales;
    data['gst_purchase'] = this.gstPurchase;
    data['income_account'] = this.incomeAccount;
    data['expense_account'] = this.expenseAccount;
    data['product_created_date'] = this.productCreatedDate;
    data['batch_no'] = this.batchNo;
    data['expiry_date'] = this.expiryDate;
    data['company_profile_id'] = this.companyProfileId;
    data['created_at'] = this.createdAt;
    data['update_at'] = this.updateAt;
    data['created_by'] = this.createdBy;
    data['update_by'] = this.updateBy;
    return data;
  }
}
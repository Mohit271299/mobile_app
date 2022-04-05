class GetAllPaymentModel {
  bool? success;
  List<Data_payment>? data;

  GetAllPaymentModel({this.success, this.data});

  GetAllPaymentModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_payment>[];
      json['data'].forEach((v) {
        data!.add(new Data_payment.fromJson(v));
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

class Data_payment {
  int? id;
  int? invoiceNumber;
  String? invoiceDate;
  String? contactName;
  String? mobileNo;
  int? flatId;
  String? blockNumber;
  int? totalAmount;
  Null? paidAmount;

  Data_payment(
      {this.id,
        this.invoiceNumber,
        this.invoiceDate,
        this.contactName,
        this.mobileNo,
        this.flatId,
        this.blockNumber,
        this.totalAmount,
        this.paidAmount});

  Data_payment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceNumber = json['invoiceNumber'];
    invoiceDate = json['invoiceDate'];
    contactName = json['contactName'];
    mobileNo = json['mobileNo'];
    flatId = json['flatId'];
    blockNumber = json['blockNumber'];
    totalAmount = json['totalAmount'];
    paidAmount = json['paidAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoiceNumber'] = this.invoiceNumber;
    data['invoiceDate'] = this.invoiceDate;
    data['contactName'] = this.contactName;
    data['mobileNo'] = this.mobileNo;
    data['flatId'] = this.flatId;
    data['blockNumber'] = this.blockNumber;
    data['totalAmount'] = this.totalAmount;
    data['paidAmount'] = this.paidAmount;
    return data;
  }
}
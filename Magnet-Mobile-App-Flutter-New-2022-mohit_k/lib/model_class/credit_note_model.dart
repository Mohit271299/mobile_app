class creditNoteList {
  bool? success;
  List<Data_credit_note>? data;

  creditNoteList({this.success, this.data});

  creditNoteList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data_credit_note>[];
      json['data'].forEach((v) {
        data!.add(new Data_credit_note.fromJson(v));
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

class Data_credit_note {
  int? id;
  String? creditNoteNumber;
  String? creditNoteDate;
  int? entityId;
  String? entityType;
  num? totalAmt;

  Data_credit_note(
      {this.id,
        this.creditNoteNumber,
        this.creditNoteDate,
        this.entityId,
        this.entityType,
        this.totalAmt});

  Data_credit_note.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creditNoteNumber = json['credit_note_number'];
    creditNoteDate = json['credit_note_date'];
    entityId = json['entity_id'];
    entityType = json['entity_type'];
    totalAmt = json['total_amt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['credit_note_number'] = this.creditNoteNumber;
    data['credit_note_date'] = this.creditNoteDate;
    data['entity_id'] = this.entityId;
    data['entity_type'] = this.entityType;
    data['total_amt'] = this.totalAmt;
    return data;
  }
}
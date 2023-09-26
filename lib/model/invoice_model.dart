class InvoiceModel {
  int? status;
  bool? error;
  int? openCount;
  int? totalAmount;
  List<OpenInvoices>? openInvoices;
  List<PaidInvoices>? paidInvoices;

  InvoiceModel(
      {this.status,
      this.error,
      this.openCount,
      this.totalAmount,
      this.openInvoices,
      this.paidInvoices});

  InvoiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    openCount = json['openCount'];
    totalAmount = json['totalAmount'];
    if (json['openInvoices'] != null) {
      openInvoices = <OpenInvoices>[];
      json['openInvoices'].forEach((v) {
        openInvoices!.add(new OpenInvoices.fromJson(v));
      });
    }
    if (json['paidInvoices'] != null) {
      paidInvoices = <PaidInvoices>[];
      json['paidInvoices'].forEach((v) {
        paidInvoices!.add(new PaidInvoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    data['openCount'] = this.openCount;
    data['totalAmount'] = this.totalAmount;
    if (this.openInvoices != null) {
      data['openInvoices'] = this.openInvoices!.map((v) => v.toJson()).toList();
    }
    if (this.paidInvoices != null) {
      data['paidInvoices'] = this.paidInvoices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OpenInvoices {
  String? id;
  String? amount;
  String? tax;
  String? discount;
  String? paid;
  String? createdDate;
  String? dueDate;
  String? orderNo;
  String? notes;

  OpenInvoices(
      {this.id,
      this.amount,
      this.tax,
      this.discount,
      this.paid,
      this.createdDate,
      this.dueDate,
      this.orderNo,
      this.notes});

  OpenInvoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    tax = json['tax'];
    discount = json['discount'];
    paid = json['paid'];
    createdDate = json['created_date'];
    dueDate = json['due_date'];
    orderNo = json['order_no'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['paid'] = this.paid;
    data['created_date'] = this.createdDate;
    data['due_date'] = this.dueDate;
    data['order_no'] = this.orderNo;
    data['notes'] = this.notes;
    return data;
  }
}

class PaidInvoices {
  String? id;
  String? amount;
  String? tax;
  String? discount;
  String? paid;
  String? createdDate;
  String? dueDate;
  String? orderNo;
  String? notes;

  PaidInvoices(
      {this.id,
      this.amount,
      this.tax,
      this.discount,
      this.paid,
      this.createdDate,
      this.dueDate,
      this.orderNo,
      this.notes});

  PaidInvoices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    tax = json['tax'];
    discount = json['discount'];
    paid = json['paid'];
    createdDate = json['created_date'];
    dueDate = json['due_date'];
    orderNo = json['order_no'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['amount'] = this.amount;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['paid'] = this.paid;
    data['created_date'] = this.createdDate;
    data['due_date'] = this.dueDate;
    data['order_no'] = this.orderNo;
    data['notes'] = this.notes;
    return data;
  }
}

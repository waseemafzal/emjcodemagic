class ContactUsModel {
  int? status;
  bool? error;
  List<Pending>? pending;
  List<Closed>? closed;

  ContactUsModel({this.status, this.error, this.pending, this.closed});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    if (json['pending'] != null) {
      pending = <Pending>[];
      json['pending'].forEach((v) {
        pending!.add(new Pending.fromJson(v));
      });
    }
    if (json['closed'] != null) {
      closed = <Closed>[];
      json['closed'].forEach((v) {
        closed!.add(new Closed.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    if (this.pending != null) {
      data['pending'] = this.pending!.map((v) => v.toJson()).toList();
    }
    if (this.closed != null) {
      data['closed'] = this.closed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pending {
  String? id;
  String? userId;
  String? message;
  String? createdDate;
  String? ticketNo;
  String? status;

  Pending(
      {this.id,
      this.userId,
      this.message,
      this.createdDate,
      this.ticketNo,
      this.status});

  Pending.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    message = json['message'];
    createdDate = json['created_date'];
    ticketNo = json['ticket_no'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['message'] = this.message;
    data['created_date'] = this.createdDate;
    data['ticket_no'] = this.ticketNo;
    data['status'] = this.status;
    return data;
  }
}

class Closed {
  String? id;
  String? userId;
  String? message;
  String? createdDate;
  String? ticketNo;
  String? status;

  Closed(
      {this.id,
      this.userId,
      this.message,
      this.createdDate,
      this.ticketNo,
      this.status});

  Closed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    message = json['message'];
    createdDate = json['created_date'];
    ticketNo = json['ticket_no'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['message'] = this.message;
    data['created_date'] = this.createdDate;
    data['ticket_no'] = this.ticketNo;
    data['status'] = this.status;
    return data;
  }
}

class ChatModel {
  int? status;
  bool? error;
  List<Data>? data;

  ChatModel({this.status, this.error, this.data});

  ChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['error'] = this.error;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? senderId;
  String? message;
  String? createdDate;
  String? helpcenterId;
  int? mymessage;

  Data(
      {this.id,
      this.senderId,
      this.message,
      this.createdDate,
      this.helpcenterId,
      this.mymessage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    senderId = json['sender_id'];
    message = json['message'];
    createdDate = json['created_date'];
    helpcenterId = json['helpcenter_id'];
    mymessage = json['mymessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sender_id'] = this.senderId;
    data['message'] = this.message;
    data['created_date'] = this.createdDate;
    data['helpcenter_id'] = this.helpcenterId;
    data['mymessage'] = this.mymessage;
    return data;
  }
}

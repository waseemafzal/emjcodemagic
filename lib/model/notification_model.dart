class NotificationModel {
  int? status;
  bool? error;
  List<Data>? data;

  NotificationModel({this.status, this.error, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
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
  String? body;
  String? resourceId;
  String? resourceType;
  String? createdDate;
  String? readed;

  Data(
      {this.body,
      this.resourceId,
      this.resourceType,
      this.createdDate,
      this.readed});

  Data.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    resourceId = json['resource_id'];
    resourceType = json['resource_type'];
    createdDate = json['created_date'];
    readed = json['readed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['resource_id'] = this.resourceId;
    data['resource_type'] = this.resourceType;
    data['created_date'] = this.createdDate;
    data['readed'] = this.readed;
    return data;
  }
}

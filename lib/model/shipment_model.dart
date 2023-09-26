class ShipmentModel {
  int? status;
  bool? error;
  List<Data>? data;

  ShipmentModel({this.status, this.error, this.data});

  ShipmentModel.fromJson(Map<String, dynamic> json) {
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
  String? shipmentType;
  String? shipmentStatus;
  String? shipmentFrom;
  String? shipmentTo;
  String? itemDescription;
  String? consigneeName;
  String? consigneePhone;
  String? shipmentDate;
  String? trackNumber;

  Data(
      {this.shipmentType,
      this.shipmentStatus,
      this.shipmentFrom,
      this.shipmentTo,
      this.itemDescription,
      this.consigneeName,
      this.consigneePhone,
      this.shipmentDate,
      this.trackNumber});

  Data.fromJson(Map<String, dynamic> json) {
    shipmentType = json['shipmentType'];
    shipmentStatus = json['shipmentStatus'];
    shipmentFrom = json['shipmentFrom'];
    shipmentTo = json['shipmentTo'];
    itemDescription = json['item_description'];
    consigneeName = json['consignee_name'];
    consigneePhone = json['consignee_phone'];
    shipmentDate = json['shipment_date'];
    trackNumber = json['track_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipmentType'] = this.shipmentType;
    data['shipmentStatus'] = this.shipmentStatus;
    data['shipmentFrom'] = this.shipmentFrom;
    data['shipmentTo'] = this.shipmentTo;
    data['item_description'] = this.itemDescription;
    data['consignee_name'] = this.consigneeName;
    data['consignee_phone'] = this.consigneePhone;
    data['shipment_date'] = this.shipmentDate;
    data['track_number'] = this.trackNumber;
    return data;
  }
}

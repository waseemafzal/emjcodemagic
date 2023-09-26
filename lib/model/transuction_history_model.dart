class TransuctionHistroyModel {
  int? status;
  bool? error;
  List<Data>? data;

  TransuctionHistroyModel({this.status, this.error, this.data});

  TransuctionHistroyModel.fromJson(Map<String, dynamic> json) {
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
  String? arrivalDate;
  String? departureDate;
  String? consigneeName;
  String? consigneeAddress;
  String? amount;
  String? trackNumber;
  String? shipmentFrom;
  String? shipmentTo;
  String? trnasitTime;
  String? qrImage;

  Data(
      {this.arrivalDate,
      this.departureDate,
      this.consigneeName,
      this.consigneeAddress,
      this.amount,
      this.trackNumber,
      this.shipmentFrom,
      this.shipmentTo,
      this.trnasitTime,
      this.qrImage});

  Data.fromJson(Map<String, dynamic> json) {
    arrivalDate = json['arrival_date'];
    departureDate = json['departure_date'];
    consigneeName = json['consignee_name'];
    consigneeAddress = json['consignee_address'];
    amount = json['amount'];
    trackNumber = json['track_number'];
    shipmentFrom = json['shipment_from'];
    shipmentTo = json['shipment_to'];
    trnasitTime = json['trnasit_time'];
    qrImage = json['qr_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arrival_date'] = this.arrivalDate;
    data['departure_date'] = this.departureDate;
    data['consignee_name'] = this.consigneeName;
    data['consignee_address'] = this.consigneeAddress;
    data['amount'] = this.amount;
    data['track_number'] = this.trackNumber;
    data['shipment_from'] = this.shipmentFrom;
    data['shipment_to'] = this.shipmentTo;
    data['trnasit_time'] = this.trnasitTime;
    data['qr_image'] = this.qrImage;
    return data;
  }
}

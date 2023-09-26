class MyShipmentModel {
  int? status;
  bool? error;
  List<Data>? data;

  MyShipmentModel({this.status, this.error, this.data});

  MyShipmentModel.fromJson(Map<String, dynamic> json) {
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
  String? shipmentId;
  String? expectedDate;
  String? shippingDate;
  String? noOfBoxes;
  List<Boxes>? boxes;

  Data(
      {this.shipmentId,
      this.expectedDate,
      this.shippingDate,
      this.noOfBoxes,
      this.boxes});

  Data.fromJson(Map<String, dynamic> json) {
    shipmentId = json['shipment_id'];
    expectedDate = json['expected_date'];
    shippingDate = json['shipping_date'];
    noOfBoxes = json['no_of_boxes'];
    if (json['boxes'] != null) {
      boxes = <Boxes>[];
      json['boxes'].forEach((v) {
        boxes!.add(new Boxes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shipment_id'] = this.shipmentId;
    data['expected_date'] = this.expectedDate;
    data['shipping_date'] = this.shippingDate;
    data['no_of_boxes'] = this.noOfBoxes;
    if (this.boxes != null) {
      data['boxes'] = this.boxes!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Boxes {
  String? id;
  String? customerId;
  String? binId;
  String? boxNo;
  String? dimension;
  String? length;
  String? height;
  String? width;
  String? weight;
  String? dimensionalWeight;
  String? cubicFeet;
  String? rate;
  String? itemId;
  String? shipmentId;
  String? createdDate;
  List<Items>? items;

  Boxes(
      {this.id,
      this.customerId,
      this.binId,
      this.boxNo,
      this.dimension,
      this.length,
      this.height,
      this.width,
      this.weight,
      this.dimensionalWeight,
      this.cubicFeet,
      this.rate,
      this.itemId,
      this.shipmentId,
      this.createdDate,
      this.items});

  Boxes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerId = json['customer_id'];
    binId = json['bin_id'];
    boxNo = json['box_no'];
    dimension = json['dimension'];
    length = json['length'];
    height = json['height'];
    width = json['width'];
    weight = json['weight'];
    dimensionalWeight = json['dimensional_weight'];
    cubicFeet = json['cubic_feet'];
    rate = json['rate'];
    itemId = json['item_id'];
    shipmentId = json['shipment_id'];
    createdDate = json['created_date'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_id'] = this.customerId;
    data['bin_id'] = this.binId;
    data['box_no'] = this.boxNo;
    data['dimension'] = this.dimension;
    data['length'] = this.length;
    data['height'] = this.height;
    data['width'] = this.width;
    data['weight'] = this.weight;
    data['dimensional_weight'] = this.dimensionalWeight;
    data['cubic_feet'] = this.cubicFeet;
    data['rate'] = this.rate;
    data['item_id'] = this.itemId;
    data['shipment_id'] = this.shipmentId;
    data['created_date'] = this.createdDate;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? id;
  String? shopOrdersId;
  String? itemTitle;
  String? quantity;
  String? price;
  String? amount;
  String? status;
  String? spInstruction;
  String? insurance;

  Items(
      {this.id,
      this.shopOrdersId,
      this.itemTitle,
      this.quantity,
      this.price,
      this.amount,
      this.status,
      this.spInstruction,
      this.insurance});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shopOrdersId = json['shop_orders_id'];
    itemTitle = json['item_title'];
    quantity = json['quantity'];
    price = json['price'];
    amount = json['amount'];
    status = json['status'];
    spInstruction = json['sp_instruction'];
    insurance = json['insurance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shop_orders_id'] = this.shopOrdersId;
    data['item_title'] = this.itemTitle;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['status'] = this.status;
    data['sp_instruction'] = this.spInstruction;
    data['insurance'] = this.insurance;
    return data;
  }
}

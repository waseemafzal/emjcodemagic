class MyOrderModel {
  int? status;
  bool? error;
  List<Pending>? pending;
  List<Received>? received;
  List<Onhold>? onhold;
  List<Shipped>? shipped;
  List<Refused>? refused;
  List<Missing>? missing;
  List<Packed>? packed;
  List<PartialReceived>? partialReceived;

  MyOrderModel(
      {this.status,
      this.error,
      this.pending,
      this.received,
      this.onhold,
      this.shipped,
      this.refused,
      this.missing,
      this.packed,
      this.partialReceived});

  MyOrderModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    error = json['error'];
    if (json['pending'] != null) {
      pending = <Pending>[];
      json['pending'].forEach((v) {
        pending!.add(new Pending.fromJson(v));
      });
    }
    if (json['received'] != null) {
      received = <Received>[];
      json['received'].forEach((v) {
        received!.add(new Received.fromJson(v));
      });
    }
    if (json['onhold'] != null) {
      onhold = <Onhold>[];
      json['onhold'].forEach((v) {
        onhold!.add(new Onhold.fromJson(v));
      });
    }
    if (json['shipped'] != null) {
      shipped = <Shipped>[];
      json['shipped'].forEach((v) {
        shipped!.add(new Shipped.fromJson(v));
      });
    }
    if (json['refused'] != null) {
      refused = <Refused>[];
      json['refused'].forEach((v) {
        refused!.add(new Refused.fromJson(v));
      });
    }
    if (json['missing'] != null) {
      missing = <Missing>[];
      json['missing'].forEach((v) {
        missing!.add(new Missing.fromJson(v));
      });
    }
    if (json['packed'] != null) {
      packed = <Packed>[];
      json['packed'].forEach((v) {
        packed!.add(new Packed.fromJson(v));
      });
    }
    if (json['partial_received'] != null) {
      partialReceived = <PartialReceived>[];
      json['partial_received'].forEach((v) {
        partialReceived!.add(new PartialReceived.fromJson(v));
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
    if (this.received != null) {
      data['received'] = this.received!.map((v) => v.toJson()).toList();
    }
    if (this.onhold != null) {
      data['onhold'] = this.onhold!.map((v) => v.toJson()).toList();
    }
    if (this.shipped != null) {
      data['shipped'] = this.shipped!.map((v) => v.toJson()).toList();
    }
    if (this.refused != null) {
      data['refused'] = this.refused!.map((v) => v.toJson()).toList();
    }
    if (this.missing != null) {
      data['missing'] = this.missing!.map((v) => v.toJson()).toList();
    }
    if (this.packed != null) {
      data['packed'] = this.packed!.map((v) => v.toJson()).toList();
    }
    if (this.partialReceived != null) {
      data['partial_received'] =
          this.partialReceived!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Pending {
  String? id;
  String? storeId;
  String? trackingNo;
  String? userId;
  String? createdOn;
  String? status;
  String? type;
  String? customerName;
  String? address;
  String? mobile;
  String? image;
  String? binId;
  String? countryId;
  String? stateId;
  String? cityId;
  String? zipcode;
  String? remarks;
  String? storeName;
  List<Products>? products;

  Pending(
      {this.id,
      this.storeId,
      this.trackingNo,
      this.userId,
      this.createdOn,
      this.status,
      this.type,
      this.customerName,
      this.address,
      this.mobile,
      this.image,
      this.binId,
      this.countryId,
      this.stateId,
      this.cityId,
      this.zipcode,
      this.remarks,
      this.storeName,
      this.products});

  Pending.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    trackingNo = json['tracking_no'];
    userId = json['user_id'];
    createdOn = json['created_on'];
    status = json['status'];
    type = json['type'];
    customerName = json['customer_name'];
    address = json['address'];
    mobile = json['mobile'];
    image = json['image'];
    binId = json['bin_id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zipcode = json['zipcode'];
    remarks = json['remarks'];
    storeName = json['store_name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['tracking_no'] = this.trackingNo;
    data['user_id'] = this.userId;
    data['created_on'] = this.createdOn;
    data['status'] = this.status;
    data['type'] = this.type;
    data['customer_name'] = this.customerName;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['bin_id'] = this.binId;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zipcode'] = this.zipcode;
    data['remarks'] = this.remarks;
    data['store_name'] = this.storeName;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? id;
  String? shopOrdersId;
  String? itemTitle;
  String? quantity;
  String? price;
  String? amount;
  String? status;
  String? spInstruction;
  String? insurance;

  Products({
    this.id,
    this.shopOrdersId,
    this.itemTitle,
    this.quantity,
    this.price,
    this.amount,
    this.status,
    this.spInstruction,
    this.insurance,
  });

  Products.fromJson(Map<String, dynamic> json) {
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

class Received {
  String? id;
  String? storeId;
  String? trackingNo;
  String? userId;
  String? createdOn;
  String? status;
  String? type;
  String? customerName;
  String? address;
  String? mobile;
  String? image;
  String? binId;
  String? countryId;
  String? stateId;
  String? cityId;
  String? zipcode;
  String? remarks;
  String? storeName;
  List<Products>? products;

  Received(
      {this.id,
      this.storeId,
      this.trackingNo,
      this.userId,
      this.createdOn,
      this.status,
      this.type,
      this.customerName,
      this.address,
      this.mobile,
      this.image,
      this.binId,
      this.countryId,
      this.stateId,
      this.cityId,
      this.zipcode,
      this.remarks,
      this.storeName,
      this.products});

  Received.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    trackingNo = json['tracking_no'];
    userId = json['user_id'];
    createdOn = json['created_on'];
    status = json['status'];
    type = json['type'];
    customerName = json['customer_name'];
    address = json['address'];
    mobile = json['mobile'];
    image = json['image'];
    binId = json['bin_id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zipcode = json['zipcode'];
    remarks = json['remarks'];
    storeName = json['store_name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['tracking_no'] = this.trackingNo;
    data['user_id'] = this.userId;
    data['created_on'] = this.createdOn;
    data['status'] = this.status;
    data['type'] = this.type;
    data['customer_name'] = this.customerName;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['bin_id'] = this.binId;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zipcode'] = this.zipcode;
    data['remarks'] = this.remarks;
    data['store_name'] = this.storeName;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Onhold {
  String? id;
  String? storeId;
  String? trackingNo;
  String? userId;
  String? createdOn;
  String? status;
  String? type;
  String? customerName;
  String? address;
  String? mobile;
  String? image;
  String? binId;
  String? countryId;
  String? stateId;
  String? cityId;
  String? zipcode;
  String? remarks;
  String? storeName;
  List<Products>? products;

  Onhold(
      {this.id,
      this.storeId,
      this.trackingNo,
      this.userId,
      this.createdOn,
      this.status,
      this.type,
      this.customerName,
      this.address,
      this.mobile,
      this.image,
      this.binId,
      this.countryId,
      this.stateId,
      this.cityId,
      this.zipcode,
      this.remarks,
      this.storeName,
      this.products});

  Onhold.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    trackingNo = json['tracking_no'];
    userId = json['user_id'];
    createdOn = json['created_on'];
    status = json['status'];
    type = json['type'];
    customerName = json['customer_name'];
    address = json['address'];
    mobile = json['mobile'];
    image = json['image'];
    binId = json['bin_id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zipcode = json['zipcode'];
    remarks = json['remarks'];
    storeName = json['store_name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['tracking_no'] = this.trackingNo;
    data['user_id'] = this.userId;
    data['created_on'] = this.createdOn;
    data['status'] = this.status;
    data['type'] = this.type;
    data['customer_name'] = this.customerName;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['bin_id'] = this.binId;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zipcode'] = this.zipcode;
    data['remarks'] = this.remarks;
    data['store_name'] = this.storeName;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shipped {
  String? id;
  String? storeId;
  String? trackingNo;
  String? userId;
  String? createdOn;
  String? status;
  String? type;
  String? customerName;
  String? address;
  String? mobile;
  String? image;
  String? binId;
  String? countryId;
  String? stateId;
  String? cityId;
  String? zipcode;
  String? remarks;
  String? storeName;
  List<Products>? products;

  Shipped(
      {this.id,
      this.storeId,
      this.trackingNo,
      this.userId,
      this.createdOn,
      this.status,
      this.type,
      this.customerName,
      this.address,
      this.mobile,
      this.image,
      this.binId,
      this.countryId,
      this.stateId,
      this.cityId,
      this.zipcode,
      this.remarks,
      this.storeName,
      this.products});

  Shipped.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    trackingNo = json['tracking_no'];
    userId = json['user_id'];
    createdOn = json['created_on'];
    status = json['status'];
    type = json['type'];
    customerName = json['customer_name'];
    address = json['address'];
    mobile = json['mobile'];
    image = json['image'];
    binId = json['bin_id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zipcode = json['zipcode'];
    remarks = json['remarks'];
    storeName = json['store_name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['tracking_no'] = this.trackingNo;
    data['user_id'] = this.userId;
    data['created_on'] = this.createdOn;
    data['status'] = this.status;
    data['type'] = this.type;
    data['customer_name'] = this.customerName;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['bin_id'] = this.binId;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zipcode'] = this.zipcode;
    data['remarks'] = this.remarks;
    data['store_name'] = this.storeName;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Refused {
  String? id;
  String? storeId;
  String? trackingNo;
  String? userId;
  String? createdOn;
  String? status;
  String? type;
  String? customerName;
  String? address;
  String? mobile;
  String? image;
  String? binId;
  String? countryId;
  String? stateId;
  String? cityId;
  String? zipcode;
  String? remarks;
  String? storeName;
  List<Products>? products;

  Refused(
      {this.id,
      this.storeId,
      this.trackingNo,
      this.userId,
      this.createdOn,
      this.status,
      this.type,
      this.customerName,
      this.address,
      this.mobile,
      this.image,
      this.binId,
      this.countryId,
      this.stateId,
      this.cityId,
      this.zipcode,
      this.remarks,
      this.storeName,
      this.products});

  Refused.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    trackingNo = json['tracking_no'];
    userId = json['user_id'];
    createdOn = json['created_on'];
    status = json['status'];
    type = json['type'];
    customerName = json['customer_name'];
    address = json['address'];
    mobile = json['mobile'];
    image = json['image'];
    binId = json['bin_id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zipcode = json['zipcode'];
    remarks = json['remarks'];
    storeName = json['store_name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['tracking_no'] = this.trackingNo;
    data['user_id'] = this.userId;
    data['created_on'] = this.createdOn;
    data['status'] = this.status;
    data['type'] = this.type;
    data['customer_name'] = this.customerName;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['bin_id'] = this.binId;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zipcode'] = this.zipcode;
    data['remarks'] = this.remarks;
    data['store_name'] = this.storeName;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Missing {
  String? id;
  String? storeId;
  String? trackingNo;
  String? userId;
  String? createdOn;
  String? status;
  String? type;
  String? customerName;
  String? address;
  String? mobile;
  String? image;
  String? binId;
  String? countryId;
  String? stateId;
  String? cityId;
  String? zipcode;
  String? remarks;
  String? storeName;
  List<Products>? products;

  Missing(
      {this.id,
      this.storeId,
      this.trackingNo,
      this.userId,
      this.createdOn,
      this.status,
      this.type,
      this.customerName,
      this.address,
      this.mobile,
      this.image,
      this.binId,
      this.countryId,
      this.stateId,
      this.cityId,
      this.zipcode,
      this.remarks,
      this.storeName,
      this.products});

  Missing.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    trackingNo = json['tracking_no'];
    userId = json['user_id'];
    createdOn = json['created_on'];
    status = json['status'];
    type = json['type'];
    customerName = json['customer_name'];
    address = json['address'];
    mobile = json['mobile'];
    image = json['image'];
    binId = json['bin_id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zipcode = json['zipcode'];
    remarks = json['remarks'];
    storeName = json['store_name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['tracking_no'] = this.trackingNo;
    data['user_id'] = this.userId;
    data['created_on'] = this.createdOn;
    data['status'] = this.status;
    data['type'] = this.type;
    data['customer_name'] = this.customerName;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['bin_id'] = this.binId;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zipcode'] = this.zipcode;
    data['remarks'] = this.remarks;
    data['store_name'] = this.storeName;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Packed {
  String? id;
  String? storeId;
  String? trackingNo;
  String? userId;
  String? createdOn;
  String? status;
  String? type;
  String? customerName;
  String? address;
  String? mobile;
  String? image;
  String? binId;
  String? countryId;
  String? stateId;
  String? cityId;
  String? zipcode;
  String? remarks;
  String? storeName;
  List<Products>? products;

  Packed(
      {this.id,
      this.storeId,
      this.trackingNo,
      this.userId,
      this.createdOn,
      this.status,
      this.type,
      this.customerName,
      this.address,
      this.mobile,
      this.image,
      this.binId,
      this.countryId,
      this.stateId,
      this.cityId,
      this.zipcode,
      this.remarks,
      this.storeName,
      this.products});

  Packed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    trackingNo = json['tracking_no'];
    userId = json['user_id'];
    createdOn = json['created_on'];
    status = json['status'];
    type = json['type'];
    customerName = json['customer_name'];
    address = json['address'];
    mobile = json['mobile'];
    image = json['image'];
    binId = json['bin_id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zipcode = json['zipcode'];
    remarks = json['remarks'];
    storeName = json['store_name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['tracking_no'] = this.trackingNo;
    data['user_id'] = this.userId;
    data['created_on'] = this.createdOn;
    data['status'] = this.status;
    data['type'] = this.type;
    data['customer_name'] = this.customerName;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['bin_id'] = this.binId;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zipcode'] = this.zipcode;
    data['remarks'] = this.remarks;
    data['store_name'] = this.storeName;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PartialReceived {
  String? id;
  String? storeId;
  String? trackingNo;
  String? userId;
  String? createdOn;
  String? status;
  String? type;
  String? customerName;
  String? address;
  String? mobile;
  String? image;
  String? binId;
  String? countryId;
  String? stateId;
  String? cityId;
  String? zipcode;
  String? remarks;
  String? storeName;
  List<Products>? products;

  PartialReceived(
      {this.id,
      this.storeId,
      this.trackingNo,
      this.userId,
      this.createdOn,
      this.status,
      this.type,
      this.customerName,
      this.address,
      this.mobile,
      this.image,
      this.binId,
      this.countryId,
      this.stateId,
      this.cityId,
      this.zipcode,
      this.remarks,
      this.storeName,
      this.products});

  PartialReceived.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    trackingNo = json['tracking_no'];
    userId = json['user_id'];
    createdOn = json['created_on'];
    status = json['status'];
    type = json['type'];
    customerName = json['customer_name'];
    address = json['address'];
    mobile = json['mobile'];
    image = json['image'];
    binId = json['bin_id'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    zipcode = json['zipcode'];
    remarks = json['remarks'];
    storeName = json['store_name'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_id'] = this.storeId;
    data['tracking_no'] = this.trackingNo;
    data['user_id'] = this.userId;
    data['created_on'] = this.createdOn;
    data['status'] = this.status;
    data['type'] = this.type;
    data['customer_name'] = this.customerName;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['image'] = this.image;
    data['bin_id'] = this.binId;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['zipcode'] = this.zipcode;
    data['remarks'] = this.remarks;
    data['store_name'] = this.storeName;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

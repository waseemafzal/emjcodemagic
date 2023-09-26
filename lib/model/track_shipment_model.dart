class TrackShipmentModel {
  int? status;
  bool? error;
  List<Data>? data;

  TrackShipmentModel({this.status, this.error, this.data});

  TrackShipmentModel.fromJson(Map<String, dynamic> json) {
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
  String? shipmentType;
  String? shipperName;
  String? shipperPhone;
  String? shipperAddress;
  String? shipperCountry;
  String? shipperState;
  String? shipperCity;
  String? requestPickup;
  String? pickupLocation;
  String? requestInsurance;
  String? deliveryType;
  String? consigneeName;
  String? consigneeAddress;
  String? consigneePhone;
  String? itemDescription;
  String? consigneeCountry;
  String? consigneeState;
  String? consigneeCity;
  String? quantity;
  String? length;
  String? width;
  String? height;
  String? packageWeight;
  String? carriageValue;
  String? shipmentFrom;
  String? shipmentTo;
  String? shipmentDate;
  String? trackNumber;
  String? userId;
  String? shipmentStatus;
  String? shipmentName;
  String? landingBillNo;
  String? bookingNo;
  String? executedPlace;
  String? executedBy;
  String? executedDate;
  String? departureDate;
  String? departureTime;
  String? arrivalDate;
  String? arrivalTime;
  String? declaredValue;
  String? descriptionOfGoods;
  String? ultimateConsignee;
  String? ultimateConsigneeAddress;
  String? notifyParty;
  String? intermediate;
  String? notifyPartyAddress;
  String? intermediateAddress;
  String? forwordingAgent;
  String? destinationAgent;
  String? forwordingAgentAddress;
  String? destinationAgentAddress;
  String? serviceType;
  String? route;
  String? modeOfTransport;
  String? portOfOrigin;
  String? preCarriageBy;
  String? placeOfReceipt;
  String? loadingPier;
  String? portOfLoading;
  String? exportingCarrier;
  String? vesselName;
  String? voyageIdentification;
  String? portOfUnloading;
  String? onCarriageBy;
  String? placeOfDelivery;

  Data(
      {this.id,
      this.shipmentType,
      this.shipperName,
      this.shipperPhone,
      this.shipperAddress,
      this.shipperCountry,
      this.shipperState,
      this.shipperCity,
      this.requestPickup,
      this.pickupLocation,
      this.requestInsurance,
      this.deliveryType,
      this.consigneeName,
      this.consigneeAddress,
      this.consigneePhone,
      this.itemDescription,
      this.consigneeCountry,
      this.consigneeState,
      this.consigneeCity,
      this.quantity,
      this.length,
      this.width,
      this.height,
      this.packageWeight,
      this.carriageValue,
      this.shipmentFrom,
      this.shipmentTo,
      this.shipmentDate,
      this.trackNumber,
      this.userId,
      this.shipmentStatus,
      this.shipmentName,
      this.landingBillNo,
      this.bookingNo,
      this.executedPlace,
      this.executedBy,
      this.executedDate,
      this.departureDate,
      this.departureTime,
      this.arrivalDate,
      this.arrivalTime,
      this.declaredValue,
      this.descriptionOfGoods,
      this.ultimateConsignee,
      this.ultimateConsigneeAddress,
      this.notifyParty,
      this.intermediate,
      this.notifyPartyAddress,
      this.intermediateAddress,
      this.forwordingAgent,
      this.destinationAgent,
      this.forwordingAgentAddress,
      this.destinationAgentAddress,
      this.serviceType,
      this.route,
      this.modeOfTransport,
      this.portOfOrigin,
      this.preCarriageBy,
      this.placeOfReceipt,
      this.loadingPier,
      this.portOfLoading,
      this.exportingCarrier,
      this.vesselName,
      this.voyageIdentification,
      this.portOfUnloading,
      this.onCarriageBy,
      this.placeOfDelivery});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shipmentType = json['shipment_type'];
    shipperName = json['shipper_name'];
    shipperPhone = json['shipper_phone'];
    shipperAddress = json['shipper_address'];
    shipperCountry = json['shipper_country'];
    shipperState = json['shipper_state'];
    shipperCity = json['shipper_city'];
    requestPickup = json['request_pickup'];
    pickupLocation = json['pickup_location'];
    requestInsurance = json['request_insurance'];
    deliveryType = json['delivery_type'];
    consigneeName = json['consignee_name'];
    consigneeAddress = json['consignee_address'];
    consigneePhone = json['consignee_phone'];
    itemDescription = json['item_description'];
    consigneeCountry = json['consignee_country'];
    consigneeState = json['consignee_state'];
    consigneeCity = json['consignee_city'];
    quantity = json['quantity'];
    length = json['length'];
    width = json['width'];
    height = json['height'];
    packageWeight = json['package_weight'];
    carriageValue = json['carriage_value'];
    shipmentFrom = json['shipment_from'];
    shipmentTo = json['shipment_to'];
    shipmentDate = json['shipment_date'];
    trackNumber = json['track_number'];
    userId = json['user_id'];
    shipmentStatus = json['shipment_status'];
    shipmentName = json['shipment_name'];
    landingBillNo = json['landing_bill_no'];
    bookingNo = json['booking_no'];
    executedPlace = json['executed_place'];
    executedBy = json['executed_by'];
    executedDate = json['executed_date'];
    departureDate = json['departure_date'];
    departureTime = json['departure_time'];
    arrivalDate = json['arrival_date'];
    arrivalTime = json['arrival_time'];
    declaredValue = json['declared_value'];
    descriptionOfGoods = json['description_of_goods'];
    ultimateConsignee = json['ultimate_consignee'];
    ultimateConsigneeAddress = json['ultimate_consignee_address'];
    notifyParty = json['notify_party'];
    intermediate = json['intermediate'];
    notifyPartyAddress = json['notify_party_address'];
    intermediateAddress = json['intermediate_address'];
    forwordingAgent = json['forwording_agent'];
    destinationAgent = json['destination_agent'];
    forwordingAgentAddress = json['forwording_agent_address'];
    destinationAgentAddress = json['destination_agent_address'];
    serviceType = json['service_type'];
    route = json['route'];
    modeOfTransport = json['mode_of_transport'];
    portOfOrigin = json['port_of_origin'];
    preCarriageBy = json['pre_carriage_by'];
    placeOfReceipt = json['place_of_receipt'];
    loadingPier = json['loading_pier'];
    portOfLoading = json['port_of_loading'];
    exportingCarrier = json['exporting_carrier'];
    vesselName = json['vessel_name'];
    voyageIdentification = json['voyage_identification'];
    portOfUnloading = json['port_of_unloading'];
    onCarriageBy = json['on_carriage_by'];
    placeOfDelivery = json['place_of_delivery'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['shipment_type'] = this.shipmentType;
    data['shipper_name'] = this.shipperName;
    data['shipper_phone'] = this.shipperPhone;
    data['shipper_address'] = this.shipperAddress;
    data['shipper_country'] = this.shipperCountry;
    data['shipper_state'] = this.shipperState;
    data['shipper_city'] = this.shipperCity;
    data['request_pickup'] = this.requestPickup;
    data['pickup_location'] = this.pickupLocation;
    data['request_insurance'] = this.requestInsurance;
    data['delivery_type'] = this.deliveryType;
    data['consignee_name'] = this.consigneeName;
    data['consignee_address'] = this.consigneeAddress;
    data['consignee_phone'] = this.consigneePhone;
    data['item_description'] = this.itemDescription;
    data['consignee_country'] = this.consigneeCountry;
    data['consignee_state'] = this.consigneeState;
    data['consignee_city'] = this.consigneeCity;
    data['quantity'] = this.quantity;
    data['length'] = this.length;
    data['width'] = this.width;
    data['height'] = this.height;
    data['package_weight'] = this.packageWeight;
    data['carriage_value'] = this.carriageValue;
    data['shipment_from'] = this.shipmentFrom;
    data['shipment_to'] = this.shipmentTo;
    data['shipment_date'] = this.shipmentDate;
    data['track_number'] = this.trackNumber;
    data['user_id'] = this.userId;
    data['shipment_status'] = this.shipmentStatus;
    data['shipment_name'] = this.shipmentName;
    data['landing_bill_no'] = this.landingBillNo;
    data['booking_no'] = this.bookingNo;
    data['executed_place'] = this.executedPlace;
    data['executed_by'] = this.executedBy;
    data['executed_date'] = this.executedDate;
    data['departure_date'] = this.departureDate;
    data['departure_time'] = this.departureTime;
    data['arrival_date'] = this.arrivalDate;
    data['arrival_time'] = this.arrivalTime;
    data['declared_value'] = this.declaredValue;
    data['description_of_goods'] = this.descriptionOfGoods;
    data['ultimate_consignee'] = this.ultimateConsignee;
    data['ultimate_consignee_address'] = this.ultimateConsigneeAddress;
    data['notify_party'] = this.notifyParty;
    data['intermediate'] = this.intermediate;
    data['notify_party_address'] = this.notifyPartyAddress;
    data['intermediate_address'] = this.intermediateAddress;
    data['forwording_agent'] = this.forwordingAgent;
    data['destination_agent'] = this.destinationAgent;
    data['forwording_agent_address'] = this.forwordingAgentAddress;
    data['destination_agent_address'] = this.destinationAgentAddress;
    data['service_type'] = this.serviceType;
    data['route'] = this.route;
    data['mode_of_transport'] = this.modeOfTransport;
    data['port_of_origin'] = this.portOfOrigin;
    data['pre_carriage_by'] = this.preCarriageBy;
    data['place_of_receipt'] = this.placeOfReceipt;
    data['loading_pier'] = this.loadingPier;
    data['port_of_loading'] = this.portOfLoading;
    data['exporting_carrier'] = this.exportingCarrier;
    data['vessel_name'] = this.vesselName;
    data['voyage_identification'] = this.voyageIdentification;
    data['port_of_unloading'] = this.portOfUnloading;
    data['on_carriage_by'] = this.onCarriageBy;
    data['place_of_delivery'] = this.placeOfDelivery;
    return data;
  }
}

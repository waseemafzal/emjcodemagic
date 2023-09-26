import 'dart:io';

import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/shippment_order_controller.dart';
import 'package:emjay_global/view/widgets/my_custom_button.dart';
import 'package:emjay_global/view/widgets/my_custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalculatePackageRate extends StatefulWidget {
  final String shipmentType;
  final String shipperName;
  final String shipperAddress;
  final String shipperphoneNo;
  final String shipmentFrom;
  final String shippercountryId;
  final String shipperstateId;
  final String shippercityId;
  final String shipperrequestToPick;
  final String shipperpickLocation;
  final String shipperrequestInsurance;
  final String shipperdelieryType;
  final File? productImage;
  final String consigneeName;
  final String consigneeAddress;
  final String consigneePhone;
  final String shipmentTo;
  final String consigneeCountryId;
  final String consigneeStateId;
  final String consigneeCityId;
  final String quantity;
  final String description;
  final String length;
  final String width;
  final String height;
  final String packageSize;
  final String packageImage;
  CalculatePackageRate({
    required this.shipmentType,
    required this.shipperName,
    required this.shipperAddress,
    required this.shipperphoneNo,
    required this.shipmentFrom,
    required this.shippercountryId,
    required this.shipperstateId,
    required this.shippercityId,
    required this.shipperrequestToPick,
    required this.shipperrequestInsurance,
    required this.shipperpickLocation,
    required this.shipperdelieryType,
    required this.productImage,
    required this.consigneeName,
    required this.consigneeAddress,
    required this.consigneePhone,
    required this.shipmentTo,
    required this.consigneeCountryId,
    required this.consigneeStateId,
    required this.consigneeCityId,
    required this.quantity,
    required this.description,
    required this.length,
    required this.height,
    required this.width,
    required this.packageSize,
    required this.packageImage,
  });

  @override
  State<CalculatePackageRate> createState() => _CalculatePackageRateState();
}

class _CalculatePackageRateState extends State<CalculatePackageRate> {
  TextEditingController weightController = TextEditingController();
  TextEditingController packageValueController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  ShipmentOrderController shipmentOrderController =
      Get.put(ShipmentOrderController());

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2500));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    shipmentOrderController = Get.put(ShipmentOrderController());
  }

  @override
  void dispose() {
    weightController.dispose();
    packageValueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculate",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.bottomCenter,
              height: 40,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
              child: const Text(
                "Calculate Your Rates",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.packageImage),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      "Choose another Package type",
                      style: TextStyle(
                        color: Colors.red,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(child: Text("Package Weight")),
                        Expanded(
                          child: MyCustomTextBox(
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return "Please enter Weight";
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              myController: weightController,
                              myHint: "Weight"),
                        ),
                        Expanded(
                          child: Container(
                            height: 60,
                            width: 40,
                            child: Center(
                              child: Text("Gram"),
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text("Package Value"),
                        ),
                        Expanded(
                          child: MyCustomTextBox(
                            validate: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Product Value";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            myController: packageValueController,
                            myHint: "Value",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Text(
                "Ship Date",
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            Divider(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('yyyy-MM-dd').format(selectedDate),
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    IconButton(
                      onPressed: () => _selectDate(context),
                      icon: Icon(
                        Icons.calendar_month,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        return shipmentOrderController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : MyCustomButton(
                title: "Submit",
                onClick: () {
                  if (_formKey.currentState!.validate()) {
                    shipmentOrderController.shipmentOrders(
                      shipperName: widget.shipperName,
                      shipmentType: widget.shipmentType,
                      shipperPhone: widget.shipperphoneNo,
                      shipperAddress: widget.shipperAddress,
                      shipperState: widget.shipperstateId,
                      shipperCity: widget.shippercityId,
                      requestPickup: widget.shipperrequestToPick,
                      pickUpLocation: widget.shipperpickLocation,
                      requestInsurance: widget.shipperrequestInsurance,
                      deliverType: widget.shipperdelieryType,
                      imageFile: widget.productImage,
                      consigneeName: widget.consigneeName,
                      consigneeAddress: widget.consigneeAddress,
                      consigneePhone: widget.consigneePhone,
                      itemDescription: widget.description,
                      consigneeCountry: widget.consigneeCountryId,
                      consigneeState: widget.consigneeStateId,
                      consigneeCity: widget.consigneeCityId,
                      quantity: widget.quantity,
                      length: widget.length,
                      width: widget.width,
                      height: widget.height,
                      packageType: widget.packageSize,
                      packageWeight: weightController.text,
                      carriageValue: packageValueController.text,
                      shipmentFrom: widget.shipmentFrom,
                      shipmentTo: widget.shipmentTo,
                      shipmentDate:
                          DateFormat('yyyy-MM-dd').format(selectedDate),
                    );
                    weightController.clear();
                    packageValueController.clear();
                  } else {
                    organoSnackBar(message: "Some Field are Empty");
                  }
                },
              );
      }),
    );
  }
}

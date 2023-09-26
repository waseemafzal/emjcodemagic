import 'dart:io';

import 'package:emjay_global/controller/box_controller.dart';
import 'package:emjay_global/model/box_model.dart';
import 'package:emjay_global/view/screen/booking_tab/calculate_rate.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PackageSizeScreen extends StatefulWidget {
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
  PackageSizeScreen({
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
  });

  @override
  State<PackageSizeScreen> createState() => _PackageSizeScreenState();
}

class _PackageSizeScreenState extends State<PackageSizeScreen> {
  List<BoxModel> boxes = [];

  BoxController boxController = Get.put(BoxController());
  @override
  void initState() {
    super.initState();
    _loadBoxes();
  }

  Future<void> _loadBoxes() async {
    try {
      boxes = await boxController.getBoxes();
      setState(() {});
    } catch (e) {
      // Handle error while loading boxes
    }
  }

  Widget _packageTile({
    required String title,
    required String weight,
    required String imagePath,
    required Function() onClick,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
      child: ListTile(
        onTap: onClick,
        title: Text(title),
        subtitle: Text("$weight"),
        trailing: Image.network(
          imagePath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Column(
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
              "Please Select Your Packing",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: boxes.length,
                itemBuilder: (context, index) {
                  final box = boxes[index];

                  return _packageTile(
                    title: box.title,
                    weight: box.weight,
                    imagePath: box.imagePath,
                    onClick: () {
                      Get.to(
                        () => CalculatePackageRate(
                          shipmentType: widget.shipmentType,
                          shipperName: widget.shipperName,
                          shipperAddress: widget.shipperAddress,
                          shipperphoneNo: widget.shipperphoneNo,
                          shipmentFrom: widget.shipmentFrom,
                          shippercountryId: widget.shippercountryId,
                          shipperstateId: widget.shipperstateId,
                          shippercityId: widget.shippercityId,
                          shipperrequestToPick: widget.shipperrequestToPick,
                          shipperrequestInsurance:
                              widget.shipperrequestInsurance,
                          shipperpickLocation: widget.shipperpickLocation,
                          shipperdelieryType: widget.shipperdelieryType,
                          productImage: widget.productImage,
                          consigneeName: widget.consigneeName,
                          consigneeAddress: widget.consigneeAddress,
                          consigneePhone: widget.consigneePhone,
                          shipmentTo: widget.shipmentTo,
                          consigneeCountryId: widget.consigneeCountryId,
                          consigneeStateId: widget.consigneeStateId,
                          consigneeCityId: widget.consigneeCityId,
                          quantity: widget.quantity,
                          description: widget.description,
                          length: widget.length,
                          height: widget.height,
                          width: widget.width,
                          packageSize: box.title,
                          packageImage: box.imagePath,
                        ),
                      );
                    },
                  );
                }),
          ),
          const Divider(),
          // _packageTile(
          //   onClick: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => CalculatePackageRate(
          //       shipperName: widget.shipperName,
          //       shipperAddress: widget.shipperAddress,
          //       shipperphoneNo: widget.shipperphoneNo,
          //       shippercountryId: widget.shippercountryId,
          //       shipperstateId: widget.shipperstateId,
          //       shippercityId: widget.shippercityId,
          //       shipperrequestToPick: widget.shipperrequestToPick,
          //       shipperrequestInsurance: widget.shipperrequestInsurance,
          //       shipperpickLocation: widget.shipperpickLocation,
          //       shipperdelieryType: widget.shipperdelieryType,
          //       consigneeName: widget.consigneeName,
          //       consigneeAddress: widget.consigneeAddress,
          //       consigneePhone: widget.consigneePhone,
          //       consigneeCountryId: widget.consigneeCountryId,
          //       consigneeStateId: widget.consigneeStateId,
          //       consigneeCityId: widget.consigneeCityId,
          //       quantity: widget.quantity,
          //       description: widget.description,
          //       length: widget.length,
          //       height: widget.height,
          //       width: widget.width,
          //       packageSize:
          //           "lib/view/assets/images/package/extra_large_box.png",
          //     ),
          //   ),
          // );
          //   },
          //   title: "Extra Large Box",
          //   weight: 25,
          //   imagePath: "lib/view/assets/images/package/extra_large_box.png",
          // ),
          // const Divider(),
          // _packageTile(
          //   onClick: () {
          //     // Navigator.of(context).push(
          //     //   MaterialPageRoute(
          //     //     builder: (context) => CalculatePackageRate(
          //     //       imagePath: "lib/view/assets/images/package/large_box.png",
          //     //     ),
          //     //   ),
          //     // );
          //   },
          //   title: "Large Box",
          //   weight: 10,
          //   imagePath: "lib/view/assets/images/package/large_box.png",
          // ),
          // const Divider(),
          // _packageTile(
          //   onClick: () {
          //     // Navigator.of(context).push(
          //     //   MaterialPageRoute(
          //     //     builder: (context) => CalculatePackageRate(
          //     //       imagePath:
          //     //           "lib/view/assets/images/package/medium_box.png",
          //     //     ),
          //     //   ),
          //     // );
          //   },
          //   title: "Extra Large Box",
          //   weight: 5,
          //   imagePath: "lib/view/assets/images/package/medium_box.png",
          // ),
          // const Divider(),
          // _packageTile(
          //   onClick: () {
          //     // Navigator.of(context).push(
          //     //   MaterialPageRoute(
          //     //     builder: (context) => CalculatePackageRate(
          //     //       imagePath: "lib/view/assets/images/package/letter.png",
          //     //     ),
          //     //   ),
          //     // );
          //   },
          //   title: "Extra Large Box",
          //   weight: 1,
          //   imagePath: "lib/view/assets/images/package/letter.png",
          // ),
        ],
      ),
    );
  }
}

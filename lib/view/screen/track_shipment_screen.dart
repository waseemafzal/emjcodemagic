import 'package:emjay_global/controller/track_shipment_controller.dart';
import 'package:emjay_global/model/track_shipment_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TrackShipmentScreen extends StatefulWidget {
  final String trackNo;
  const TrackShipmentScreen({
    super.key,
    required this.trackNo,
  });

  @override
  State<TrackShipmentScreen> createState() => _TrackShipmentScreenState();
}

class _TrackShipmentScreenState extends State<TrackShipmentScreen> {
  TrackShipmentController trackShipmentController =
      Get.put(TrackShipmentController(TrackShipmentModel()));

  Widget _shipmentTile({
    required String shipmentType,
    required String shipperName,
    required String shipperPhone,
    required String shipperAddress,
    required String requestInsurance,
    required String requestToPick,
    required String deliveryType,
    required String consigneeName,
    required String consigneeAddress,
    required String consigneePhone,
    required String itemDescription,
    required String packageWeight,
    required String packageValue,
    required String shipmentFrom,
    required String shipmentTo,
    required String shipmentDate,
    required String trackingNo,
    required String shipmentStatus,
  }) {
    return Column(
      children: [
        Row(
          children: [
            const Text("Status:"),
            Text(
              "On its way",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$shipmentFrom\t\t",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
              ),
            ),
            const Icon(
              Icons.arrow_forward,
              size: 20,
            ),
            Text(
              "\t\t$shipmentTo",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Estimated Arrival date :\t",
            ),
            Text(
              shipmentDate,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        const Divider(),
        Text(
          shipmentType,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tracking #",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(trackingNo),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Shipment Status",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(shipmentStatus),
                  ],
                ),
              ],
            ),
          ],
        ),
        const Divider(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Shipper Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(shipperName),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Shipper Phone",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(shipperPhone),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Shipper Address",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(shipperAddress),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Request Insurance",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(requestInsurance),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Request to Pick",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(requestToPick),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Delivery Type",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(deliveryType),
              ],
            ),
          ],
        ),
        const Divider(),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Consignee Name",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(consigneeName),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Consignee Phone",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(consigneePhone),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Consignee Address",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(consigneeAddress),
              ],
            ),
          ],
        ),
        const Divider(),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Item Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(itemDescription),
              ],
            ),
          ],
        ),
        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Package Weight",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(packageWeight),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Package Carriage Value",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(packageValue),
          ],
        ),
      ],
    );
  }

  Widget _buildTrackShipmentTile(List<Data> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final myData = data[index];
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            // height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(1, 2),
                  blurRadius: 5,
                  color: Colors.grey.shade200,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: _shipmentTile(
              shipmentType: myData.shipmentType.toString(),
              shipperName: myData.shipperName.toString(),
              shipperPhone: myData.shipperPhone.toString(),
              shipperAddress: myData.shipperAddress.toString(),
              requestInsurance: myData.requestInsurance.toString(),
              requestToPick: myData.requestPickup.toString(),
              deliveryType: myData.deliveryType.toString(),
              consigneeName: myData.consigneeName.toString(),
              consigneeAddress: myData.consigneeAddress.toString(),
              consigneePhone: myData.consigneePhone.toString(),
              itemDescription: myData.itemDescription.toString(),
              packageWeight: myData.packageWeight.toString(),
              packageValue: myData.carriageValue.toString(),
              shipmentFrom: myData.shipmentFrom.toString(),
              shipmentTo: myData.shipmentTo.toString(),
              shipmentDate: myData.shipmentDate.toString(),
              trackingNo: myData.trackNumber.toString(),
              shipmentStatus: myData.shipmentStatus.toString(),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    trackShipmentController.trackShipment(trackNumber: widget.trackNo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tracking Shipment"),
      ),
      body: Obx(() {
        if (trackShipmentController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _buildTrackShipmentTile(
              trackShipmentController.getTrackShipments() ?? []);
        }
      }),
    );
  }
}

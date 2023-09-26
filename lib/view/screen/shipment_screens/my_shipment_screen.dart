import 'package:emjay_global/controller/my_shipment_controller.dart';
import 'package:emjay_global/model/my_shipment_model.dart';
import 'package:emjay_global/view/screen/shipment_screens/shipment_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyShipments extends StatefulWidget {
  const MyShipments({super.key});

  @override
  State<MyShipments> createState() => _MyShipmentsState();
}

class _MyShipmentsState extends State<MyShipments> {
  Widget _shipmentTile(
    context, {
    required String date,
    required String totalShipment,
    required Function() onClick,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 60,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(9),
                topRight: Radius.circular(9),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Expected Date \t\t$date",
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: onClick,
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              width: double.infinity,
              child: Text("Number of Boxes $totalShipment"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    myShipmentController.fetchMyShipments();
  }

  MyShipmentController myShipmentController =
      Get.put(MyShipmentController(MyShipmentModel()));

  Widget _buildMyShipmentTile(List<Data> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final myData = data[index];
          return _shipmentTile(context, onClick: () {
            Get.to(() => MyShipmentDetailScreen(
                  shipmentId: myData.shipmentId.toString(),
                  expectedDate: myData.expectedDate.toString(),
                  shippingDate: myData.shippingDate.toString(),
                  boxes: myData.boxes,
                ));
          },
              date: myData.expectedDate.toString(),
              totalShipment: myData.noOfBoxes.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Shipments",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Obx(() {
        return myShipmentController.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : _buildMyShipmentTile(myShipmentController.getMyShipments() ?? []);
      }),
    );
  }
}

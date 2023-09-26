import 'package:emjay_global/controller/shipment_controller.dart';
import 'package:emjay_global/model/shipment_model.dart';
import 'package:emjay_global/view/screen/auth_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShipmentPage extends StatefulWidget {
  const ShipmentPage({super.key});

  @override
  State<ShipmentPage> createState() => _ShipmentPageState();
}

class _ShipmentPageState extends State<ShipmentPage> {
  Widget _shipmentTile({
    required String shipmentType,
    required String shipmentStatus,
    required String shipmentFrom,
    required String shipmentTo,
    required String itemDescription,
    required String consigneeName,
    required String consigneePhone,
    required String shipmentDate,
    required String trackingNo,
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
              "Estimated Arrival date\t\t",
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
                Text(
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
                Text(
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
                Text(
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
                Text(
                  "Consignee Phone",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(consigneePhone),
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
                Text(
                  "Item Description",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(itemDescription),
              ],
            ),
          ],
        )
      ],
    );
  }

  ShipmentController shipmentController =
      Get.put(ShipmentController(ShipmentModel()));

  Widget _buildShipmentTile(List<Data> data) {
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
              shipmentStatus: myData.shipmentStatus.toString(),
              shipmentFrom: myData.shipmentFrom.toString(),
              shipmentTo: myData.shipmentTo.toString(),
              itemDescription: myData.itemDescription.toString(),
              consigneeName: myData.consigneeName.toString(),
              consigneePhone: myData.consigneePhone.toString(),
              shipmentDate: myData.shipmentDate.toString(),
              trackingNo: myData.trackNumber.toString(),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    shipmentController.fetchShipment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Shipments",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.person_outline,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Overview",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Container(
                child: Obx(() {
                  if (shipmentController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return _buildShipmentTile(
                        shipmentController.getShipments() ?? []);
                  }
                }),
              ),
            ),
            // ExpansionTile(
            //   title: Row(
            //     children: [
            //       const Text("Container list"),
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       CircleAvatar(
            //         backgroundColor: Theme.of(context).primaryColor,
            //         radius: 12,
            //         child: const FittedBox(
            //           child: Text(
            //             "4",
            //             style: TextStyle(
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            //   children: [
            //     _containerCard(context, title: "ABCD 123 (40' Dry)"),
            //     _containerCard(context, title: "ABCD 123 (40' Dry)"),
            //     _containerCard(context, title: "ABCD 123 (40' Dry)"),
            //     _containerCard(context, title: "ABCD 123 (40' Dry)"),
            //   ],
            // ),
            // const Text(
            //   "Transport Plan",
            //   style: TextStyle(
            //     fontSize: 17,
            //   ),
            // ),
            // Container(
            //   padding:
            //       const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            //   height: 100,
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     boxShadow: [
            //       BoxShadow(
            //         offset: const Offset(1, 2),
            //         blurRadius: 5,
            //         color: Colors.grey.shade200,
            //         spreadRadius: 5,
            //       ),
            //     ],
            //   ),
            //   child: Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       const Icon(Icons.location_on_outlined),
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "AMPT Barcelona",
            //             style: TextStyle(
            //               color: Theme.of(context).primaryColor,
            //               fontSize: 18,
            //             ),
            //           ),
            //           Text(
            //             "Barcelona, Spain",
            //             style: TextStyle(
            //               fontSize: 17,
            //             ),
            //           ),
            //           Text(
            //             "7 Aug 2022, 18:00",
            //             style: TextStyle(
            //               color: Theme.of(context).primaryColor,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            // Row(
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 20.0),
            //       child: Icon(
            //         Icons.local_shipping_outlined,
            //       ),
            //     ),
            //     const SizedBox(
            //       width: 5,
            //     ),
            //     Text("Gate out Empty, Voyage No.107b"),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

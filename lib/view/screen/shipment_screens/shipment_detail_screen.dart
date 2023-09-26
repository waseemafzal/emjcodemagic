import 'package:emjay_global/model/my_shipment_model.dart';
import 'package:flutter/material.dart';

class MyShipmentDetailScreen extends StatefulWidget {
  final String shipmentId;
  final String expectedDate;
  final String shippingDate;
  final List<Boxes>? boxes;

  const MyShipmentDetailScreen({
    super.key,
    required this.shipmentId,
    required this.expectedDate,
    required this.shippingDate,
    required this.boxes,
  });

  @override
  State<MyShipmentDetailScreen> createState() => _MyShipmentDetailScreenState();
}

class _MyShipmentDetailScreenState extends State<MyShipmentDetailScreen> {
  Widget _shipmentTile(
    context, {
    required String shipmentId,
    required String expectedDate,
    required String shipmentDate,
    required List boxes,
    required Function() onClick,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            height: 80,
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Shipment ID",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      shipmentId,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Expected Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(expectedDate),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Shipped Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(shipmentDate),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Text(
              "Boxes Description",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < boxes.length; i++)
                  _boxTile(
                    boxNumber: "Box No. ${i + 1}",
                    createdDate: boxes[i].createdDate,
                    weight: boxes[i].weight,
                    rate: boxes[i].rate,
                    height: boxes[i].height,
                    width: boxes[i].width,
                    length: boxes[i].length,
                    dimension: boxes[i].dimension,
                    cubicFeet: boxes[i].cubicFeet,
                    dimensionalWeight: boxes[i].dimensionalWeight,
                    products: boxes[i].items!,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _boxTile({
    required String boxNumber,
    required String createdDate,
    required String weight,
    required String rate,
    required String length,
    required String height,
    required String width,
    required String dimension,
    required String cubicFeet,
    required String dimensionalWeight,
    required List<Items> products,
  }) {
    return ExpansionTile(
      title: Text(boxNumber),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Create Date",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(createdDate),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Weight",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${weight} GRM"),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Rate",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${rate} \$"),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Length",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${length} cm"),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Height",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${height} cm"),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Width",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${width} cm"),
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Dimension",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${dimension}"),
                          ],
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Cubic Feet",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${cubicFeet}"),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "D. Weight",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text("${dimensionalWeight}"),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ExpansionTile(
              title: const Text("Item(s) Description"),
              children: products.map(
                (e) {
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: Theme.of(context).primaryColor,
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.white,
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                "${e.price}\$",
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(e.itemTitle.toString()),
                      subtitle: Text("QTY : ${e.quantity}"),
                    ),
                  );
                },
              ).toList(),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Shipment Items",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _shipmentTile(
              context,
              shipmentId: widget.shipmentId,
              expectedDate: widget.expectedDate,
              shipmentDate: widget.shippingDate,
              boxes: widget.boxes!,
              onClick: () {},
            ),
          ],
        ),
      ),
    );
  }
}

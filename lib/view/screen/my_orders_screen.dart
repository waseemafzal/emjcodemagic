import 'package:emjay_global/controller/my_orders_controller.dart';
import 'package:emjay_global/model/my_orders_model.dart';
import 'package:emjay_global/view/screen/orders_detials_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen>
    with TickerProviderStateMixin {
  TabController? _tabController;
  MyOrdersController myOrdersController =
      Get.put(MyOrdersController(MyOrderModel()));

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 8, vsync: this); // Replace 3 with the number of tabs you have
    myOrdersController.fetchOrders();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Widget _shipmentTile(
    context, {
    required String orderTrackingNo,
    required String status,
    required String store,
    required String date,
    required List productName,
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
                      "Order Tracking No.",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      orderTrackingNo,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: onClick,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            width: double.infinity,
            decoration: BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Date",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(date),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Store",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(store),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Status",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Theme.of(context).primaryColor),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SizedBox(
                          width: 70,
                          child: Text(
                            status,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Text(
              "Item Description",
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
              children: productName.map((e) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text("$e"),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPendingOrderList(List<Pending> pendingOrders) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: pendingOrders.length,
        itemBuilder: (context, index) {
          final orders = pendingOrders[index];
          return Column(
            children: [
              _shipmentTile(context, onClick: () {
                Get.to(() => MyOrderDetailScreen(
                    trackingId: orders.trackingNo.toString(),
                    date: orders.createdOn.toString(),
                    store: orders.storeName.toString(),
                    status: "Pending",
                    productList: orders.products));
              },
                  orderTrackingNo: orders.trackingNo.toString(),
                  status: orders.status == "0" ? "Pending" : "",
                  store: orders.storeName.toString(),
                  date: orders.createdOn.toString(),
                  productName:
                      orders.products!.map((e) => e.itemTitle).toList()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReceivedOrderList(List<Received> receivedOrders) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: receivedOrders.length,
        itemBuilder: (context, index) {
          final orders = receivedOrders[index];
          return Column(
            children: [
              _shipmentTile(context, onClick: () {
                Get.to(() => MyOrderDetailScreen(
                    trackingId: orders.trackingNo.toString(),
                    date: orders.createdOn.toString(),
                    store: orders.storeName.toString(),
                    status: "Received",
                    productList: orders.products));
              },
                  orderTrackingNo: orders.trackingNo.toString(),
                  status: orders.status == "1" ? "Received" : "",
                  store: orders.storeName.toString(),
                  date: orders.createdOn.toString(),
                  productName:
                      orders.products!.map((e) => e.itemTitle).toList()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildOnHoldOrderList(List<Onhold> onHoldOrders) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: onHoldOrders.length,
        itemBuilder: (context, index) {
          final orders = onHoldOrders[index];
          return Column(
            children: [
              _shipmentTile(context, onClick: () {
                Get.to(() => MyOrderDetailScreen(
                    trackingId: orders.trackingNo.toString(),
                    date: orders.createdOn.toString(),
                    store: orders.storeName.toString(),
                    status: "On Hold",
                    productList: orders.products));
              },
                  orderTrackingNo: orders.trackingNo.toString(),
                  status: orders.status == "2" ? "On Hold" : "",
                  store: orders.storeName.toString(),
                  date: orders.createdOn.toString(),
                  productName:
                      orders.products!.map((e) => e.itemTitle).toList()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildShippedOrderList(List<Shipped> shippedOrders) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: shippedOrders.length,
        itemBuilder: (context, index) {
          final orders = shippedOrders[index];
          return Column(
            children: [
              _shipmentTile(context, onClick: () {
                Get.to(() => MyOrderDetailScreen(
                    trackingId: orders.trackingNo.toString(),
                    date: orders.createdOn.toString(),
                    store: orders.storeName.toString(),
                    status: "Shipped",
                    productList: orders.products));
              },
                  orderTrackingNo: orders.trackingNo.toString(),
                  status: orders.status == "3" ? "Shipped" : "",
                  store: orders.storeName.toString(),
                  date: orders.createdOn.toString(),
                  productName:
                      orders.products!.map((e) => e.itemTitle).toList()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRefusedOrderList(List<Refused> refusedOrders) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: refusedOrders.length,
        itemBuilder: (context, index) {
          final orders = refusedOrders[index];
          return Column(
            children: [
              _shipmentTile(context, onClick: () {
                Get.to(() => MyOrderDetailScreen(
                    trackingId: orders.trackingNo.toString(),
                    date: orders.createdOn.toString(),
                    store: orders.storeName.toString(),
                    status: "Refused",
                    productList: orders.products));
              },
                  orderTrackingNo: orders.trackingNo.toString(),
                  status: orders.status == "4" ? "Refused" : "",
                  store: orders.storeName.toString(),
                  date: orders.createdOn.toString(),
                  productName:
                      orders.products!.map((e) => e.itemTitle).toList()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMissingOrderList(List<Missing> missingOrders) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: missingOrders.length,
        itemBuilder: (context, index) {
          final orders = missingOrders[index];
          return Column(
            children: [
              _shipmentTile(context, onClick: () {
                Get.to(() => MyOrderDetailScreen(
                    trackingId: orders.trackingNo.toString(),
                    date: orders.createdOn.toString(),
                    store: orders.storeName.toString(),
                    status: "Missing",
                    productList: orders.products));
              },
                  orderTrackingNo: orders.trackingNo.toString(),
                  status: orders.status == "5" ? "Missing" : "",
                  store: orders.storeName.toString(),
                  date: orders.createdOn.toString(),
                  productName:
                      orders.products!.map((e) => e.itemTitle).toList()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPackedOrderList(List<Packed> packedOrders) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: packedOrders.length,
        itemBuilder: (context, index) {
          final orders = packedOrders[index];
          return Column(
            children: [
              _shipmentTile(context, onClick: () {
                Get.to(() => MyOrderDetailScreen(
                    trackingId: orders.trackingNo.toString(),
                    date: orders.createdOn.toString(),
                    store: orders.storeName.toString(),
                    status: "Packed",
                    productList: orders.products));
              },
                  orderTrackingNo: orders.trackingNo.toString(),
                  status: orders.status == "6" ? "Packed" : "",
                  store: orders.storeName.toString(),
                  date: orders.createdOn.toString(),
                  productName:
                      orders.products!.map((e) => e.itemTitle).toList()),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPartialReceivedOrderList(List<PartialReceived> partialReceived) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: partialReceived.length,
        itemBuilder: (context, index) {
          final orders = partialReceived[index];
          return Column(
            children: [
              _shipmentTile(context, onClick: () {
                Get.to(() => MyOrderDetailScreen(
                    trackingId: orders.trackingNo.toString(),
                    date: orders.createdOn.toString(),
                    store: orders.storeName.toString(),
                    status: "Partial Received",
                    productList: orders.products));
              },
                  orderTrackingNo: orders.trackingNo.toString(),
                  status: orders.status == "7" ? "Partial Received" : "",
                  store: orders.storeName.toString(),
                  date: orders.createdOn.toString(),
                  productName:
                      orders.products!.map((e) => e.itemTitle).toList()),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              tabs: const [
                Text("Pending"),
                Text("Received"),
                Text("On Hold"),
                Text("Shipped"),
                Text("Refused"),
                Text("Missing"),
                Text("Packed"),
                Text("Partial Received"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                //Pending Order tab
                Obx(() {
                  if (myOrdersController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return _buildPendingOrderList(
                        myOrdersController.getPendingOrders() ?? []);
                  }
                }),

                //Received Order tab
                Obx(() {
                  if (myOrdersController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return _buildReceivedOrderList(
                        myOrdersController.getReceivedOrders() ?? []);
                  }
                }),
                //On Hold Order tab
                Obx(() {
                  if (myOrdersController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return _buildOnHoldOrderList(
                        myOrdersController.getOnHoldOrders() ?? []);
                  }
                }),
                //Shipped Order tab
                Obx(() {
                  if (myOrdersController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return _buildShippedOrderList(
                        myOrdersController.getShippedOrders() ?? []);
                  }
                }),
                //Refused Order tab
                Obx(() {
                  if (myOrdersController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return _buildRefusedOrderList(
                        myOrdersController.getRefusedOrders() ?? []);
                  }
                }),
                //Missing Order tab
                Obx(() {
                  if (myOrdersController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return _buildMissingOrderList(
                        myOrdersController.getMissingOrders() ?? []);
                  }
                }),
                //Packed Order tab
                Obx(() {
                  if (myOrdersController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return _buildPackedOrderList(
                        myOrdersController.getPackedOrders() ?? []);
                  }
                }),
                //Partial Received Order tab
                Obx(() {
                  if (myOrdersController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return _buildPartialReceivedOrderList(
                        myOrdersController.getPartialReceivedOrders() ?? []);
                  }
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/auth_controller.dart';
import 'package:emjay_global/controller/home_data_controller.dart';
import 'package:emjay_global/controller/profile_controller.dart';
import 'package:emjay_global/view/screen/auth_screen/profile_screen.dart';
import 'package:emjay_global/view/screen/shop_screen/shop_dashboard_screen.dart';
import 'package:emjay_global/view/screen/shop_works_screen.dart';
import 'package:emjay_global/view/screen/track_shipment_screen.dart';
import 'package:emjay_global/view/widgets/invoice_tile.dart';
import 'package:emjay_global/view/widgets/my_custom_icon_button.dart';
import 'package:emjay_global/view/widgets/search_text_box.dart';
import 'package:emjay_global/view/widgets/shipment_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthController authController = Get.put(AuthController());
  HomeDataController homeDataController = Get.put(HomeDataController());
  ProfileController profileController = Get.put(ProfileController());
  TextEditingController shipmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    homeDataController.fetchData();
    profileController.fetchUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    // authController.fetchUserProfile();
    printApiResponse(authController.accesstoken);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Welcome",
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ShopDashboardScreen(),
                ),
              );
            },
            icon: Icon(
              Icons.shopping_bag_outlined,
              color: Theme.of(context).primaryColor,
            ),
          ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: Row(
                children: [
                  const Text(
                    'Here is latest with\t\t\t',
                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  Flexible(
                    child: Obx(
                      () {
                        return profileController.isLoading.value
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Text(
                                profileController.firstname == null
                                    ? "Guest"
                                    : "${profileController.firstname} "
                                        "${profileController.lastname}",
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                      },
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 25,
                  )
                ],
              ),
            ),
            SearchTextBox(
              textInput: TextInputType.number,
              onClick: () {
                if (shipmentController.text.isNotEmpty) {
                  Get.to(
                    () => TrackShipmentScreen(
                      trackNo: shipmentController.text.trim(),
                    ),
                  );
                  // shipmentController.clear();
                } else {
                  organoSnackBar(message: "Please enter your tracking number");
                }
              },
              myController: shipmentController,
              myHint: "Track your Shipment",
            ),
            Obx(() {
              return homeDataController.isLoading.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          height: 100,
                          decoration:
                              BoxDecoration(color: Colors.white, boxShadow: [
                            BoxShadow(
                              offset: const Offset(3, 3),
                              color: Colors.grey.shade300,
                              blurRadius: 10,
                              spreadRadius: 2,
                            )
                          ]),
                          child: Row(
                            children: [
                              InvoiceTile(
                                  title: "Open Invoices",
                                  totalInvoice:
                                      homeDataController.unpaidInvoiceCount ??
                                          0),
                              InvoiceTile(
                                  title: "Paid Invoices",
                                  totalInvoice:
                                      homeDataController.paidInvoiceCount ?? 0),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(3, 3),
                                color: Colors.grey.shade300,
                                blurRadius: 10,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                "Shipments History",
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ShipmentTile(
                                    title: "Processing",
                                    icon: Icons.access_time_sharp,
                                    totalShipment: homeDataController
                                            .processingShipments ??
                                        0,
                                  ),
                                  ShipmentTile(
                                    title: "Shipped",
                                    icon: Icons.shopping_cart_rounded,
                                    totalShipment:
                                        homeDataController.shippedShipments ??
                                            0,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ShipmentTile(
                                    title: "Received",
                                    icon: Icons.verified_outlined,
                                    totalShipment:
                                        homeDataController.receivedShipments ??
                                            0,
                                  ),
                                  ShipmentTile(
                                    title: "Cancelled",
                                    icon: Icons.dangerous_outlined,
                                    totalShipment:
                                        homeDataController.cancelledShipments ??
                                            0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
            }),
            const SizedBox(
              height: 10,
            ),
            MyCustomIconButton(
                title: "Shop",
                onClick: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  bool shouldShowScreenAgain =
                      prefs.getBool('showScreenAgain') ?? true;

                  if (shouldShowScreenAgain) {
                    Get.to(
                      () => ShopWorkScreen(),
                    );
                  } else {
                    Get.to(
                      () => ShopDashboardScreen(),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}

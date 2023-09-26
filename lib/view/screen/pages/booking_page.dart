import 'package:emjay_global/view/screen/auth_screen/profile_screen.dart';
import 'package:emjay_global/view/screen/booking_tab/shipment_screens/shipment_type_shipper_screen.dart';
import 'package:emjay_global/view/screen/booking_tab/vehicle_shipment/vehicle_shipper_detial.dart';
import 'package:emjay_global/view/screen/shop_screen/shop_dashboard_screen.dart';
import 'package:emjay_global/view/widgets/book_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Book",
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
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BookTile(
                title: "Personal Effect",
                imagePath: "lib/view/assets/images/book/box.png",
                onClick: () {
                  Get.to(
                    () => const ShipmentTypeShipperScreen(
                      title: "Personal Effect",
                    ),
                  );
                },
              ),
              BookTile(
                title: "Ocean Freight",
                imagePath: "lib/view/assets/images/book/ship.png",
                onClick: () {
                  Get.to(
                    () => const ShipmentTypeShipperScreen(
                      title: "Ocean Freight",
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BookTile(
                title: "Airplane Shipment",
                imagePath: "lib/view/assets/images/book/airplane.png",
                onClick: () {
                  Get.to(
                    () => const ShipmentTypeShipperScreen(
                      title: "Airplane Shipment",
                    ),
                  );
                },
              ),
              BookTile(
                title: "Container Shipment",
                imagePath: "lib/view/assets/images/book/container.png",
                onClick: () {
                  Get.to(
                    () => const ShipmentTypeShipperScreen(
                      title: "Container Shipment",
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BookTile(
                title: "Vehicle Shipment",
                imagePath: "lib/view/assets/images/book/vehicle.png",
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => VehicleShipperDetail(
                        title: "Vehicle Shipment",
                      ),
                    ),
                  );
                },
              ),
              BookTile(
                title: "Shop",
                imagePath: "lib/view/assets/images/book/shop.png",
                onClick: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShopDashboardScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

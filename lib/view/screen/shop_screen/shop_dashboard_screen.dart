import 'package:emjay_global/view/screen/my_orders_screen.dart';
import 'package:emjay_global/view/screen/shipment_screens/my_shipment_screen.dart';
import 'package:emjay_global/view/screen/orders_screen/add_new_order_screen.dart';
import 'package:flutter/material.dart';

class ShopDashboardScreen extends StatelessWidget {
  const ShopDashboardScreen({super.key});

  Widget _dashboardTile(
    context, {
    required String title,
    required Function() onClick,
  }) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 60,
          vertical: 15,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 25,
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Shop Dashbard",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          _dashboardTile(
            context,
            title: "Add a New Order",
            onClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddNewOrderScreen(),
                ),
              );
            },
          ),
          _dashboardTile(
            context,
            title: "My Orders",
            onClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyOrdersScreen(),
                ),
              );
            },
          ),
          _dashboardTile(
            context,
            title: "My Shipments",
            onClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => MyShipments(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

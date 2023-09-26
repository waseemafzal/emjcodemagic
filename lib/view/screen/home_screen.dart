import 'package:emjay_global/view/screen/pages/booking_page.dart';
import 'package:emjay_global/view/screen/pages/home_page.dart';
import 'package:emjay_global/view/screen/pages/invoice_page.dart';
import 'package:emjay_global/view/screen/pages/shipment_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  void currentIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    HomePage(),
    BookingPage(),
    ShipmentPage(),
    InvoicePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          // Show the confirmation dialog when the back button is pressed
          bool exit = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Confirm Exit'),
              content: Text('Are you sure you want to exit the app?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Yes'),
                ),
              ],
            ),
          );
          ;
          return exit;
        },
        child: Center(
          child: _pages[_selectedIndex],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        currentIndex: _selectedIndex,
        onTap: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.book_outlined,
            ),
            label: "Book",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_shipping_outlined,
            ),
            label: "Shipments",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.inventory_outlined,
            ),
            label: "Inovice",
          )
        ],
      ),
    );
  }
}

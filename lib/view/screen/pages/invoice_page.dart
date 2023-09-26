import 'package:emjay_global/controller/invoice_controller.dart';
import 'package:emjay_global/model/invoice_model.dart';
import 'package:emjay_global/view/screen/auth_screen/profile_screen.dart';
import 'package:emjay_global/view/screen/tabs/open_invoice_tab.dart';
import 'package:emjay_global/view/screen/tabs/paid_invoice_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoicePage extends StatefulWidget {
  const InvoicePage({super.key});

  @override
  State<InvoicePage> createState() => _InvoicePageState();
}

class _InvoicePageState extends State<InvoicePage>
    with TickerProviderStateMixin {
  InvoiceController invoiceController =
      Get.put(InvoiceController(InvoiceModel()));
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    invoiceController.fetchInvoices();
    _tabController = TabController(
        length: 2, vsync: this); // Replace 3 with the number of tabs you have
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Invoices",
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
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            tabs: const [
              Text("Open"),
              Text("Paid"),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  //open invoice tab

                  SingleChildScrollView(
                    child: OpenInvoiceTab(),
                  ),

                  SingleChildScrollView(
                    child: PaidInvoiceTab(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

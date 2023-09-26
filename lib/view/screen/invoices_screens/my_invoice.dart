import 'package:emjay_global/controller/invoice_controller.dart';
import 'package:emjay_global/model/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyInvoices extends StatefulWidget {
  const MyInvoices({super.key});

  @override
  State<MyInvoices> createState() => _MyInvoicesState();
}

class _MyInvoicesState extends State<MyInvoices> with TickerProviderStateMixin {
  TabController? _tabController;
  InvoiceController invoiceController =
      Get.put(InvoiceController(InvoiceModel()));

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, vsync: this); // Replace 3 with the number of tabs you have
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Widget _paidTile(
      {required String status,
      required String invoiceNo,
      required String amount,
      required String date}) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                  child: Text(
                status,
                style: const TextStyle(
                  color: Colors.white,
                ),
              )),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "# ${invoiceNo}",
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Text("\$ $amount"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Text("\$ $amount"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaidInoviceList(List<PaidInvoices> paidInvoice) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: paidInvoice.length,
        itemBuilder: (context, index) {
          final invoice = paidInvoice[index];
          print(invoice.id);
          print(invoice.amount);
          return _paidTile(
            status: invoice.paid == "Yes" ? "Paid" : "",
            invoiceNo: invoice.id.toString(),
            amount: invoice.amount.toString(),
            date: invoice.dueDate.toString(),
          );
        },
      ),
    );
  }

  Widget _unpaidTile({
    required String status,
    required String invoiceNo,
    required String amount,
    required String date,
    required Function() onClick,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 12,
      ),
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                    ),
                    child: Center(
                        child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    )),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "# $invoiceNo",
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text("\$ $amount"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      Text("\$ $amount"),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: onClick,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(9),
                    bottomRight: Radius.circular(9),
                  ),
                  color: Theme.of(context).primaryColor,
                ),
                child: const Center(
                    child: Text(
                  "Pay Now",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpenInoviceList(List<OpenInvoices> openInvoice) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: openInvoice.length,
        itemBuilder: (context, index) {
          final invoice = openInvoice[index];
          print(invoice.id);
          print(invoice.amount);
          return _unpaidTile(
            status: invoice.paid == "No" ? "Unpaid" : "",
            invoiceNo: invoice.id.toString(),
            amount: invoice.amount.toString(),
            date: invoice.dueDate.toString(),
            onClick: () {},
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
          "Invoices",
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
              indicatorSize: TabBarIndicatorSize.tab,
              controller: _tabController,
              tabs: const [
                Text("Paid"),
                Text("Unpaid"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                //paid invoice tab
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        if (invoiceController.isLoading.value) {
                          return CircularProgressIndicator();
                        } else {
                          return _buildPaidInoviceList(
                              invoiceController.getPaidInvoices() ?? []);
                        }
                      })
                    ],
                  ),
                ),

                //unpaid invoice tab
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Obx(() {
                        if (invoiceController.isLoading.value) {
                          return CircularProgressIndicator();
                        } else {
                          return _buildOpenInoviceList(
                              invoiceController.getUnpaidInvoices() ?? []);
                        }
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

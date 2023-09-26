import 'package:emjay_global/controller/invoice_controller.dart';
import 'package:emjay_global/model/invoice_model.dart';
import 'package:emjay_global/view/widgets/open_invoice_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenInvoiceTab extends StatefulWidget {
  const OpenInvoiceTab({super.key});

  @override
  State<OpenInvoiceTab> createState() => _OpenInvoiceTabState();
}

class _OpenInvoiceTabState extends State<OpenInvoiceTab> {
  TextEditingController searchController = TextEditingController();
  InvoiceController invoiceController =
      Get.put(InvoiceController(InvoiceModel()));

  Widget _buildOpenInvoiceList(List<OpenInvoices> openInvoices) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: openInvoices.length,
        itemBuilder: (context, index) {
          final invoice = openInvoices[index];
          return OpenInvoiceTile(
            // invoiceNo: invoice.,
            id: invoice.id ?? "0",
            amount: invoice.amount ?? "0.0",
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // invoiceController.fetchInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
      child: Column(
        children: [
          // SearchTextBox(
          //   myController: searchController,
          //   myHint: "Search by B/L, invoice no.",
          //   enableColor: Colors.grey.shade200,
          //   focusColor: Colors.grey.shade200,
          // ),
          Obx(() {
            if (invoiceController.isLoading.value) {
              return CircularProgressIndicator();
            } else {
              return Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 80,
                    child: Obx(
                      () {
                        if (invoiceController.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Text(
                                "Amount",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                invoiceController.invoiceModel!.totalAmount ==
                                        null
                                    ? "0"
                                    : invoiceController
                                        .invoiceModel!.totalAmount
                                        .toString(),
                                style:
                                    const TextStyle(color: Color(0xffE9B942)),
                              ),
                              const Text(
                                "Open Invoices",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                invoiceController.invoiceModel!.openCount ==
                                        null
                                    ? "0"
                                    : invoiceController.invoiceModel!.openCount
                                        .toString(),
                                style:
                                    const TextStyle(color: Color(0xffE9B942)),
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                  _buildOpenInvoiceList(
                      invoiceController.getUnpaidInvoices() ?? []),
                ],
              );
            }
          })
        ],
      ),
    );
  }
}

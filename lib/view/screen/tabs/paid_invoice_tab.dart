import 'package:emjay_global/controller/invoice_controller.dart';
import 'package:emjay_global/model/invoice_model.dart';
import 'package:emjay_global/view/widgets/paid_inovice_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaidInvoiceTab extends StatefulWidget {
  const PaidInvoiceTab({super.key});

  @override
  State<PaidInvoiceTab> createState() => _PaidInvoiceTabState();
}

class _PaidInvoiceTabState extends State<PaidInvoiceTab> {
  TextEditingController searchController = TextEditingController();
  InvoiceController invoiceController =
      Get.put(InvoiceController(InvoiceModel()));

  Widget _buildOpenInvoiceList(List<PaidInvoices> paidInvoice) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: paidInvoice.length,
        itemBuilder: (context, index) {
          final invoice = paidInvoice[index];
          print(invoice.id);
          print(invoice.amount);
          return PaidInvoiceTile(
            // invoiceNo: invoice.,
            id: invoice.id ?? '0',
            amount: invoice.amount ?? '0.0',
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
          Obx(() {
            if (invoiceController.isLoading.value) {
              return CircularProgressIndicator();
            } else {
              return _buildOpenInvoiceList(
                  invoiceController.getPaidInvoices() ?? []);
            }
          })
        ],
      ),
    );
  }
}

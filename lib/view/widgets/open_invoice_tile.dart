import 'package:emjay_global/controller/invoice_controller.dart';
import 'package:emjay_global/model/invoice_model.dart';
import 'package:emjay_global/view/invoice_payment/invoice_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OpenInvoiceTile extends StatefulWidget {
  final String id;
  final String amount;
  const OpenInvoiceTile({
    super.key,
    required this.id,
    required this.amount,
  });

  @override
  State<OpenInvoiceTile> createState() => _OpenInvoiceTileState();
}

class _OpenInvoiceTileState extends State<OpenInvoiceTile> {
  InvoiceController invoiceController =
      Get.put(InvoiceController(InvoiceModel()));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(1, 2),
                color: Colors.grey.shade200,
                blurRadius: 5,
                spreadRadius: 2,
              ),
            ],
          ),
          height: 100,
          child: Row(
            children: [
              Container(
                width: 10,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  color: Color(0xffE9B942),
                ),
              ),
              Expanded(
                child: ListTile(
                  isThreeLine: true,
                  leading: const Icon(Icons.inventory_2_outlined),
                  title: Text("Invoice number : ${widget.id}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("USD : \$ ${widget.amount}"),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(
                            () => InvoicePaymentScreen(
                              invoiceId: widget.id,
                              amount: widget.amount,
                            ),
                          );
                        },
                        child: const Text("Pay Now"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

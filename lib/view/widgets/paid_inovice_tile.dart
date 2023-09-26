import 'package:flutter/material.dart';

class PaidInvoiceTile extends StatelessWidget {
  final String id;
  final String amount;
  const PaidInvoiceTile({
    super.key,
    required this.id,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(1, 2),
            color: Colors.grey.shade200,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      height: 60,
      child: Row(
        children: [
          Container(
            width: 10,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              color: Color(0xffE9B942),
            ),
          ),
          Expanded(
            child: ListTile(
              leading: Icon(
                Icons.inventory_2_outlined,
              ),
              title: Text("Invoice number : $id"),
              subtitle: Text("USD : \$ $amount"),
            ),
          ),
        ],
      ),
    );
  }
}

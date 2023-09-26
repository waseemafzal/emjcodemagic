import 'package:flutter/material.dart';

class TransuctionHistoryTile extends StatelessWidget {
  final String depDate;
  final String arrDate;
  final String totalDays;
  final String oceanFreight;
  final String totalPrice;
  final Function() onClick;
  const TransuctionHistoryTile({
    super.key,
    required this.depDate,
    required this.arrDate,
    required this.totalDays,
    required this.oceanFreight,
    required this.totalPrice,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffF8F8F8),
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_shipping_outlined,
                        size: 16,
                      ),
                      Icon(
                        Icons.arrow_downward,
                        size: 16,
                      ),
                      Text(
                        "Dep. $depDate",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.local_shipping_outlined,
                        size: 16,
                      ),
                      Icon(
                        Icons.arrow_upward,
                        size: 16,
                      ),
                      Text(
                        "Arr. $arrDate",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: onClick,
                  child: const Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 20,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Transit Times"),
                Text(
                  "$totalDays",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Basic Ocean Freight"),
                    Text(
                      "USD $oceanFreight",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total Price"),
                    Text(
                      "USD $totalPrice",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

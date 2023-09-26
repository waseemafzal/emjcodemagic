import 'package:flutter/material.dart';

class TransuctionReceiptScreen extends StatelessWidget {
  final String fromToCity;
  final String receiptNo;
  final String currentDate;
  final String depDate;
  final String fromCountryCity;
  final String arrDate;
  final String toCountryCity;
  final String totalDays;
  final String oceanFreight;
  final String totalPrice;
  TransuctionReceiptScreen({
    required this.fromToCity,
    required this.receiptNo,
    required this.currentDate,
    required this.depDate,
    required this.fromCountryCity,
    required this.arrDate,
    required this.toCountryCity,
    required this.totalDays,
    required this.oceanFreight,
    required this.totalPrice,
  });

  Widget _departArrivalBuild(context,
      {required String date,
      required String cityCountry,
      required IconData icon,
      required String status}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.local_shipping_outlined,
              size: 16,
            ),
            Icon(
              icon,
              size: 16,
            ),
            Text(
              "$status. $date",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 12,
              ),
            )
          ],
        ),
        Text(
          cityCountry,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          fromToCity,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        height: 320,
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
            children: [
              Row(
                children: [
                  Text(
                    "EMJAY GLOBAL - UNITED STATES",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.file_download,
                    color: Theme.of(context).primaryColor,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.share_outlined,
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    currentDate,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text("$receiptNo"),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    _departArrivalBuild(
                      context,
                      date: depDate,
                      cityCountry: fromCountryCity,
                      icon: Icons.arrow_downward,
                      status: "Dep",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _departArrivalBuild(
                      context,
                      date: arrDate,
                      cityCountry: toCountryCity,
                      icon: Icons.arrow_upward,
                      status: "Arr",
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

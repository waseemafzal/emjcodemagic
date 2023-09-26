import 'package:emjay_global/controller/transuction_history_controller.dart';
import 'package:emjay_global/model/transuction_history_model.dart';
import 'package:emjay_global/view/screen/trasnsuction_screen/transaction_receipt_screen.dart';
import 'package:emjay_global/view/widgets/transuction_history_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TransuctionHistoryScreen extends StatefulWidget {
  const TransuctionHistoryScreen({super.key});

  @override
  State<TransuctionHistoryScreen> createState() =>
      _TransuctionHistoryScreenState();
}

class _TransuctionHistoryScreenState extends State<TransuctionHistoryScreen> {
  TransuctionHistoryController transuctionHistoryController =
      Get.put(TransuctionHistoryController(TransuctionHistroyModel()));

  Widget _buildTransuctionHistoryTile(List<Data> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final myData = data[index];
          return TransuctionHistoryTile(
            depDate: myData.departureDate.toString(),
            arrDate: myData.arrivalDate.toString(),
            totalDays: myData.trnasitTime.toString(),
            oceanFreight: myData.amount.toString(),
            totalPrice: myData.amount.toString(),
            onClick: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TransuctionReceiptScreen(
                    fromToCity: "${myData.shipmentFrom}-${myData.shipmentTo}",
                    receiptNo: myData.trackNumber.toString(),
                    currentDate:
                        DateFormat('yyyy-MM-dd').format(DateTime.now()),
                    depDate: myData.departureDate.toString(),
                    fromCountryCity: myData.consigneeAddress.toString(),
                    arrDate: myData.arrivalDate.toString(),
                    toCountryCity: myData.consigneeAddress.toString(),
                    totalDays: myData.trnasitTime.toString(),
                    oceanFreight: myData.amount.toString(),
                    totalPrice: myData.amount.toString(),
                  ),
                ),
              );
            },
          );
        });
  }

  @override
  void initState() {
    super.initState();
    transuctionHistoryController.fetchTransuctionHistroy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaction Histroy",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15.0,
          vertical: 10,
        ),
        child: Obx(() {
          if (transuctionHistoryController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return _buildTransuctionHistoryTile(
                transuctionHistoryController.getTransuctionHistory() ?? []);
          }
        }),
      ),
    );
  }
}

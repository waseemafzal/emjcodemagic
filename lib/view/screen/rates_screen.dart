import 'package:emjay_global/controller/rates_Controller.dart';
import 'package:emjay_global/model/rates_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatesScreen extends StatefulWidget {
  const RatesScreen({super.key});

  @override
  State<RatesScreen> createState() => _RatesScreenState();
}

class _RatesScreenState extends State<RatesScreen> {
  RateController rateController = Get.put(RateController(RatesModel()));
  Widget _buildRatesTile(List<Data> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final myData = data[index];
          return Card(
            child: ListTile(
              title: Text(
                "${myData.title}",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 17,
                ),
              ),
              subtitle: Text("${myData.price}"),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    rateController.fetchRates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rates"),
      ),
      body: Obx(() {
        if (rateController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _buildRatesTile(rateController.getRates() ?? []);
        }
      }),
    );
  }
}

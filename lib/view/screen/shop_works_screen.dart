import 'package:emjay_global/controller/how_it_works_controller.dart';
import 'package:emjay_global/model/how_it_works_model.dart';
import 'package:emjay_global/view/screen/shop_screen/shop_dashboard_screen.dart';
import 'package:emjay_global/view/widgets/my_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopWorkScreen extends StatefulWidget {
  const ShopWorkScreen({super.key});

  @override
  State<ShopWorkScreen> createState() => _ShopWorkScreenState();
}

class _ShopWorkScreenState extends State<ShopWorkScreen> {
  HowItWorksController howItWorkController =
      Get.put(HowItWorksController(HowItWorksModel()));
  @override
  void initState() {
    super.initState();
    howItWorkController.fetchHowItWorks();
  }

  Widget _hintBuild(List<Data> data) {
    return Expanded(
      child: ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final myData = data[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
              child: Row(
                children: [
                  Text(
                    "${index + 1}",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 50,
                        width: 3,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      myData.title.toString(),
                      style: const TextStyle(
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  showCustomDialog() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return Get.defaultDialog(
      title: "Alert",
      content: Text("Do you want to show this screen again?"),
      actions: [
        TextButton(
          onPressed: () {
            prefs.setBool('showScreenAgain', false);
            Get.back();
          },
          child: Text("No"),
        ),
        TextButton(
          onPressed: () {
            prefs.setBool('showScreenAgain', true);
            Get.back();
          },
          child: Text("Yes"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "How it Works",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            color: Theme.of(context).primaryColor,
            child: const Center(
              child: Text(
                "HOW IT WORKS? FOLLOW THESE STEPS",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
          Obx(() {
            if (howItWorkController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return _hintBuild(howItWorkController.getHowItWorks() ?? []);
            }
          }),
        ],
      ),
      bottomNavigationBar: MyCustomButton(
        title: "PROCEED",
        onClick: () {
          showCustomDialog().then((value) {
            Get.to(
              () => ShopDashboardScreen(),
            );
          });
        },
      ),
    );
  }
}

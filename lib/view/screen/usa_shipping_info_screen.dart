import 'package:emjay_global/controller/contact_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class USAShippingInfoScreen extends StatefulWidget {
  const USAShippingInfoScreen({super.key});

  @override
  State<USAShippingInfoScreen> createState() => _USAShippingInfoScreenState();
}

class _USAShippingInfoScreenState extends State<USAShippingInfoScreen> {
  ContactInfoController contactInfoController =
      Get.put(ContactInfoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactInfoController.fetchUSAShippingInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('USA Shipping Information'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Image.asset("lib/view/assets/images/logo.png"),
            ),
          ),
          const Divider(
            thickness: 2,
            endIndent: 10,
            indent: 10,
          ),
          Expanded(
            flex: 2,
            child: Obx(
              () {
                return contactInfoController.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 10,
                        ),
                        child: Html(
                          data:
                              "${contactInfoController.usaShippingInfo}", // HTML content here
                        ),
                      );
              },
            ),
          ),
        ],
      ),
    );
  }
}

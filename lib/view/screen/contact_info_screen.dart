import 'package:emjay_global/controller/contact_info_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({super.key});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  ContactInfoController contactInfoController =
      Get.put(ContactInfoController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contactInfoController.fetchContactInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Our Contact Information'),
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
                              "${contactInfoController.contactInfo}", // HTML content here
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

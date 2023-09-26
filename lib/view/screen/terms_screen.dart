import 'package:emjay_global/controller/term_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class TermsCondtions extends StatefulWidget {
  const TermsCondtions({super.key});

  @override
  State<TermsCondtions> createState() => _TermsCondtionsState();
}

class _TermsCondtionsState extends State<TermsCondtions> {
  TermConditionController termConditionController =
      Get.put(TermConditionController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    termConditionController.fetchTermsCondition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms & Conditions"),
      ),
      body: Obx(
        () {
          return termConditionController.isLoading.value
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
                        "${termConditionController.terms}", // HTML content here
                    style: {
                      "body": Style(
                        fontSize: FontSize(17),
                      ),
                    },
                  ),
                );
        },
      ),
    );
  }
}

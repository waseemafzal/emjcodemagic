import 'package:emjay_global/controller/faqs_controller.dart';
import 'package:emjay_global/model/faqs_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqsScreen extends StatefulWidget {
  const FaqsScreen({super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  FaqsController faqsController = Get.put(FaqsController(FaqsModel()));
  Widget _buildFAQsTile(List<Data> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final myData = data[index];
          return Card(
            child: ListTile(
              title: Text(
                "${myData.question}",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text("${myData.answer}"),
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    faqsController.fetchFAQs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FAQs"),
      ),
      body: Obx(() {
        if (faqsController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _buildFAQsTile(faqsController.getFaqs() ?? []);
        }
      }),
    );
  }
}

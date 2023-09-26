import 'package:emjay_global/controller/notification_controller.dart';
import 'package:emjay_global/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController notificationController =
      Get.put(NotificationController(NotificationModel()));
  Widget _buildNotificationTile(List<Data> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final myData = data[index];
          return Card(
            child: ListTile(
              title: Text("${myData.body}"),
              subtitle: Text("${myData.createdDate}"),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationController.fetchNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      body: Obx(() {
        if (notificationController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return _buildNotificationTile(
              notificationController.getNotification() ?? []);
        }
      }),
    );
  }
}

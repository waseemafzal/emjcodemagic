import 'package:emjay_global/controller/auth_controller.dart';
import 'package:emjay_global/controller/profile_controller.dart';
import 'package:emjay_global/view/screen/auth_screen/update_profile_screen.dart';
import 'package:emjay_global/view/screen/contact_info_screen.dart';
import 'package:emjay_global/view/screen/contact_us_screen.dart';
import 'package:emjay_global/view/screen/faqs_screen.dart';
import 'package:emjay_global/view/screen/notification_screen.dart';
import 'package:emjay_global/view/screen/rates_screen.dart';
import 'package:emjay_global/view/screen/terms_screen.dart';
import 'package:emjay_global/view/screen/trasnsuction_screen/transuction_history_screen.dart';
import 'package:emjay_global/view/screen/usa_shipping_info_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());
  Widget userTile(
    context, {
    required Function() onClick,
    required String title,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: onClick,
      child: Card(
        color: Colors.white,
        child: ListTile(
          leading: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(title),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // authController.fetchUserProfile();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15.0,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.network("${profileController.imageUrl}"),
                ),
                Text(
                  "${profileController.firstname} "
                  "${profileController.lastname}",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                userTile(
                  context,
                  onClick: () {
                    Get.to(
                      () => const UpdateProfileScreen(),
                    );
                  },
                  title: "My Profile",
                  icon: Icons.person_2_outlined,
                ),
                userTile(
                  context,
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const TransuctionHistoryScreen(),
                      ),
                    );
                  },
                  title: "Transuction History",
                  icon: Icons.compare_arrows_outlined,
                ),
                userTile(
                  context,
                  onClick: () {
                    Get.to(() => const NotificationScreen());
                  },
                  title: "Notification",
                  icon: Icons.notifications_none_outlined,
                ),
                userTile(
                  context,
                  onClick: () {
                    Get.to(() => const FaqsScreen());
                  },
                  title: "FAQs",
                  icon: Icons.question_answer_outlined,
                ),
                userTile(
                  context,
                  onClick: () {
                    Get.to(() => const ContactUsScreen());
                  },
                  title: "Contact Us",
                  icon: Icons.contact_support_outlined,
                ),
                userTile(
                  context,
                  onClick: () {
                    Get.to(() => const TermsCondtions());
                  },
                  title: "Terms & Conditions",
                  icon: Icons.list_alt_outlined,
                ),
                userTile(
                  context,
                  onClick: () {
                    Get.to(() => const RatesScreen());
                  },
                  title: "Rates",
                  icon: Icons.money,
                ),
                userTile(
                  context,
                  onClick: () {
                    Get.to(() => const ContactInfoScreen());
                  },
                  title: "Contact Info",
                  icon: Icons.contact_phone_outlined,
                ),
                userTile(
                  context,
                  onClick: () {
                    Get.to(() => const USAShippingInfoScreen());
                  },
                  title: "USA Shipping Info",
                  icon: Icons.delivery_dining_outlined,
                ),
                Obx(
                  () => authController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : userTile(
                          context,
                          onClick: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                                content: const Text("Are you sure to Delete?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      authController.deleteMyAccount();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Okay"),
                                  ),
                                ],
                              ),
                            );
                          },
                          title: "Delete my Account",
                          icon: Icons.delete_outline_outlined,
                        ),
                ),
                userTile(
                  context,
                  onClick: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("LogOut"),
                        content: const Text("Are you sure to logout?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              authController.logOut();
                            },
                            child: const Text("Okay"),
                          ),
                        ],
                      ),
                    );
                  },
                  title: "Logout",
                  icon: Icons.logout_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

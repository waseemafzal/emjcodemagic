import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/contact_us_controller.dart';
import 'package:emjay_global/model/contact_us_model.dart';
import 'package:emjay_global/view/screen/auth_screen/profile_screen.dart';
import 'package:emjay_global/view/screen/chat_screen.dart';
import 'package:emjay_global/view/widgets/my_custom_text_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen>
    with TickerProviderStateMixin {
  ContactUsController contactUsController =
      Get.put(ContactUsController(ContactUsModel()));
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    contactUsController.fetchContactUsData();
    _tabController = TabController(
        length: 2, vsync: this); // Replace 3 with the number of tabs you have
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Widget _buildPendContactUs(List<Pending> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final myData = data[index];
          return Card(
            child: ListTile(
              onTap: () {
                Get.to(() => ChatScreen(
                      id: myData.id.toString(),
                      userId: myData.userId.toString(),
                    ));
              },
              leading: Text("${myData.id}"),
              title: Text(
                "${myData.message}",
                // style: TextStyle(
                //   color: Theme.of(context).primaryColor,
                //   fontSize: 17,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
              subtitle: Text("${myData.createdDate}"),
            ),
          );
        });
  }

  Widget _buildClosedContactUs(List<Closed> data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final myData = data[index];
          return Card(
            child: ListTile(
              title: Text(
                "${myData.message}",
                // style: TextStyle(
                //   color: Theme.of(context).primaryColor,
                //   fontSize: 17,
                //   fontWeight: FontWeight.bold,
                // ),
              ),
              subtitle: Text("${myData.createdDate}"),
            ),
          );
        });
  }

  TextEditingController messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  showMessagePopUp() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Contact Us"),
        content: Form(
          key: _formKey,
          child: MyCustomTextBox(
            validate: (value) {
              if (value!.isEmpty) {
                return "Please enter your message";
              } else {
                return null;
              }
            },
            maxLine: 5,
            myController: messageController,
            myHint: "Send a Message . . . .",
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Cancel"),
          ),
          Obx(() {
            return contactUsController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : OutlinedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        contactUsController
                            .sendMessage(message: messageController.text.trim())
                            .then((value) {
                          contactUsController.fetchContactUsData();
                        });
                      } else {
                        organoSnackBar(message: "Your message is Empty");
                      }
                      Get.back();
                    },
                    child: Text("Send"),
                  );
          })
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Contact Us",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  );
                },
                icon: Icon(
                  Icons.person_outline,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            controller: _tabController,
            tabs: const [
              Text("Pending"),
              Text("Closed"),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  //Pending Contact Us Tabl

                  Obx(() {
                    if (contactUsController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return _buildPendContactUs(
                          contactUsController.getPendMessages() ?? []);
                    }
                  }),
                  //Closed Contact Us Tabl
                  Obx(() {
                    if (contactUsController.isLoading.value) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return _buildClosedContactUs(
                          contactUsController.getClosedMessages() ?? []);
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showMessagePopUp();
            messageController.clear();
          },
          child: Icon(
            Icons.message,
          ),
        ),
      ),
    );
  }
}

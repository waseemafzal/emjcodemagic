import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/controller/chat_controller.dart';
import 'package:emjay_global/controller/profile_controller.dart';
import 'package:emjay_global/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatefulWidget {
  final String id;
  final String userId;

  const ChatScreen({
    super.key,
    required this.id,
    required this.userId,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ChatController chatController = Get.put(ChatController(ChatModel()));
  TextEditingController messageController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatController.fetchChat(id: widget.id);
  }

  ProfileController profileController = Get.put(ProfileController());
  Widget _buildChatTile(List<Data> data) {
    return ListView.builder(
        reverse: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final myData = data[index];
          return myData.mymessage == 1
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.only(right: 80),
                    width: 70,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.grey.shade300,
                          // blurRadius: 1,
                          // spreadRadius: 2,
                        )
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        "${myData.message}",
                      ),
                      subtitle: Text("${myData.createdDate}"),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: const EdgeInsets.only(left: 80),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.green.shade100,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.grey.shade300,
                          // blurRadius: 1,
                          // spreadRadius: 2,
                        )
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        "${myData.message}",
                      ),
                      subtitle: Text("${myData.createdDate}"),
                    ),
                  ),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    chatController.fetchChat(id: widget.id);
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Screen"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              } else {
                return _buildChatTile(chatController.getChat() ?? []);
              }
            }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Write something here . . .",
                suffixIcon: IconButton(
                  onPressed: () {
                    if (messageController.text.isNotEmpty) {
                      chatController
                          .sendChat(
                              id: widget.id,
                              message: messageController.text.trim())
                          .then((value) {
                        chatController.fetchChat(id: widget.id);
                      });
                      messageController.clear();
                    } else {
                      organoSnackBar(message: "Your message is Empty");
                    }
                  },
                  icon: Icon(Icons.send),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                fillColor: Colors.grey.shade300,
                filled: true,
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar:
    );
  }
}

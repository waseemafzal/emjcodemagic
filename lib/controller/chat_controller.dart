import 'package:emjay_global/Utilis/api_helper.dart';
import 'package:emjay_global/Utilis/my_global_helper.dart';
import 'package:emjay_global/model/chat_model.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxBool isLoading = false.obs;
  ChatModel? _chatModel;
  ChatController(this._chatModel);
  // Fetch invoices from the API
  Future<void> fetchChat({required String id}) async {
    try {
      isLoading(true);
      final response =
          await ApiHelper().postDataAuthenticated("getticketReplies", {
        'id': id,
      });
      if (response['status'] == 200) {
        _chatModel = ChatModel.fromJson(response);
        print(response);
      } else {
        // Handle error if needed
        print('Error fetching messages: ${response.statusCode}');
      }
    } catch (e) {
      organoSnackBar(message: "$e");
    } finally {
      isLoading(false);
    }
  }

  List<Data>? getChat() {
    return _chatModel!.data;
  }

  Future<void> sendChat({
    required String id,
    required String message,
  }) async {
    try {
      isLoading(true);
      final response =
          await ApiHelper().postDataAuthenticated("saveTicketReply", {
        'id': id,
        'message': message,
      });
      if (response['status'] == 200) {
        print(response);
      } else {
        // Handle error if needed
        print('Error fetching messages: ${response.statusCode}');
      }
    } catch (e) {
      organoSnackBar(message: "$e");
    } finally {
      isLoading(false);
    }
  }
}

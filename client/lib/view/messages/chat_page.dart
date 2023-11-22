import 'package:client/controller/auth/login_controller.dart';
import 'package:client/view/messages/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const ChatPage(
      {super.key,
      required this.receiverUserEmail,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  LoginControllerImp loginController =
      Get.put(LoginControllerImp(), permanent: true);
  String initialMessage = "Now you can communicate with each other.";

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          widget.receiverUserEmail,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              print(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: "Create offer",
                child: Text("Create offer"),
              ),
              const PopupMenuItem(
                value: "all offers",
                child: Text("Show all offers"),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Display messages
          Expanded(
            child: _bulidMessageList(),
          ),

          // Display user input
          _bulidMessageInput(),
        ],
      ),
    );
  }

// build message list
  Widget _bulidMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverUserID, loginController.userDto!["id"].toString()),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // Reverse the order of items in the list
        List<DocumentSnapshot> reversedList =
            List.from(snapshot.data!.docs.reversed);

        // If there are no messages, add the initial message
        if (reversedList.isEmpty) {
          _chatService.sendMessage(widget.receiverUserID, initialMessage);
        }

        return ListView(
          reverse: true, // Reverse the order of items in the list
          children: reversedList
              .map((document) => _bulidMessageItem(document))
              .toList(),
        );
      },
    );
  }

  // build message item
  Widget _bulidMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    bool isMe = data['senderId'] == loginController.userDto?["id"].toString();

    String formatMessageTimestamp(Timestamp timestamp) {
      DateTime now = DateTime.now();
      DateTime messageTime = timestamp.toDate();
      Duration difference = now.difference(messageTime);

      // Format: Hour:Minute AM/PM
      if (difference.inHours < 24) {
        return DateFormat.jm().format(messageTime);
      }
      // Yesterday
      else if (difference.inHours < 48) {
        return 'Yesterday';
      }
      // Format: FullMonthName Day
      else {
        return DateFormat('MMMM dd', 'en_US').format(messageTime);
      }
    }

    // The message is the initial message
    if (data['message'] == initialMessage) {
      return Container(
        padding:
            const EdgeInsets.only(bottom: 40, top: 40, right: 50, left: 50),
        child: Column(
          children: [
            Text(
              formatMessageTimestamp(data['timestamp']),
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 3),
            Text(
              data['message'],
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }
    // The message is from a user
    else {
      return Container(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Padding(
          padding: isMe
              ? const EdgeInsets.only(top: 5, bottom: 10, right: 10, left: 60)
              : const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 60),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 5,
                borderRadius: isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      )
                    : const BorderRadius.only(
                        topRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                color: isMe ? Colors.blue[900] : Colors.white,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Text(
                    data['message'],
                    style: TextStyle(
                      fontSize: 15,
                      color: isMe ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                formatMessageTimestamp(data['timestamp']),
                style: TextStyle(
                    fontSize: 13,
                    color: Colors.yellow[900],
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      );
    }
  }

  // build message input
  Widget _bulidMessageInput() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: const BoxDecoration(
            border: Border(
                top: BorderSide(
              color: Colors.orange,
              width: 2,
            )),
          ),
        ),
        Row(
          children: [
            // textfiled
            Expanded(
                child: TextField(
              controller: _messageController,
              obscureText: false,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12),
                ),
                hintText: "Write your message here...",
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 13),
              ),
            )),

            // send button
            IconButton(
                onPressed: sendMessage,
                icon: Icon(
                  Icons.send,
                  size: 25,
                  color: Colors.yellow[900],
                ))
          ],
        ),
      ],
    );
  }
}

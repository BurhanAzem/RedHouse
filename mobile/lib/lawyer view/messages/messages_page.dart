import 'package:client/controller/application/applications_controller.dart';
import 'package:client/controller/history/history_controller.dart';
import 'package:client/controller/users_auth/login_controller.dart';
import 'package:client/model/application.dart';
import 'package:client/model/firebase/chats_model.dart';
import 'package:client/view/messages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class LawyerMessges extends StatefulWidget {
  const LawyerMessges({super.key});

  @override
  State<LawyerMessges> createState() => _LawyerMessgesState();
}

class _LawyerMessgesState extends State<LawyerMessges> {
  bool isLoading = true; // Add a boolean variable for loading state

  LoginControllerImp loginController = Get.put(LoginControllerImp());
  HistoryController historyController =
      Get.put(HistoryController(), permanent: true);
  ApplicationsController applicationController =
      Get.put(ApplicationsController(), permanent: true);
  Color primaryColor = Color.fromARGB(255, 26, 85, 154);

  // instance of fireStore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Map<String, String> lastMessageTextMap = {};
  Map<String, Timestamp> lastMessageTimeMap = {};
  Map<String, bool> isUnreadMap = {};
  Map<String, Application> approvedApplications = {};

  String currentUserId = "";
  String currentUserEmail = "";

  @override
  void initState() {
    super.initState();
    currentUserId = loginController.userDto!["id"].toString();
    var email = loginController.userDto!["email"];
    if (email == null) return;
    currentUserEmail = email;
    loadData();
    setState(() {});
  }

  Future<void> loadData() async {
    // Check if data is already loaded to avoid duplication
    if (!isLoading) {
      return;
    }

    await applicationController
        .getApprovedApplicationsForUser(loginController.userDto?["id"]);
    print(applicationController.approvedApplicationsForUser);

    // Set isLoading to false only after data is loaded
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

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
    // Within the same week
    else if (difference.inDays < 7 && now.weekday != messageTime.weekday) {
      return DateFormat('EEEE', 'en_US').format(messageTime);
    }
    // Format: ShortMonthName Day
    else {
      return DateFormat('MMM dd', 'en_US').format(messageTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Messages",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: applicationController.approvedApplicationsForUser.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/chat.svg',
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Oops! No chat found",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            )
          : _buildUserList(onMessageSent: () {
              // Callback function to be called when a new message is sent
              // This will trigger a rebuild of the Messages widget
              if (mounted) {
                setState(() {});
              }
            }),
    );
  }

  Widget _buildUserList({required Function onMessageSent}) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text("error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center();
        }

        // Filter users based on the condition
        List<DocumentSnapshot> filteredUsers = snapshot.data!.docs.where((doc) {
          Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
          return data['email'] != currentUserEmail &&
              applicationController.approvedApplicationsForUser.any(
                (application) =>
                    application.user.email == data['email'] ||
                    application.property.user?.email == data['email'],
              );
        }).toList();

        // Find the corresponding application
        List<Application> userApplications = filteredUsers.map((doc) {
          Map<String, dynamic> userData = doc.data()! as Map<String, dynamic>;
          return applicationController.approvedApplicationsForUser.firstWhere(
            (application) =>
                application.user.email == userData['email'] ||
                application.property.user?.email == userData['email'],
          );
        }).toList();

        print(userApplications);
        print(filteredUsers);

        return ListView.builder(
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            return _buildUserItem(
                filteredUsers[index], userApplications[index], onMessageSent);
          },
        );
      },
    );
  }

  Widget _buildUserItem(DocumentSnapshot document, Application application,
      Function onMessageSent) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    // Construct chat room id from sender id and receiver id (sorted to ensure uniqueness)
    String receiverUserId = data['uid'];
    List<String> ids = [currentUserId, receiverUserId];
    ids.sort();
    String chatRoomId = ids.join("_");
    print(application);

    // Use FutureBuilder to wait for the completion of asynchronous operations
    return FutureBuilder(
      future: _createChatRoomDocument(
          chatRoomId, currentUserId, currentUserEmail, receiverUserId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return _buildUserListItem(
              chatRoomId, data, application, onMessageSent);
        } else {
          return shimmer(data);
        }
      },
    );
  }

  Widget _buildUserListItem(String chatRoomId, Map<String, dynamic> data,
      Application application, Function onMessageSent) {
    String lastMessageText = lastMessageTextMap[chatRoomId] ?? "";
    Timestamp lastMessageTime =
        lastMessageTimeMap[chatRoomId] ?? Timestamp.now();

    bool isUnread = isUnreadMap[chatRoomId] ?? false;
    print(isUnread);

    return Container(
      height: 85,
      child: ListTile(
        title: Row(
          children: [
            const SizedBox(width: 10),
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.orange[700],
              ),
              child: Center(
                child: Text(
                  loginController.getShortenedName(data['name']),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  data['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.5,
                    color: Colors.orange[700],
                  ),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      lastMessageText.length > 20
                          ? "${lastMessageText.substring(0, 20)}..."
                          : lastMessageText,
                      style: TextStyle(
                        fontSize: isUnread ? 13 : 14.5,
                        fontWeight:
                            isUnread ? FontWeight.w500 : FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Text(
              formatMessageTimestamp(lastMessageTime),
              style: TextStyle(
                fontSize: isUnread ? 13 : 14.5,
                fontWeight: isUnread ? FontWeight.w500 : FontWeight.bold,
              ),
            ),
          ],
        ),
        onTap: () {
          Get.to(() => ChatPage(
                receiverUserEmail: data['name'],
                receiverUserID: data['uid'],
                onMessageSent: onMessageSent,
                application: application,
              ));
        },
      ),
    );
  }

  Future<void> _createChatRoomDocument(String chatRoomId, String currentUserId,
      String currentUserEmail, String receiverUserId) async {
    try {
      QuerySnapshot messagesSnapshot = await _fireStore
          .collection("chat_rooms")
          .doc(chatRoomId)
          .collection("messages")
          .get();

      if (messagesSnapshot.docs.isEmpty) {
        // No message between them, send welcome message
        Message newMessage = Message(
          senderId: currentUserId,
          senderEmail: currentUserEmail,
          receiverId: receiverUserId,
          message: "Now you can communicate with each other.",
          timestamp: Timestamp.now(),
        );

        await _fireStore
            .collection("chat_rooms")
            .doc(chatRoomId)
            .collection("messages")
            .add(newMessage.toMap());

        await _fireStore.collection("chat_rooms").doc(chatRoomId).set({
          "$currentUserId SeeMessage": false,
          "$receiverUserId SeeMessage": false,
        });
      }

      messagesSnapshot = await _fireStore
          .collection("chat_rooms")
          .doc(chatRoomId)
          .collection("messages")
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (messagesSnapshot.docs.isNotEmpty) {
        // Check read message for each user separately
        isUnreadMap[chatRoomId] = await _fireStore
            .collection("chat_rooms")
            .doc(chatRoomId)
            .get()
            .then(
              (doc) => doc.data()?["$currentUserId SeeMessage"],
            );

        // Update the maps for each user separately
        DocumentSnapshot lastMessage = messagesSnapshot.docs.first;
        lastMessageTextMap[chatRoomId] = lastMessage.get("message");
        lastMessageTimeMap[chatRoomId] = lastMessage.get("timestamp");
      } else {
        print("No messages found in the chat room");
      }
    } catch (error) {
      print("Error creating chat room document: $error");
    }
  }

  Widget shimmer(Map<String, dynamic> data) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 75,
          child: ListTile(
            title: Row(
              children: [
                const SizedBox(width: 10),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow[900],
                  ),
                  child: Center(
                    child: Text(
                      loginController.getShortenedName(data['name']),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: Text(
                      data['email'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.yellow[900],
                      ),
                    ),
                    subtitle: const Row(
                      children: [
                        Text(
                          "Now you can communicate",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "11:55 PM",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

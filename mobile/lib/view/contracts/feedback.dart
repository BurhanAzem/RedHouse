
import 'package:client/controller/history/history_controller.dart';
import 'package:client/main.dart';
import 'package:client/model/contract.dart';
import 'package:client/model/user.dart';
import 'package:client/view/contracts/contract.dart';
import 'package:client/view/contracts/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'dart:convert';

class Feedback extends StatefulWidget {
  final Contract contract;
  const Feedback({Key? key, required this.contract}) : super(key: key);
  _FeedbackState createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  @override
  Widget build(BuildContext context) {
    HistoryController controller =
        Get.put(HistoryController(), permanent: true);

    void sendFeedback() async {
      String? userDtoJson = sharepref.getString("user");
      Map<String, dynamic> userDto = json.decode(userDtoJson ?? "{}");
      User user = User.fromJson(userDto);
      await controller.sendFeedback(user.id!, widget.contract.id!);
    }

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Send complaint",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              // key: controller.formstate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Rating ",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "${controller.rating}",
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          RatingBarIndicator(
                            rating: controller.rating.toDouble(),
                            itemCount: 5,
                            itemSize: 35,
                            itemBuilder: (context, index) {
                              return const Icon(
                                Icons.star,
                                color: Color.fromARGB(221, 169, 12, 12),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(height: 15),
                  const Row(
                    children: [
                      Text(
                        "Feedback",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 5),
                  Container(
                    child: TextFormField(
                      minLines: 10,
                      maxLines: 20,
                      controller: controller.feedback,
                      style: const TextStyle(),
                      decoration: InputDecoration(
                        // suffixIcon: Icon(Icons.description),
                        hintText:
                            "Example: New house in the center of the city, there is close school and very beautiful view",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        contentPadding: const EdgeInsets.all(5),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(height: 30),
                  Container(
                    width: 340,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onPressed: () {
                        setState(() {});
                        ScaffoldMessenger.of(context).clearSnackBars();
                        SnackBar snackBar = const SnackBar(
                          content: Text("Sent Successfully"),
                          backgroundColor: Colors.blue,
                        );

                        showDialog(
                          context: context,
                          builder: (context) {
                            // Show a loading dialog while processing
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );

                        Get.offAll(() => ContractReview(contract: widget.contract));

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        sendFeedback();
                        // Execute the addPropertyFuture asynchronously and navigate when done
                      },
                      minWidth: 300,
                      height: 45,
                      color: Colors.black87,
                      child: const Center(
                        child: Text(
                          "Send",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

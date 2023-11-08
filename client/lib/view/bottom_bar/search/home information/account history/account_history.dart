import 'package:client/controller/feedback_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key});

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  FeedbackController feedbackController = Get.put(FeedbackController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: feedbackController.feedbackList.length,
              itemBuilder: (context, index) {
                final feedback = feedbackController.feedbackList[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 196, 39, 27),
                            ),
                            child: Center(
                              child: Text(
                                feedbackController
                                    .getShortenedName(feedback.Name),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          SizedBox(
                            width: 270,
                            child: Text(
                              feedback.Name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                              ),
                            ),
                          ),
                          const Icon(Icons.more_vert),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          RatingBarIndicator(
                            rating: feedback.Rating.toDouble(),
                            itemCount: 5,
                            itemSize: 20,
                            itemBuilder: (context, index) {
                              return Icon(Icons.star, color: Colors.blue[700]);
                            },
                          ),
                          const SizedBox(width: 10),
                          Text(
                            DateFormat('MM/dd/yy').format(feedback.RatingDate),
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 7),
                      Text(
                        feedback.Comment,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Was this review helpful?",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                width: 58,
                                child: MaterialButton(
                                  color: feedback.helpful == "Yes"
                                      ? Colors.black
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(
                                        color: Colors.black, width: 1.4),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      feedback.helpful = "Yes";
                                    });
                                  },
                                  height: 35,
                                  child: Center(
                                    child: Text(
                                      "Yes",
                                      style: TextStyle(
                                        color: feedback.helpful == "Yes"
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 7),
                              SizedBox(
                                width: 58,
                                child: MaterialButton(
                                  color: feedback.helpful == "No"
                                      ? Colors.black
                                      : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    side: const BorderSide(
                                        color: Colors.black, width: 1.4),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      feedback.helpful = "No";
                                    });
                                  },
                                  height: 35,
                                  child: Center(
                                    child: Text(
                                      "No",
                                      style: TextStyle(
                                        color: feedback.helpful == "No"
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

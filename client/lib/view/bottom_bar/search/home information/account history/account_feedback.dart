import 'package:client/controller/feedback_controller.dart';
import 'package:client/model/feedback.dart' as ClientFeedback;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FeedbackWidget extends StatefulWidget {
  const FeedbackWidget({super.key});

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  FeedbackController feedbackController = Get.put(FeedbackController());
  TextEditingController commentController = TextEditingController();
  double rating = 0;

  void saveFeedback() {
    if (commentController.text.isNotEmpty && rating > 0) {
      ClientFeedback.Feedback newFeedback = ClientFeedback.Feedback(
        Id: feedbackController.feedbackList.length + 1,
        Name: "Your Name",
        Rating: rating,
        RatingDate: DateTime.now(),
        Comment: commentController.text,
      );

      setState(() {
        feedbackController.feedbackList.add(newFeedback);
      });

      commentController.clear();
      rating = 0;
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: ThemeData(
              dialogBackgroundColor: Colors.white,
            ),
            child: AlertDialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0)),
              ),
              backgroundColor: Colors.white,
              title: const Text('Please enter your comment and rate',
                  style: TextStyle(color: Colors.black)),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.w600)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 7, left: 15, right: 15),
            child: Column(
              children: [
                RatingBar.builder(
                  initialRating: rating,
                  minRating: 1,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                  itemBuilder: (context, _) => Transform.scale(
                    scale: 0.9,
                    child: const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                  onRatingUpdate: (newRating) {
                    setState(() {
                      rating = newRating;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: commentController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.all(12),
                    hintText: 'Add your comment',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 175,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: saveFeedback,
                    height: 45,
                    color: Colors.black87,
                    child: const Center(
                      child: Text(
                        "Save Feedback",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(thickness: 2),
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

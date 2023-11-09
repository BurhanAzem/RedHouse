import 'package:client/model/feedback.dart';
import 'package:get/get.dart';

class FeedbackController extends GetxController {
  String getShortenedName(String? name) {
    if (name != null) {
      final nameParts = name.split(' ');
      if (nameParts.length == 2) {
        return nameParts[0].substring(0, 1) + nameParts[1].substring(0, 1);
      } else if (nameParts.length == 1) {
        return nameParts[0].substring(0, 1);
      }
    }
    return "";
  }

  List<Feedback> feedbackList = [
    Feedback(
      Id: 1,
      Name: "John Doe",
      Rating: 4,
      RatingDate: DateTime.now(),
      Comment:
          "Exceptional service and quality, Great service! Very satisfied, Average experience. Could be better.",
    ),
    Feedback(
      Id: 2,
      Name: "Alice Smith",
      Rating: 3,
      RatingDate: DateTime.now(),
      Comment:
          "Exceptional service and quality, Great service! Very satisfied, Average experience. Could be better.",
    ),
    Feedback(
      Id: 3,
      Name: "Bob Johnson",
      Rating: 5,
      RatingDate: DateTime.now(),
      Comment:
          "Exceptional service and quality, Great service! Very satisfied, Average experience. Could be better.",
    ),
    Feedback(
      Id: 4,
      Name: "John Doe",
      Rating: 4,
      RatingDate: DateTime.now(),
      Comment:
          "Exceptional service and quality, Great service! Very satisfied, Average experience. Could be better.",
    ),
    Feedback(
      Id: 5,
      Name: "Alice Smith",
      Rating: 2,
      RatingDate: DateTime.now(),
      Comment:
          "Exceptional service and quality, Great service! Very satisfied, Average experience. Could be better.",
    ),
    Feedback(
      Id: 6,
      Name: "Bob Johnson",
      Rating: 1,
      RatingDate: DateTime.now(),
      Comment:
          "Exceptional service and quality, Great service! Very satisfied, Average experience. Could be better.",
    ),
  ];
}

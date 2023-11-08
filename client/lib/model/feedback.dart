// ignore_for_file: non_constant_identifier_names

class Feedback {
  int Id;
  // int UserId;
  String Name;
  double Rating;
  DateTime RatingDate;
  String Comment;
  String helpful = "";

  Feedback({
    required this.Id,
    required this.Name,
    required this.Rating,
    required this.RatingDate,
    required this.Comment,
  });
}

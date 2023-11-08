import 'package:get/get.dart';

class AccountInfoContoller extends GetxController {
  String? userDtoJson;
  Map<String, dynamic>? userDto;

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
}

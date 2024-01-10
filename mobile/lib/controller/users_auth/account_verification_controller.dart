import 'package:client/core/class/statusrequest.dart';
import 'package:client/data/users_auth.dart';
import 'package:get/get.dart';

class AccountVerificationController extends GetxController {
  late int userId = 0;
  String cardID = "";
  String personal = "";
  late List<String> downloadUrls = [];
  StatusRequest statusRequest = StatusRequest.loading;

  @override
  VerifyAccount() async {
    downloadUrls.add(cardID);
    downloadUrls.add(personal);
    print(downloadUrls);
    statusRequest = StatusRequest.loading;
    var response = await UserData.verifyAccount(
      userId,
      downloadUrls,
    );

    if (response['statusCode'] == 200) {
      print("================================================== LsitDto");
      print(response['listDto']);
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText:
            "statusCode: ${response['statusCode']}, exceptions: ${response['exceptions']}",
      );
      statusRequest = StatusRequest.failure;
    }
  }
}

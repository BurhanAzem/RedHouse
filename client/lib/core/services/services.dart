import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyServices extends GetxService {
  Future<MyServices> init() async {
    return this;
  }
}

initialServices() async {
  await Get.putAsync(() => MyServices().init());
}

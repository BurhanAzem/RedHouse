import 'package:client/routes.dart';
import 'package:get/get.dart';

abstract class OnBoardingController extends GetxController {
  toOnBoardingOne();
  toOnBoardingTwo();
  toOnBoardingThree();
  toOnBoardingFour();
}

class OnBoardingControllerImp extends OnBoardingController {
  @override
  toOnBoardingFour() {
    Get.offAllNamed(AppRoute.onBoardingFour);
  }

  @override
  toOnBoardingOne() {
    Get.toNamed(AppRoute.onBoardingOne);
  }

  @override
  toOnBoardingThree() {
    Get.toNamed(AppRoute.onBoardingThree);
  }

  @override
  toOnBoardingTwo() {
    Get.toNamed(AppRoute.onBoardingTwo);
  }
}

import 'package:client/routes.dart';
import 'package:get/get.dart';

abstract class OnBoardingController extends GetxController{
  toOnBoardingOne();
  toOnBoardingTwo();
  toOnBoardingThree();
  toOnBoardingFour();

}

class OnBoardingControllerImp extends OnBoardingController {

  
  @override
  void onInit() {
    super.onInit();
  }

 
  
  @override
  toOnBoardingFour() {
    // TODO: implement toOnBoardingFour
    Get.toNamed(AppRoute.onBoardingFour);
  }
  
  @override
  toOnBoardingOne() {
    // TODO: implement toOnBoardingOne
    Get.toNamed(AppRoute.onBoardingOne);
  }
  
  @override
  toOnBoardingThree() {
    // TODO: implement toOnBoardingThree
    Get.toNamed(AppRoute.onBoardingThree);
  }
  
  @override
  toOnBoardingTwo() {
    // TODO: implement toOnBoardingTwo
    Get.toNamed(AppRoute.onBoardingTwo);
  }
}
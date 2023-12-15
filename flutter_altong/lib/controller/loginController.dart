import 'package:flutter_altong/screen/alt_04_main.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  void loginFunc(){
    //TODO 로그인 기능 추가
    print("로그인 함수");
    Get.to(ALT04Main());
  }

}
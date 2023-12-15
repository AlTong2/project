import 'package:flutter_altong/screen/alt_03_Join.dart';
import 'package:flutter_altong/screen/alt_02_login.dart';
import 'package:get/get.dart';

class StartController extends GetxController{

  void toLogin(){
    Get.to(ALT02Login());
  }

  void toJoin(){
    Get.to(ALT03Join());
  }

}
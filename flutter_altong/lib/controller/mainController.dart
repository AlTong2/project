import 'package:flutter_altong/screen/altongJoin.dart';
import 'package:flutter_altong/screen/altongLogin.dart';
import 'package:get/get.dart';

class MainController extends GetxController{

  void toLogin(){
    Get.to(AlTongLogin());
  }

  void toJoin(){
    Get.to(AlTongJoin());
  }

}
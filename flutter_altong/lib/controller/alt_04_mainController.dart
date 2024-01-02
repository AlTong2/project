import 'package:flutter/material.dart';
import 'package:flutter_altong/screen/alt_06_exercise.dart';
import 'package:flutter_altong/screen/alt_05_home.dart';
import 'package:flutter_altong/screen/alt_07_my_page.dart';
import 'package:get/get.dart';

class MainController extends GetxController{

  RxInt index = 0.obs;
  // List<StatelessWidget> page_list = [AltongExercise(), AltongHome(), AltongMyPage()];

  void onItemTepped(int i){
      index.value = i;
      print(index);
  }

}
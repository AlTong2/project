import 'package:flutter/material.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/mainController.dart';
import 'package:flutter_altong/screen/alt_06_exercise.dart';
import 'package:flutter_altong/screen/alt_05_home.dart';
import 'package:flutter_altong/screen/alt_07_my_page.dart';
import 'package:flutter_altong/screen/bar/ALT04bottomNavigation.dart';
import 'package:get/get.dart';

class ALT04Main extends StatefulWidget {
  const ALT04Main({super.key});

  @override
  State<ALT04Main> createState() => _ALT04MainState();
}

class _ALT04MainState extends State<ALT04Main> {

  int _index = 1;
  List<StatelessWidget> page_list = [ALT06Exercise(), ALT05Home(), ALT07MyPage()];
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: MainController(),
      builder: (context) {
        return Scaffold(
          body: //page_list[_index],
          Obx(() {
            _index = Get.find<MainController>().index.value;
            return page_list[_index];
          }),
          bottomNavigationBar : bottomNavi(),
        );
      }
    );
  }
}

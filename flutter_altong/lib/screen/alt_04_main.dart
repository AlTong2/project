import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_04_mainController.dart';
import 'package:flutter_altong/controller/alt_06_exerciseController.dart';
import 'package:flutter_altong/screen/alt_06_exercise.dart';
import 'package:flutter_altong/screen/alt_05_home.dart';
import 'package:flutter_altong/screen/alt_07_my_page.dart';
import 'package:flutter_altong/screen/alt_08_chat.dart';
import 'package:flutter_altong/screen/bar/alt_04_bottomNavigation.dart';
import 'package:get/get.dart';

class ALT04Main extends StatefulWidget {
  const ALT04Main({super.key});


  @override
  State<ALT04Main> createState() => _ALT04MainState();
}

class _ALT04MainState extends State<ALT04Main> {
  final String user = Get.arguments["user"];
  final int kcal = Get.arguments["kcal"];
  int _index = 0;
  late List<StatelessWidget> page_list ;//= [ALT05Home(name: widget.name), ALT06Exercise(), ALT08ChatPage(), ALT07MyPage()];

  @override
  void initState() {
    super.initState();
    Get.put((ExerciseController()));
    Get.put(MainController());
    Get.find<ExerciseController>().getRoutine();
    // 위젯 목록을 생성할 때 name을 사용하여 각 위젯을 초기화합니다.
    print("사용자 : ${user}");
    page_list = [
      ALT05Home(name : user, kcal : kcal),
      ALT06Exercise(),
      ALT08ChatPage(),
      ALT07MyPage(),
    ];
  }
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

import 'package:flutter/material.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/mainController.dart';
import 'package:get/get.dart';

class bottomNavi extends StatefulWidget {
  const bottomNavi({super.key});

  @override
  State<bottomNavi> createState() => _bottomNaviState();
}

class _bottomNaviState extends State<bottomNavi> {
  int _currentIndex = 1; // 초기값 설정
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar( // bottomnavigationbar
      selectedItemColor: AppColors.bottomSelectBtnColor, // 선택된 아이템 색 바꾸기
      backgroundColor: AppColors.bottomNaviBackground, // 바텀네비게이션 배경색 바꾸기
      unselectedItemColor: AppColors.bottomNoSelectBtnColor, // 선택하지 않은 아이콘 색
      showSelectedLabels: false, // 선택된아이콘 라벨 지우기
      showUnselectedLabels: false, // 선택되지 않은 아이콘 라벨지우기
      currentIndex: Get.find<MainController>().index.value,
      onTap : (index) {
          setState(() {
          _currentIndex = index;
          });
          Get.find<MainController>().onItemTepped(index);
      },
      items: [ // list
        BottomNavigationBarItem(icon: Icon(Icons.directions_run),label: "운동"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: "마이페이지"),
      ],
    );
  }
}

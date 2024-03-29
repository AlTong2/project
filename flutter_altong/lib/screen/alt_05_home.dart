import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altong/Firebase.dart';
import 'package:flutter_altong/component/MainComponent/calText.dart';
import 'package:flutter_altong/component/MainComponent/exerciseCalendar.dart';
import 'package:flutter_altong/component/MainComponent/exerciseProgress.dart';
import 'package:flutter_altong/component/MainComponent/homeText.dart';
import 'package:flutter_altong/component/MainComponent/screenNameText.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_02_loginController.dart';
import 'package:get/get.dart';

class ALT05Home extends StatelessWidget {
  const ALT05Home({super.key, required this.name, required this.kcal, required this.recordDay, required this.record, required this.curKcal});
  final String name;
  final int kcal;
  final List<String> recordDay;
  final Map<dynamic, dynamic> record;
  final int curKcal;

  @override
  Widget build(BuildContext context) {
    String screenName = "알통이";
    String userName = name;
    int userKcal = kcal;
    Get.put(LoginController());
    return Scaffold(
      appBar:AppBar(
        title: Row(
          children: [
            Image.asset('img/altong_normal.png', width: MediaQuery.of(context).size.width*0.15,),
            ScreenName(name: screenName),
          ],
        ),
        backgroundColor: AppColors.mainColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.replay, size: 32), // 다른 아이콘으로 변경
            onPressed: () {
              Get.find<LoginController>().reRoad();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width, // 너비 전체 사용
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: AppColors.appBackground
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(user: userName),
                SizedBox(height: 30,),
                // TODO DB에서 가져온 칼로리로 계산하여 표시
                ExerciseProgress(currentKcal: curKcal,goalKcal: userKcal),
                SizedBox(height: 15,),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  decoration:BoxDecoration(
                      color: AppColors.lineGrey
                  ),
                ),
                SizedBox(height: 5,),
                AppNameText(name: "이번달 운동 기록"),
                ExerciseCarlendar(recordDay : recordDay, record: record,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

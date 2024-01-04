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

class ALT05Home extends StatelessWidget {
  const ALT05Home({super.key, required this.name, required this.kcal});
  final String name;
  final int kcal;

  @override
  Widget build(BuildContext context) {
    String screenName = "알통이";
    String userName = name;
    int userKcal = kcal;
    return Scaffold(
      appBar:AppBar(
        title: ScreenName(name: screenName),
        backgroundColor: AppColors.mainColor,
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
                ExerciseProgress(currentKcal: 1600,goalKcal: userKcal),
                SizedBox(height: 5,),
                AppNameText(name: "이번달 운동 기록"),
                ExerciseCarlendar(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

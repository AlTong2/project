import 'package:flutter/material.dart';
import 'package:flutter_altong/component/MainComponent/calText.dart';
import 'package:flutter_altong/component/MainComponent/exerciseCalendar.dart';
import 'package:flutter_altong/component/MainComponent/exerciseProgress.dart';
import 'package:flutter_altong/component/MainComponent/homeText.dart';
import 'package:flutter_altong/component/MainComponent/screenNameText.dart';
import 'package:flutter_altong/constants/constants.dart';

class ALT05Home extends StatelessWidget {
  const ALT05Home({super.key});

  @override
  Widget build(BuildContext context) {
    String screenName = "알통이";
    String user = "test1"; //TODO DB에서 받아온 유저값으로 변경할것
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.appBackground
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScreenName(name: screenName),
              MainText(user: user),
              SizedBox(height: 30,),
              // TODO DB에서 가져온 칼로리로 계산하여 표시
              ExerciseProgress(currentKcal: 700,goalKcal: 3700),
              SizedBox(height: 5,),
              AppNameText(name: "이번달 운동 기록"),
              ExerciseCarlendar(),
            ],
          ),
        ),
      ),
    );
  }
}

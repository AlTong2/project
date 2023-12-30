import 'package:flutter/material.dart';
import 'package:flutter_altong/component/StartComponent/startBtn.dart';
import 'package:flutter_altong/component/StartComponent/startImg.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_01_startController.dart';
import 'package:flutter_altong/screen/alt_03_Join.dart';
import 'package:flutter_altong/screen/alt_02_login.dart';
import 'package:get/get.dart';

class ALT01Start extends StatelessWidget {
  const ALT01Start({super.key});
  // MainController mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    String loginBtnText = "로그인";
    String joinBtnText = "회원가입";
    Get.put(StartController());
    return Scaffold(
      body:SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.appBackground
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MainImg(image: Image.asset("img/logo_altong.gif", width: 200,height: 200,),),
                MainBtn(text: loginBtnText, btnFunc: () => Get.find<StartController>().toLogin(), color: AppColors.mainColor),
                MainBtn(text: joinBtnText, btnFunc: () => Get.find<StartController>().toJoin(), color: AppColors.mainColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


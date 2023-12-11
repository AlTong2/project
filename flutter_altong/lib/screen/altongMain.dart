import 'package:flutter/material.dart';
import 'package:flutter_altong/component/MainComponent/mainBtn.dart';
import 'package:flutter_altong/component/MainComponent/mainImg.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/mainController.dart';
import 'package:flutter_altong/screen/altongJoin.dart';
import 'package:flutter_altong/screen/altongLogin.dart';
import 'package:get/get.dart';

class AltongMain extends StatelessWidget {
  const AltongMain({super.key});
  // MainController mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    String loginBtnText = "로그인";
    String joinBtnText = "회원가입";
    Get.put(MainController());
    return Scaffold(
      body:SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              MainImg(image: Image.asset("img/logo_altong.gif", width: 200,height: 200,),),
              MainBtn(text: loginBtnText, btnFunc: () => Get.find<MainController>().toLogin(), color: AppColors.btnColor),
              MainBtn(text: joinBtnText, btnFunc: () => Get.find<MainController>().toJoin(), color: AppColors.btnColor),
            ],
          ),
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_altong/component/JoinComponent/kcalTextField.dart';
import 'package:flutter_altong/component/LoginComponent/loginPasswordTextField.dart';
import 'package:flutter_altong/component/MainComponent/screenNameText.dart';
import 'package:flutter_altong/component/editProfileComponent/editBtn.dart';
import 'package:flutter_altong/component/editProfileComponent/editTextField.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:get/get.dart';

class ALT09EditProfilePage extends StatelessWidget {
  const ALT09EditProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    String myPage = "마이페이지";
    String editProfile = "회원정보 수정";
    String changePassword = "변경할 비밀번호";
    String passwordConfirm = "비밀번호 확인";
    String changeKcal = "주간 목표 칼로리";
    TextEditingController pwCon = TextEditingController();
    TextEditingController pwconfirmCon = TextEditingController();
    TextEditingController kcalCon = TextEditingController();
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.mainColor,
          actions: [
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'close',
            onPressed: () {
              Get.back();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.appBackground
          ),
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ScreenName(name: editProfile),
                ],
              ),
              SizedBox(height: 25,),
              Column(
                children: [
                  LoginPasswordTextField(icon: Icons.key, text: changePassword, con: pwCon),
                  LoginPasswordTextField(icon: Icons.key, text: passwordConfirm, con: pwconfirmCon),
                  KcalTextField(icon: Icons.directions_run, text: changeKcal, con: kcalCon),
                  SizedBox(height: 25,),
                  EditButton(text: "수정하기", btnFunc: (){}, color: AppColors.mainColor)
                ],
              ),
            ],
          ),
        ),
      ),
    );;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_altong/component/JoinComponent/joinTextField.dart';
import 'package:flutter_altong/component/JoinComponent/kcalTextField.dart';
import 'package:flutter_altong/component/LoginComponent/loginPasswordTextField.dart';
import 'package:flutter_altong/component/MainComponent/screenNameText.dart';
import 'package:flutter_altong/component/editProfileComponent/editBtn.dart';
import 'package:flutter_altong/component/editProfileComponent/editTextField.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_07_mypageController.dart';
import 'package:get/get.dart';

class ALT09EditProfilePage extends StatefulWidget {
  const ALT09EditProfilePage({super.key});

  @override
  State<ALT09EditProfilePage> createState() => _ALT09EditProfilePageState();
}

class _ALT09EditProfilePageState extends State<ALT09EditProfilePage> {
  TextEditingController nameCon = TextEditingController();
  TextEditingController curCon = TextEditingController();
  TextEditingController pwCon = TextEditingController();
  TextEditingController pwConfirmCon = TextEditingController();
  TextEditingController kcalCon = TextEditingController();
  String _pw = "";
  String _pwConfirm = "";
  String _name = "";
  String _kcal = "";

  @override
  void initState () {
    super.initState();

    pwCon.addListener(() {
      setState(() {
        _pw = pwCon.text;
      });
    });
    pwConfirmCon.addListener(() {
      setState(() {
        _pwConfirm = pwConfirmCon.text;
      });
    });
    nameCon.addListener(() {
      setState(() {
        _name = nameCon.text;
      });
    });
    kcalCon.addListener(() {
      setState(() {
        _kcal = kcalCon.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String myPage = "마이페이지";
    String editProfile = "회원정보 수정";
    String currentPassword = "현재 비밀번호";
    String changePassword = "변경할 비밀번호";
    String passwordConfirm = "비밀번호 확인";
    String changeKcal = "주간 목표 칼로리";
    String nameText = "닉네임";

    Get.put(MyPageController());
    return GestureDetector(
        onTap: () {
          if (FocusScope.of(context).hasFocus) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title:
              ScreenName(name: editProfile),
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
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: AppColors.appBackground
              ),
              width: MediaQuery.of(context).size.width, // 너비 전체 사용
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Column(
                    children: [
                      JoinTextField(icon: Icons.man, text: nameText, con: nameCon),
                      LoginPasswordTextField(icon: Icons.key, text: currentPassword, con: curCon, validator: null),
                      LoginPasswordTextField(icon: Icons.key, text: changePassword, con: pwCon, validator: null),
                      LoginPasswordTextField(icon: Icons.key, text: passwordConfirm, con: pwConfirmCon, validator: null,),
                      KcalTextField(icon: Icons.directions_run, text: changeKcal, con: kcalCon),
                      SizedBox(height: 25,),
                      EditButton(text: "수정하기", btnFunc: ()=> Get.find<MyPageController>().updateUser(nameCon.text, curCon.text, pwCon.text, kcalCon.text), color: AppColors.mainColor)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

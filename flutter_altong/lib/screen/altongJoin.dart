import 'package:flutter/material.dart';
import 'package:flutter_altong/component/JoinComponent/JoinBtn.dart';
import 'package:flutter_altong/component/JoinComponent/joinTextField.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/joinController.dart';
import 'package:get/get.dart';

class AlTongJoin extends StatelessWidget {
  const AlTongJoin ({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(JoinController());
    TextEditingController idCon = TextEditingController();
    TextEditingController emailCon = TextEditingController();
    TextEditingController pwCon = TextEditingController();
    TextEditingController pwconfirmCon = TextEditingController();
    TextEditingController kcalCon = TextEditingController();
    String joinText = "회원가입";
    String idText = "아이디";
    String emailText = "이메일";
    String pwText = "비밀번호";
    String pwConfirmText = "비밀번호 확인";
    String kcalText = "칼로리";

    return Scaffold(
      appBar: AppBar(title: Text(joinText),backgroundColor: AppColors.btnColor,),
      body: SafeArea(
        child: Column(
          children: [
            JoinTextField(icon: Icons.account_circle, text: idText, con: idCon),
            JoinTextField(icon: Icons.email, text: emailText, con: emailCon),
            //TODO 눈모양해서 비밀번호 표시
            JoinTextField(icon: Icons.key, text: pwText, con: pwCon),
            JoinTextField(icon: Icons.key, text: pwConfirmText, con: pwconfirmCon),
            //TODO 칼로리 뒷부분 Kcal글자 표시
            JoinTextField(icon: Icons.directions_run, text: kcalText, con: kcalCon),
            SizedBox(height: 50,),
            JoinBtn(text: joinText, btnFunc: () => Get.find<JoinController>().joinFunc(), color: AppColors.btnColor),
          ],
        ),
      ),
    );
  }
}

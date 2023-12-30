import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altong/component/JoinComponent/JoinBtn.dart';
import 'package:flutter_altong/component/JoinComponent/joinTextField.dart';
import 'package:flutter_altong/component/JoinComponent/kcalTextField.dart';
import 'package:flutter_altong/component/LoginComponent/loginPasswordTextField.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_03_joinController.dart';
import 'package:get/get.dart';

class ALT03Join extends StatelessWidget {


  /*
  final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
  email: emailAddress,
  password: password
  );
  FirebaseAuth.instance.
  */

  @override
  Widget build(BuildContext context) {
    Get.put(JoinController());
    TextEditingController idCon = TextEditingController();
    TextEditingController emailCon = TextEditingController();
    TextEditingController nameCon = TextEditingController();
    TextEditingController pwCon = TextEditingController();
    TextEditingController pwconfirmCon = TextEditingController();
    TextEditingController kcalCon = TextEditingController();
    String joinText = "회원가입";
    String idText = "아이디";
    String emailText = "이메일";
    String nameText = "닉네임";
    String pwText = "비밀번호";
    String pwConfirmText = "비밀번호 확인";
    String kcalText = "칼로리";


    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text(joinText),backgroundColor: AppColors.mainColor,),
        body: SafeArea(
            child: Container(
            decoration: BoxDecoration(
                color: AppColors.appBackground
            ),
            child: Column(
              children: [
                JoinTextField(icon: Icons.account_circle, text: idText, con: idCon),
                JoinTextField(icon: Icons.email, text: emailText, con: emailCon),
                JoinTextField(icon: Icons.man, text: nameText, con: nameCon),
                //TODO 눈모양해서 비밀번호 표시
                LoginPasswordTextField(icon: Icons.key, text: pwText, con: pwCon),
                LoginPasswordTextField(icon: Icons.key, text: pwConfirmText, con: pwconfirmCon),
                //TODO 칼로리 뒷부분 Kcal글자 표시
                KcalTextField(icon: Icons.directions_run, text: kcalText, con: kcalCon),
                SizedBox(height: 50,),
                JoinBtn(text: joinText, btnFunc: () => Get.find<JoinController>().joinFunc(emailCon.text, pwCon.text, nameCon.text, kcalCon.text), color: AppColors.mainColor),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

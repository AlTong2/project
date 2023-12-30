import 'package:flutter/material.dart';
import 'package:flutter_altong/component/LoginComponent/loginBtn.dart';
import 'package:flutter_altong/component/LoginComponent/loginPasswordTextField.dart';
import 'package:flutter_altong/component/LoginComponent/loginTextField.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_02_loginController.dart';
import 'package:get/get.dart';

class ALT02Login extends StatelessWidget {
  const ALT02Login ({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    TextEditingController emailCon = TextEditingController();
    TextEditingController pwCon = TextEditingController();

    String idText = "이메일";
    String passwordText = "비밀번호";
    String loginText = "로그인";


    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
       },
      child: Scaffold(
        appBar: AppBar(
          title: Text(loginText),
          backgroundColor: AppColors.mainColor,),
        body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.appBackground
          ),
          child: Column(
            children: [
              LoginTextField(
                con: emailCon,
                icon: Icons.email,
                text: idText,
              ),
              LoginPasswordTextField(icon: Icons.key, text: passwordText, con: pwCon),
              SizedBox(height: 50,),
              LoginBtn(
                text: loginText,
                btnFunc: ()=> Get.find<LoginController>().loginFunc(emailCon.text, pwCon.text),
                color: AppColors.mainColor,
              )
            ],
          ),
        ),
      ),
      ),
    );
  }
}

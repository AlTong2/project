import 'package:flutter/material.dart';
import 'package:flutter_altong/component/LoginComponent/loginBtn.dart';
import 'package:flutter_altong/component/LoginComponent/loginTextField.dart';
import 'package:flutter_altong/controller/loginController.dart';
import 'package:get/get.dart';

class AlTongLogin extends StatelessWidget {
  const AlTongLogin ({super.key});

  @override
  Widget build(BuildContext context) {
    String idText = "아이디";
    String passwordText = "비밀번호";
    String loginText = "로그인";
    Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(
        title: Text("로그인"),
      ),
      body: SafeArea(
      child: Column(
        children: [
          LoginTextField(
            icon: Icons.account_circle,
            text: idText,
          ),
          LoginTextField(
            icon: Icons.key,
            text: passwordText,
          ),
          LoginBtn(
            text: loginText,
            btnFunc: ()=> Get.find<LoginController>().Loginfunc(),
            color: Colors.brown,
          )
        ],
      ), 
    ),
    );
  }
}

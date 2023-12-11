import 'package:flutter/material.dart';
import 'package:flutter_altong/component/LoginComponent/loginBtn.dart';
import 'package:flutter_altong/component/LoginComponent/loginTextField.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/loginController.dart';
import 'package:get/get.dart';

class AlTongLogin extends StatelessWidget {
  const AlTongLogin ({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    TextEditingController idCon = TextEditingController();
    TextEditingController pwCon = TextEditingController();

    String idText = "아이디";
    String passwordText = "비밀번호";
    String loginText = "로그인";


    return Scaffold(
      appBar: AppBar(
        title: Text(loginText),
        backgroundColor: AppColors.btnColor,),
      body: SafeArea(
      child: Column(
        children: [
          LoginTextField(
            con: idCon,
            icon: Icons.account_circle,
            text: idText,
          ),
          LoginTextField(
            con: pwCon,
            icon: Icons.key,
            text: passwordText,
          ),
          SizedBox(height: 50,),
          LoginBtn(
            text: loginText,
            btnFunc: ()=> Get.find<LoginController>().loginFunc(),
            color: AppColors.btnColor,
          )
        ],
      ), 
    ),
    );
  }
}

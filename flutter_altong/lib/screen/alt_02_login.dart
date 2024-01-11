import 'package:flutter/material.dart';
import 'package:flutter_altong/component/LoginComponent/loginBtn.dart';
import 'package:flutter_altong/component/LoginComponent/loginPasswordTextField.dart';
import 'package:flutter_altong/component/LoginComponent/loginTextField.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_02_loginController.dart';
import 'package:get/get.dart';

class ALT02Login extends StatefulWidget {
  const ALT02Login ({super.key});

  @override
  State<ALT02Login> createState() => _ALT02LoginState();
}

class _ALT02LoginState extends State<ALT02Login> {

  TextEditingController emailCon = TextEditingController();
  TextEditingController pwCon = TextEditingController();
  String _email = "";
  String _pw = "";

  @override
  void initState () {
    super.initState();
    emailCon.addListener(() {
      setState(() {
        _email = emailCon.text;
      });
    });
    pwCon.addListener(() {
      setState(() {
        _pw = pwCon.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());


    String idText = "E-Mail";
    String passwordText = "Password";
    String loginText = "로그인";


    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
       },
      child: Scaffold(
        appBar: AppBar(
          title: Text(loginText, style: TextStyle(fontFamily: 'pre')),
          backgroundColor: AppColors.mainColor,),
        body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.appBackground
          ),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                LoginTextField(
                  con: emailCon,
                  icon: Icons.email,
                  text: idText,
                ),
                LoginPasswordTextField(icon: Icons.key, text: passwordText, con: pwCon, validator: null),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("아직 회원이 아니시라면 ?", style :TextStyle(fontFamily: 'pre', fontSize: MediaQuery.of(context).size.width * 0.03)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width* 0.3,
                      child: TextButton(
                        onPressed: () {

                        },
                        child: Text("회원가입", style: TextStyle(fontFamily: 'pre', fontSize: MediaQuery.of(context).size.width * 0.03)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:10,),
                LoginBtn(
                  text: loginText,
                  btnFunc: ()=> Get.find<LoginController>().loginFunc(emailCon.text, pwCon.text),
                  color: AppColors.mainColor,
                )
            ]
          ),
        ),
        ),
      ),
    )
    );
  }
}

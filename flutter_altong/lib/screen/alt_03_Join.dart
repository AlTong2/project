import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altong/component/JoinComponent/JoinBtn.dart';
import 'package:flutter_altong/component/JoinComponent/joinTextField.dart';
import 'package:flutter_altong/component/JoinComponent/kcalTextField.dart';
import 'package:flutter_altong/component/LoginComponent/loginPasswordTextField.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_03_joinController.dart';
import 'package:get/get.dart';

class ALT03Join extends StatefulWidget {


  @override
  State<ALT03Join> createState() => _ALT03JoinState();
}

class _ALT03JoinState extends State<ALT03Join> {

  TextEditingController idCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  TextEditingController pwCon = TextEditingController();
  TextEditingController pwConfirmCon = TextEditingController();
  TextEditingController kcalCon = TextEditingController();
  String joinText = "회원가입";
  String idText = "아이디";
  String emailText = "이메일";
  String nameText = "닉네임";
  String pwText = "비밀번호";
  String pwConfirmText = "비밀번호 확인";
  String kcalText = "주간 목표 칼로리";
  String _id = "";
  String _email = "";
  String _pw = "";
  String _pwConfirm = "";
  String _name = "";
  String _kcal = "";

  @override
  void initState () {
    super.initState();
    idCon.addListener(() {
      setState(() {
        _id = idCon.text;
        print(_id);
      });
    });
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
    Get.put(JoinController());

    var scaffoldKey = GlobalKey<ScaffoldState>();
    return GestureDetector(
      onTap: () {
        if (FocusScope.of(context).hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: Text(joinText,style: TextStyle(fontFamily: 'pre')), backgroundColor: AppColors.mainColor,),
        body: SafeArea(
            child: Container(
            decoration: BoxDecoration(
                color: AppColors.appBackground
            ),
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  JoinTextField(icon: Icons.email, text: emailText, con: emailCon),
                  JoinTextField(icon: Icons.man, text: nameText, con: nameCon),
                  LoginPasswordTextField(icon: Icons.key, text: pwText, con: pwCon, validator: null),
                  LoginPasswordTextField(icon: Icons.key, text: pwConfirmText, con: pwConfirmCon,
                      validator: (_pw) => Get.find<JoinController>().validatePassword(_pw)),
                  KcalTextField(icon: Icons.directions_run, text: kcalText, con: kcalCon),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("이미 회원 이라면?", style :TextStyle(fontFamily: 'pre', fontSize: MediaQuery.of(context).size.width * 0.04)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width* 0.2,
                        child: TextButton(
                          onPressed: () {

                          },
                          child: Text("로그인", style: TextStyle(fontFamily: 'pre', fontSize: MediaQuery.of(context).size.width * 0.04)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height:10,),
                  JoinBtn(text: joinText, btnFunc: () => Get.find<JoinController>().joinFunc(emailCon.text, pwCon.text, nameCon.text, kcalCon.text), color: AppColors.mainColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

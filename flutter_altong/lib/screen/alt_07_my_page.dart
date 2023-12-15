import 'package:flutter/material.dart';
import 'package:flutter_altong/component/MainComponent/screenNameText.dart';
import 'package:flutter_altong/component/MypageComponent/myPageBtn.dart';
import 'package:flutter_altong/component/MypageComponent/myPageText.dart';

class ALT07MyPage extends StatelessWidget {
  const ALT07MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    String myPage = "마이페이지";
    String user = "test1"; //TODO DB에서 받아온 유저값으로 변경할것
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ScreenName(name: myPage),
                ],
              ),
              SizedBox(height: 25,),
              MyPageText(user: user),
              SizedBox(height: 90,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyPageBtn(text: "회원정보 수정", btnFunc: (){}),
                  MyPageBtn(text: "블루투스 연결", btnFunc: (){}),
                  MyPageBtn(text: "녹화영상 확인", btnFunc: (){}),],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

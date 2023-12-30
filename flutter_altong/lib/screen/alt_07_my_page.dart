import 'package:flutter/material.dart';
import 'package:flutter_altong/component/MainComponent/screenNameText.dart';
import 'package:flutter_altong/component/MypageComponent/myPageBtn.dart';
import 'package:flutter_altong/component/MypageComponent/myPageText.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/screen/alt_09_edit_profile.dart';
import 'package:get/get.dart';

class ALT07MyPage extends StatelessWidget {
  const ALT07MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    String myPage = "마이페이지";
    String user = "test1"; //TODO DB에서 받아온 유저값으로 변경할것
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(myPage),
        backgroundColor: AppColors.mainColor,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.account_circle), // 다른 아이콘으로 변경
            onPressed: () {
              scaffoldKey.currentState!.openEndDrawer();
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ALT09EditProfilePage(),
        width: double.infinity,
      ),
      endDrawerEnableOpenDragGesture: true,
      /*Drawer(
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(
              child: new UserAccountsDrawerHeader(
                accountName: new Text('Vinoth Kumar'),
                accountEmail: new Text('vinoth1094@gmail.com'),
                currentAccountPicture: new CircleAvatar(
                    backgroundImage: new NetworkImage(
                        'https://scontent.fmaa1-1.fna.fbcdn.net/v/t1.0-9/16196015_10154888128487744_6901111466535510271_n.png?_nc_cat=0&oh=b987a0608ad9dad1beff57c489e53221&oe=5BB865E9')),
              ),
              padding: const EdgeInsets.all(0.0),
              margin: const EdgeInsets.all(0.0),
            ),
          ],
        ),
      ),*/
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.appBackground
          ),
          width: double.infinity,
          child: Column(
            children: [
              SizedBox(height: 25,),
              MyPageText(user: user),
              SizedBox(height: 90,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyPageBtn(text: "블루투스 연결", btnFunc: (){}),
                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

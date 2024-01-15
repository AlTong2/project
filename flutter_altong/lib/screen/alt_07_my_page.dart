import 'package:flutter/material.dart';
import 'package:flutter_altong/component/MainComponent/screenNameText.dart';
import 'package:flutter_altong/component/MypageComponent/myPageBtn.dart';
import 'package:flutter_altong/component/MypageComponent/myPageText.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_07_mypageController.dart';
import 'package:flutter_altong/screen/alt_09_edit_profile.dart';
import 'package:get/get.dart';

class ALT07MyPage extends StatefulWidget {
  const ALT07MyPage({super.key, required this.name});
  final String name;

  @override
  State<ALT07MyPage> createState() => _ALT07MyPageState();
}

class _ALT07MyPageState extends State<ALT07MyPage> {
  @override
  Widget build(BuildContext context) {
    String myPage = "마이페이지";
    String user = widget.name;
    var scaffoldKey = GlobalKey<ScaffoldState>();
    Get.put(MyPageController());
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('img/altong_my.png', width: MediaQuery.of(context).size.width*0.15,),
            ScreenName(name: myPage),
          ],
        ),
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
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.appBackground
          ),
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: 25,),
              MyPageText(user: user),
              SizedBox(height: 90,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MyPageBtn(text: "블루투스 연결", btnFunc: (){
                    Get.find<MyPageController>().getConnectedDevices();
                    Get.find<MyPageController>().scanBluetoothDevices();
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Obx( ()=>AlertDialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          content: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: MediaQuery.of(context).size.height * 0.5,
                            child:
                                ListView.builder(
                                itemCount:  Get.find<MyPageController>().scanResultsInfo.length,
                                itemBuilder:(context, index) {
                                  return Text("장치 : ${Get.find<MyPageController>().scanResultsInfo[index]["name"]}", style: TextStyle(fontSize: 12),);
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  // MyPageBtn(text: "블루투스 연결", btnFunc: (){}),
                  MyPageBtn(text: "로그아웃", btnFunc: ()=> Get.find<MyPageController>().logout()),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(top:MediaQuery.of(context).size.height*0.155,left:MediaQuery.of(context).size.width*0.25),
                    child: Stack(
                      children: [
                        Opacity(
                        opacity: 0.5, // 0.0부터 1.0까지의 값 (0.0: 완전 투명, 1.0: 완전 불투명)
                        child: Image.asset('img/launch_image_op.png', width: MediaQuery.of(context).size.width*0.8),
                      ),
                      ]
                    ),
                  )
                  ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

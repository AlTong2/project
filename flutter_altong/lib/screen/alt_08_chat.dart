import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altong/component/ChatComponent/chatBubble.dart';
import 'package:flutter_altong/component/ChatComponent/chatTextFormat.dart';
import 'package:flutter_altong/component/MainComponent/screenNameText.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_08_chatController.dart';
import 'package:get/get.dart';

class ALT08ChatPage extends StatelessWidget {
  const ALT08ChatPage({super.key});


  @override
  Widget build(BuildContext context) {
    TextEditingController genderCon = TextEditingController();
    TextEditingController ageCon = TextEditingController();
    TextEditingController heightCon = TextEditingController();
    TextEditingController weightCon = TextEditingController();
    TextEditingController activityLevelCon = TextEditingController();
    TextEditingController goalWeightCon = TextEditingController();
    String chat = "알톡이";
    Get.put(ChatController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar:AppBar(
          title: Row(
            children: [
              Image.asset('img/gpt_icon_white.png', width: MediaQuery.of(context).size.width*0.07,),
              ScreenName(name: chat),
            ],
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body: SafeArea(
          bottom: true,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.appBackground
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          reverse: true,
                          child: Column(
                            children: <Widget>[
                              Obx(() => ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: Get.find<ChatController>().messages.length,
                                itemBuilder: (context, index) {
                                  return ListTile( title : ChatBubble(text: Get.find<ChatController>().messages[index], answer: Get.find<ChatController>().answer[index]));
                                },
                              )),
                              SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.1,
                        right: 10,
                        child: Container(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:AppColors.mainColor
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                      ),
                                      content: Container(
                                        width: MediaQuery.of(context).size.width * 0.7,
                                        height: MediaQuery.of(context).size.height * 0.5,
                                        child: ListView(
                                          children: [
                                            ChatTextFormat(text: "성별", con: genderCon),
                                            ChatTextFormat(text: "나이", con: ageCon),
                                            ChatTextFormat(text: "키", con: heightCon),
                                            ChatTextFormat(text: "몸무게", con: weightCon),
                                            ChatTextFormat(text: "활동 수준", con: activityLevelCon),
                                            ChatTextFormat(text: "목표 체중", con: goalWeightCon),
                                            ElevatedButton(onPressed: () {
                                              if (genderCon.text.isNotEmpty &&
                                                  ageCon.text.isNotEmpty &&
                                                  heightCon.text.isNotEmpty &&
                                                  weightCon.text.isNotEmpty &&
                                                  activityLevelCon.text.isNotEmpty &&
                                                  goalWeightCon.text.isNotEmpty) {
                                                // 모든 입력 필드가 비어있지 않을 때 동작 수행
                                                Get.find<ChatController>().sendFormat(
                                                  genderCon.text,
                                                  ageCon.text,
                                                  heightCon.text,
                                                  weightCon.text,
                                                  activityLevelCon.text,
                                                  goalWeightCon.text,
                                                );
                                              } else {
                                                // 빈 입력 필드가 있을 경우 아무 동작도 수행하지 않음
                                                // 또는 에러 메시지 출력 또는 다른 처리를 추가할 수 있음
                                              }
                                            },
                                                child: Text("보내기", style: TextStyle(fontFamily: 'pre'),))
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Text("운동 관련 질문", style: TextStyle(color: Colors.white,fontFamily: 'pre')),
                            ),
                        )
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: MessageBar(
                            onSend: (_) => Get.find<ChatController>().sendMessage(_),
                            sendButtonColor: AppColors.bottomSelectBtnColor,
                            messageBarHitText : "질문을 입력해주세요.",
                            messageBarHintStyle : TextStyle(fontSize: MediaQuery.of(context).size.width*0.03, fontFamily: 'pre'),
                            actions: [
                              /*
                              InkWell(
                                child: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 24,
                                ),
                                onTap: () {},
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 8, right: 8),
                                child: InkWell(
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.green,
                                    size: 24,
                                  ),
                                  onTap: () {},
                                ),
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          )
          ),
        ),
    );
  }
}

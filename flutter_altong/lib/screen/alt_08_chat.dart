import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altong/component/ChatComponent/answerChat.dart';
import 'package:flutter_altong/component/ChatComponent/senderChat.dart';
import 'package:flutter_altong/component/MainComponent/screenNameText.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_08_chatController.dart';
import 'package:get/get.dart';

class ALT08ChatPage extends StatelessWidget {
  const ALT08ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    String Chat = "채팅(GPT 3.5 Turbo)";
    Get.put(ChatController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          bottom: true,
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.appBackground
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenName(name: Chat),
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
                                  if(index % 2 == 0){
                                    return ListTile( title : SenderChat(text: Get.find<ChatController>().messages[index]));
                                  } else {
                                    return ListTile( title : AnswerChat(text: Get.find<ChatController>().messages[index]));
                                  }
                                },
                              )),
                              SizedBox(
                                height: 100,
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: MessageBar(
                            onSend: (_) => Get.find<ChatController>().sendMessage(_),
                            sendButtonColor: AppColors.bottomSelectBtnColor,
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

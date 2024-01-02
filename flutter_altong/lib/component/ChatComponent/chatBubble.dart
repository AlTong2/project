import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altong/constants/constants.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.text, required this.answer});
  final String text;
  final bool answer;
  @override
  Widget build(BuildContext context) {
    if(answer){
      return BubbleSpecialOne(
        text: text,
        color: AppColors.bottomSelectBtnColor,
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      );
    }else{
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 10, left: 10),
            child: Row(
              children: [
                Container(
                  width: 45,
                  height: 45,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                          image:AssetImage('img/altong_profile.png'),
                          fit: BoxFit.cover
                      )
                  ),
                ),
                Text("알통이", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w200),)
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40),
            child: Container(
              child: Row(
                children: [
                  BubbleSpecialOne(
                    text: text,
                    color: AppColors.bottomNoSelectBtnColor,
                    isSender: false,
                    textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

  }
}

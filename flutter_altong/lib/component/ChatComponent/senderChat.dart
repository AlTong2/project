import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altong/constants/constants.dart';

class SenderChat extends StatelessWidget {
  const SenderChat({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return BubbleSpecialOne(
      text: text,
      color: AppColors.bottomSelectBtnColor,
      textStyle: TextStyle(
        fontSize: 20,
        color: Colors.white,
      ),
    );
  }
}

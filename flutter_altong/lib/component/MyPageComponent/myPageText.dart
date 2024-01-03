import 'package:flutter/material.dart';

class MyPageText extends StatelessWidget {
  const MyPageText({super.key, required this.user});
  final String user;
  @override
  Widget build(BuildContext context) {
    String userText = "${user}님, 안녕하세요!";
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(userText, style: TextStyle(fontSize: 16),),
        ],
      ),
    );;
  }
}

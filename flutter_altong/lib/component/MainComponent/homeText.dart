import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  const MainText({super.key, required this.user});
  final String user;

  @override
  Widget build(BuildContext context) {
    String userText = "${user}님, 이번주도 화이팅!";
    // String text = "";
    return Container(
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userText, style: TextStyle(fontSize: 24),),
          // Text(text, style: TextStyle(fontSize: 28),),
        ],
      ),
    );
  }
}

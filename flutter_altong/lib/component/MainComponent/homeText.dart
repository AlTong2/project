import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  const MainText({super.key, required this.user});
  final String user;

  @override
  Widget build(BuildContext context) {
    String userText = "${user}님, 이번주도 화이팅!!";
    // String text = "";
    return Container(
      padding: EdgeInsets.only(top : 10,left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(userText, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, fontFamily: 'kuk'),),
          // Text(text, style: TextStyle(fontSize: 28),),
        ],
      ),
    );
  }
}

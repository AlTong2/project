import 'package:flutter/material.dart';

class ChatTextFormat extends StatelessWidget {
  const ChatTextFormat({super.key, required this.text, required this.con});
  final String text;
  final TextEditingController con;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: con,
      decoration: InputDecoration(
        label: Row(
          children: [
            Text(text, style: TextStyle(fontFamily: 'pre'),)
          ],
        ),
      ),
    );;
  }
}

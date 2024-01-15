import 'package:flutter/material.dart';

class ScreenName extends StatelessWidget {
  const ScreenName({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 3,left: 10,bottom: 4),
      child: Text(name, style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.06,fontWeight: FontWeight.w500, fontFamily: 'se'),),
    );
  }
}

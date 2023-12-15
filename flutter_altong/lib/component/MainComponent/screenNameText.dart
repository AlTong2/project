import 'package:flutter/material.dart';

class ScreenName extends StatelessWidget {
  const ScreenName({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12,left: 16,bottom: 4),
      child: Text(name, style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
    );
  }
}

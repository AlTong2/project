import 'package:flutter/material.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({super.key, required this.name});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8,left: 16,bottom: 16),
      child: Text(name, style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
    );
  }
}

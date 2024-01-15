import 'package:flutter/material.dart';

class LoginBtn extends StatelessWidget {
  const LoginBtn ({super.key, required this.text, required this.btnFunc, required this.color});
  final String text;
  final VoidCallback btnFunc;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 50,
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            )
          ),
          onPressed: btnFunc,
          child: Text(text, style: TextStyle(color: Colors.white,fontFamily: 'pre'))),
    );
  }
}

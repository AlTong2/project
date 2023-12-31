import 'package:flutter/material.dart';

class SmallButton extends StatelessWidget {
  const SmallButton ({super.key, required this.text, required this.btnFunc, required this.color});
  final String text;
  final VoidCallback btnFunc;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      padding: EdgeInsets.all(5),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              )
          ),
          onPressed: btnFunc,
          child: Text(text, style: TextStyle(fontFamily: 'pre'),)),
    );
  }
}

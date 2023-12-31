import 'package:flutter/material.dart';
import 'package:flutter_altong/constants/constants.dart';

class MyPageBtn extends StatelessWidget {
  const MyPageBtn({super.key, required this.text, required this.btnFunc});
  final String text;
  final VoidCallback btnFunc;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.06,
      margin:  EdgeInsets.all(10),
      child: ElevatedButton(onPressed: btnFunc,
        child: Text(text, style: TextStyle(color: Colors.white,fontFamily: 'pre'),),
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mainColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            )
        ),
      ),
    );;
  }
}

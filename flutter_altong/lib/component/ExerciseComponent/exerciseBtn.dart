import 'package:flutter/material.dart';
import 'package:flutter_altong/constants/constants.dart';

class ExerciseScreenBtn extends StatelessWidget {
  const ExerciseScreenBtn({super.key, required this.text, required this.exerciseFunc});
  final String text;
  final VoidCallback exerciseFunc;
  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 250,
        height: 50,
        margin: EdgeInsets.only(top: 10),
        child: ElevatedButton(style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.mainColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
            )
        )
            ,onPressed: exerciseFunc,
            child:
            Text(text)
        ),
      );
  }
}

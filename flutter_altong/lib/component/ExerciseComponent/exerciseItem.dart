import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({super.key, required this.ExerciseName, required this.count, required this.set});
  final String ExerciseName;
  final int count;
  final int set;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child: Text(ExerciseName, style: TextStyle(fontFamily: 'pre', fontSize: MediaQuery.of(context).size.width * 0.025),textAlign: TextAlign.center,)),
        Expanded(child: SizedBox()),
        Expanded(child: Text("${count} 개 / ${set} 세트", style: TextStyle(fontFamily: 'pre', fontSize: MediaQuery.of(context).size.width * 0.025))),
      ],
    );
  }
}

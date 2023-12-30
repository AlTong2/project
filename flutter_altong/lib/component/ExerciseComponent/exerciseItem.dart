import 'package:flutter/material.dart';

class ExerciseItem extends StatelessWidget {
  const ExerciseItem({super.key, required this.ExerciseName, required this.count, required this.set});
  final String ExerciseName;
  final int count;
  final int set;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(ExerciseName),
        SizedBox(),
        Text("${count}개/${set}세트"),
        /*
        Row(
          children: [
            // TODO 클릭 가능한 버튼으로 변경필요
            Text("수정"),
            Text("/"),
            Text("삭제"),
          ],
        )
        */
      ],
    );
  }
}

import 'package:flutter/material.dart';

class ExerciseRestTime extends StatelessWidget {
  const ExerciseRestTime({super.key, required this.time});
  final int time;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("세트당 휴식시간"),
        Row(
          children: [
            // TODO 시간은 설정하도록
            Text("${time~/60}분 ${time%60}초"),
          ],
        )
      ],
    );
  }
}

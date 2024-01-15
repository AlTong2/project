import 'package:flutter/material.dart';

class UpdateExerciseRadio extends StatelessWidget {
  const UpdateExerciseRadio({super.key, required this.exercise, required this.groupValue, required this.func});
  final String exercise;
  final String groupValue;
  final ValueChanged func;
  @override
  Widget build(BuildContext context) {
    return RadioListTile<String>(
      controlAffinity: ListTileControlAffinity.leading,
      title: Text("$exercise", style: TextStyle(fontSize: MediaQuery.of(context).size.width *0.035, fontFamily: 'pre')),
      value: exercise,
      groupValue: groupValue,
      onChanged: func,
    );
  }
}

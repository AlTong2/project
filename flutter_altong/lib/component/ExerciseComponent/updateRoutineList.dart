import 'package:flutter/material.dart';
import 'package:flutter_altong/controller/alt_06_exerciseController.dart';
import 'package:get/get.dart';

class UpdateRoutineList extends StatelessWidget {
  const UpdateRoutineList({super.key, required this.exerciseName, required this.count, required this.set, required this.num});
  final String exerciseName;
  final int count;
  final int set;
  final int num;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(flex:1,child: SizedBox(width: 20),),
        Expanded(flex:3,child: Text(exerciseName, textAlign: TextAlign.left,style: TextStyle(fontSize: 12))),
        Expanded(flex:3,child: Text("${count}개 / ${set}세트", textAlign: TextAlign.left,style: TextStyle(fontSize: 12),)),
        Expanded(flex:2,child: TextButton(onPressed: () {
          print("${num} 번 삭제 메소드");
          Get.find<ExerciseController>().deleteExercise(num);
        }, child: Text("삭제", textAlign: TextAlign.left,style: TextStyle(fontSize: 12),)))
      ],
    );
  }
}

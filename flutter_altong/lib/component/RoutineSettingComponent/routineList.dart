import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_altong/controller/alt_10_routineController.dart';
import 'package:get/get.dart';

class RoutineList extends StatelessWidget {
  const RoutineList({super.key, required this.exerciseName, required this.count, required this.set, required this.num});
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
        Expanded(flex:3,child: Text(exerciseName, textAlign: TextAlign.left,)),
        Expanded(flex:3,child: Text("${count}개 / ${set}세트", textAlign: TextAlign.left,)),
        Expanded(flex:2,child: TextButton(onPressed: () {
                                            print("${num} 번 삭제 메소드");
                                            Get.find<RoutineController>().deleteExercise(num);
                                            }, child: Text("삭제", textAlign: TextAlign.left,)))
      ],
    );
  }
}

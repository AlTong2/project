import 'package:flutter/material.dart';
import 'package:flutter_altong/controller/alt_06_exerciseController.dart';
import 'package:get/get.dart';

class DeleteModal extends StatelessWidget {
  const DeleteModal({super.key, required this.routineKey});
  final String routineKey;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("해당 루틴을 삭제하시겠습니까?"),
          // Get.find<ExerciseController>().routineList[index]["key"]값을 이용해서 루틴 삭제
          ElevatedButton(onPressed:  (){
            //print("${Get.find<ExerciseController>().routineList[index]["key"]} 삭제");
            //Get.find<ExerciseController>().deleteRoutine(Get.find<ExerciseController>().routineList[index]["key"]);
            Get.find<ExerciseController>().deleteRoutine(routineKey);
          },
              child: Text("삭제"))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_altong/component/ExerciseComponent/updateExerciseRadio.dart';
import 'package:flutter_altong/component/RoutineSettingComponent/smallBtn.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_06_exerciseController.dart';
import 'package:get/get.dart';

class UpdateAddExercise extends StatelessWidget {
  const UpdateAddExercise({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Center(
              child: Text("종목 추가", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
          Obx(() => Container(
            margin: EdgeInsets.only(top: 30),
            child: Column(
              children:  Get.find<ExerciseController>().exerciseList.map((exercise) {
                return UpdateExerciseRadio(
                  exercise: exercise,
                  groupValue: Get.find<ExerciseController>().selectExercise.value,
                      func: (value) {
                    Get.find<ExerciseController>().selectAddExercise(value);
                  },
                );
              }).toList(),
            ),
          ),),
          Obx(
                () => Positioned(
              top: 30,
              left: 140,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Get.find<ExerciseController>().setCount(1),
                      icon: Icon(Icons.add)
                  ),
                  Text("${Get.find<ExerciseController>().count}개"),
                  IconButton(
                      onPressed: () => Get.find<ExerciseController>().setCount(0),
                      icon: Icon(Icons.remove)
                  )
                ],
              ),
            ),
          ),
          Obx(
                () => Positioned(
              top: 30,
              left: 250,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () =>Get.find<ExerciseController>().setSet(1),
                      icon: Icon(Icons.add)),
                  Text("${Get.find<ExerciseController>().set}세트"),
                  IconButton(
                      onPressed: () =>Get.find<ExerciseController>().setSet(0),
                      icon: Icon(Icons.remove))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 50,
            child: SmallButton(text: "추가",
                btnFunc: () =>
                    Get.find<ExerciseController>().exerciseUpdateConfirm(),
                color: AppColors.mainColor
            ),
          )
        ]
    );;
  }
}

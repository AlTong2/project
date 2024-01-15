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
              child: Text("종목 추가", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04, fontFamily: 'pre', fontWeight: FontWeight.w500))),
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
                top: MediaQuery.of(context).size.height * 0.05,
                left: MediaQuery.of(context).size.width * 0.605,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Get.find<ExerciseController>().setCount(0),
                      icon: Icon(Icons.remove, size: MediaQuery.of(context).size.width * 0.04,)
                  ),
                  Text("${Get.find<ExerciseController>().count}개", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03, fontFamily: 'pre')),
                  IconButton(
                      onPressed: () => Get.find<ExerciseController>().setCount(1),
                      icon: Icon(Icons.add, size: MediaQuery.of(context).size.width * 0.04,)
                  ),
                ],
              ),
            ),
          ),
          Obx(
                () => Positioned(
                top: MediaQuery.of(context).size.height* 0.1,
                left: MediaQuery.of(context).size.width * 0.605,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () =>Get.find<ExerciseController>().setSet(0),
                      icon: Icon(Icons.remove, size: MediaQuery.of(context).size.width * 0.04,)),
                  Text("${Get.find<ExerciseController>().set}세트", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.03, fontFamily: 'pre')),
                  IconButton(
                      onPressed: () =>Get.find<ExerciseController>().setSet(1),
                      icon: Icon(Icons.add, size: MediaQuery.of(context).size.width * 0.04,)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            right: MediaQuery.of(context).size.width * 0.03,
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

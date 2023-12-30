import 'package:flutter/material.dart';
import 'package:flutter_altong/component/RoutineSettingComponent/smallBtn.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_10_routineController.dart';
import 'package:get/get.dart';

class SetExercise extends StatelessWidget {
  const SetExercise({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Obx(() => Column(
            children: [
              RadioListTile<String>(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("스쿼트"),
                value: Get.find<RoutineController>().exerciseList[0],
                groupValue: Get.find<RoutineController>().selectExercise.value,
                onChanged: (value) {
                  Get.find<RoutineController>()
                      .select(value);
                },
              ),
              RadioListTile<String>(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("턱걸이"),
                value: Get.find<RoutineController>().exerciseList[1],
                groupValue: Get.find<RoutineController>().selectExercise.value,
                onChanged: (value) {
                  Get.find<RoutineController>().select(value);
                },
              ),
              RadioListTile<String>(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("팔굽혀펴기"),
                value: Get.find<RoutineController>().exerciseList[2],
                groupValue: Get.find<RoutineController>().selectExercise.value,
                onChanged: (value) {
                  Get.find<RoutineController>().select(value);
                },
              )
            ],
          ),),
          Obx(
                () => Positioned(
              top: 0,
              left: 140,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Get.find<RoutineController>().setCount(1),
                      icon: Icon(Icons.add)
                  ),
                  Text("${Get.find<RoutineController>().count}개"),
                  IconButton(
                      onPressed: () => Get.find<RoutineController>().setCount(0),
                      icon: Icon(Icons.remove)
                  )
                ],
              ),
            ),
          ),
          Obx(
                () => Positioned(
              top: 0,
              left: 250,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () =>Get.find<RoutineController>().setSet(1),
                      icon: Icon(Icons.add)),
                  Text("${Get.find<RoutineController>().set}세트"),
                  IconButton(
                      onPressed: () =>Get.find<RoutineController>().setSet(0),
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
                    Get.find<RoutineController>().exerciseConfirm(),
                color: AppColors.mainColor
            ),
          )
        ]
    );
  }
}

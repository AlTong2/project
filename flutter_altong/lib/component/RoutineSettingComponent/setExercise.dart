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
                title: Text("스쿼트", style: TextStyle(fontSize: 13),),
                value: Get.find<RoutineController>().exerciseList[0],
                groupValue: Get.find<RoutineController>().selectExercise.value,
                onChanged: (value) {
                  Get.find<RoutineController>()
                      .select(value);
                },
              ),
              RadioListTile<String>(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("턱걸이", style: TextStyle(fontSize: 13),),
                value: Get.find<RoutineController>().exerciseList[1],
                groupValue: Get.find<RoutineController>().selectExercise.value,
                onChanged: (value) {
                  Get.find<RoutineController>().select(value);
                },
              ),
              RadioListTile<String>(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text("팔굽혀펴기", style: TextStyle(fontSize: 13),),
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
              top: MediaQuery.of(context).size.height * 0.01,
              left: MediaQuery.of(context).size.height * 0.17,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () => Get.find<RoutineController>().setCount(1),
                      icon: Icon(Icons.add, size: 18,)
                  ),
                  Text("${Get.find<RoutineController>().count}개", style: TextStyle(fontSize: 12),),
                  IconButton(
                      onPressed: () => Get.find<RoutineController>().setCount(0),
                      icon: Icon(Icons.remove, size: 18,)
                  )
                ],
              ),
            ),
          ),
          Obx(
                () => Positioned(
              top: MediaQuery.of(context).size.height * 0.01,
              left: MediaQuery.of(context).size.height * 0.31,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () =>Get.find<RoutineController>().setSet(1),
                      icon: Icon(Icons.add, size: 18,)),
                  Text("${Get.find<RoutineController>().set}세트", style: TextStyle(fontSize: 12),),
                  IconButton(
                      onPressed: () =>Get.find<RoutineController>().setSet(0),
                      icon: Icon(Icons.remove, size: 18,))
                ],
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.02,
            right: MediaQuery.of(context).size.width * 0.03,
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

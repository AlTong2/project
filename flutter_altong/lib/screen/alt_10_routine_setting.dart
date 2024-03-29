import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_altong/component/MainComponent/screenNameText.dart';
import 'package:flutter_altong/component/RoutineSettingComponent/mediumBtn.dart';
import 'package:flutter_altong/component/RoutineSettingComponent/routineList.dart';
import 'package:flutter_altong/component/RoutineSettingComponent/setExercise.dart';
import 'package:flutter_altong/component/RoutineSettingComponent/setRest.dart';
import 'package:flutter_altong/component/RoutineSettingComponent/smallBtn.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_10_routineController.dart';
import 'package:get/get.dart';

class ALT10RoutineSetting extends StatelessWidget {
  const ALT10RoutineSetting({super.key});

  @override
  Widget build(BuildContext context) {
    String addExercise = "운동 추가";
    TextEditingController routineNameCon = TextEditingController();
    //List<String> exerciseList = ['스쿼트', '턱걸이', '팔굽혀펴기'];
    //String selectExercise = "";

    Get.put(RoutineController());
    return GestureDetector(
      onTap: () {
        Get.find<RoutineController>().updateText(routineNameCon.text);
        FocusScope.of(context).unfocus();
      },
      child:
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: AppColors.mainColor,
            title: ScreenName(name: addExercise),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                tooltip: 'close',
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          ),
          body: SafeArea(
            child: ListView(
              // physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.85,
                      child: Obx(
                        () {
                          final routineController = Get.find<RoutineController>();
                          final routineName = routineController.routineName.value;
                          routineNameCon.text = routineName;
                          return TextField(
                            controller: routineNameCon,
                            // onChanged: (value) {Get.find<RoutineController>().updateText(value);},
                            decoration: InputDecoration(
                              label: Text('루틴 명')
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("운동명", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
                    Text("개수 / 세트", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04)),
                    SizedBox(width: 20,),
                  ],
                ),
                Container(
                  height: 150,
                  child:
                    Obx(() => ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      //shrinkWrap: true,
                      //physics: NeverScrollableScrollPhysics(),
                      itemCount: Get.find<RoutineController>().routine.length,
                      itemBuilder:
                        (context, index) {
                          return ListTile(
                            title: Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: RoutineList(exerciseName: Get.find<RoutineController>().routine[index]["exercise"],
                                  count: Get.find<RoutineController>().routine[index]["count"],
                                  set: Get.find<RoutineController>().routine[index]["set"],
                                  num: index,
                              ),
                            )
                          );
                        },
                    )),
                ),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  height: 1,
                  width: MediaQuery.of(context).size.width *0.85,
                  decoration:BoxDecoration(
                      color: AppColors.lineGrey
                  ),
                ),
                SizedBox(height: 10,),
                // 운동 설정
                SetExercise(),
                SizedBox(height: 10,),
                Container(
                  margin: EdgeInsets.only(left: 10,right: 10),
                  height: 1,
                  width: MediaQuery.of(context).size.width *0.85,
                  decoration:BoxDecoration(
                      color: AppColors.lineGrey
                  ),
                ),
                SizedBox(height: 10,),
                // 휴식시간 설정
                SetRestTime(),
                SizedBox(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: EdgeInsets.only(top: 10),
                      child: MediumButton(text: "루틴 추가",
                          btnFunc: (){
                            Get.find<RoutineController>().saveRoutine();
                          },
                          color: AppColors.mainColor)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}

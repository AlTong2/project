import 'package:flutter/material.dart';
import 'package:flutter_altong/component/ExerciseComponent/deleteModal.dart';
import 'package:flutter_altong/component/ExerciseComponent/exerciseItem.dart';
import 'package:flutter_altong/component/ExerciseComponent/exerciseRestTime.dart';
import 'package:flutter_altong/component/ExerciseComponent/exerciseBtn.dart';
import 'package:flutter_altong/component/ExerciseComponent/routineListItem.dart';
import 'package:flutter_altong/component/ExerciseComponent/updateModal.dart';
import 'package:flutter_altong/component/MainComponent/screenNameText.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_06_exerciseController.dart';
import 'package:flutter_altong/screen/alt_10_routine_setting.dart';
import 'package:get/get.dart';
import 'package:toggle_list/toggle_list.dart';
import 'package:toggle_list/src/toggle_list_item.dart';


class ALT06Exercise extends StatelessWidget {
  const ALT06Exercise({Key? key});

  @override
  Widget build(BuildContext context) {
    String exercise = "운동";
    Get.put((ExerciseController()));
    var scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset('img/altong_muscle.png', width: MediaQuery.of(context).size.width*0.15,),
              ScreenName(name: exercise),
            ],
          ),
          backgroundColor: AppColors.mainColor,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add, size: 32), // 다른 아이콘으로 변경
              onPressed: () {
                scaffoldKey.currentState!.openEndDrawer();
              },
            ),
          ],
        ),
        endDrawer: Drawer(
          child: ALT10RoutineSetting(),
          width: double.infinity,
        ),
        body : SafeArea(
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.appBackground
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  margin: EdgeInsets.all(10),
                  child: Obx(
                    () {
                      return ToggleList(
                      children:
                      List.generate(Get.find<ExerciseController>().routineList.length, (index) =>
                          ToggleListItem(
                              title: Container(
                                height: 45,
                                child: RadioListTile<String>(
                                    controlAffinity: ListTileControlAffinity.leading,
                                      title: Text("${Get.find<ExerciseController>().routineList[index]["value"]["routine_name"]}",
                                                  style: TextStyle(fontFamily: 'pre', fontSize: MediaQuery.of(context).size.width * 0.04),),
                                      value: Get.find<ExerciseController>().routineList[index]["key"],
                                      groupValue: Get.find<ExerciseController>().selectKey.value,
                                      onChanged: (value){
                                        Get.find<ExerciseController>().selectKey(value);
                                      },
                                ),
                              ),
                              content: Padding(
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("운동 리스트",style: TextStyle(fontFamily: 'pre', fontSize: MediaQuery.of(context).size.width * 0.03)),
                                        // 삭제 기능
                                        Row(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width* 0.14,
                                              child: TextButton(
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder: (BuildContext context) {
                                                      return StatefulBuilder(
                                                        builder: (BuildContext innerContext, StateSetter setState) {
                                                          return UpdateModal(
                                                            routine: Get.find<ExerciseController>().routineList[index],
                                                          );
                                                        },
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Text("수정", style: TextStyle(fontFamily: 'pre', fontSize: MediaQuery.of(context).size.width * 0.03)),
                                              ),
                                            ),
                                            Text("/", style: TextStyle(fontSize: 12)),
                                            SizedBox(
                                              width: MediaQuery.of(context).size.width* 0.14,
                                              child: TextButton(onPressed: () {
                                                showModalBottomSheet(
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
                                                  context: context,
                                                  builder: (BuildContext) {
                                                  return DeleteModal(routineKey: Get.find<ExerciseController>().routineList[index]["key"]);
                                                } );
                                              } ,child: Text("삭제", style: TextStyle(fontFamily: 'pre', fontSize: MediaQuery.of(context).size.width * 0.03))),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: Get.find<ExerciseController>().routineList[index]["value"]["routine_list"].length,
                                      itemBuilder: (context, innerIndex) {
                                        return ExerciseItem(
                                          ExerciseName: Get.find<ExerciseController>().routineList[index]["value"]["routine_list"][innerIndex]["exercise"],
                                          count: Get.find<ExerciseController>().routineList[index]["value"]["routine_list"][innerIndex]["count"],
                                          set: Get.find<ExerciseController>().routineList[index]["value"]["routine_list"][innerIndex]["set"],
                                        );
                                      },
                                    ),
                                    SizedBox(height: 10,),
                                    ExerciseRestTime(time: Get.find<ExerciseController>().routineList[index]["value"]["rest_time"])
                                  ],
                                ),
                          )
                      ),
                    )
                    );
                    } // obx function end
                  ),
                ),
                Center(child: ExerciseScreenBtn(text: "루틴 시작",  exerciseFunc: () => Get.find<ExerciseController>().startRoutine() ,))
              ],
            ),
          ),
        )
    );
  }
}
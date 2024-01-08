import 'package:flutter/material.dart';
import 'package:flutter_altong/component/ExerciseComponent/updateAddExercise.dart';
import 'package:flutter_altong/component/ExerciseComponent/updateRoutineList.dart';
import 'package:flutter_altong/component/ExerciseComponent/updateSetRest.dart';
import 'package:flutter_altong/component/RoutineSettingComponent/mediumBtn.dart';
import 'package:flutter_altong/constants/constants.dart';
import 'package:flutter_altong/controller/alt_06_exerciseController.dart';
import 'package:get/get.dart';

class UpdateModal extends StatefulWidget {
  const UpdateModal({super.key, required this.routine});
  // 컨트롤러의 routine을 그대로 사용중이라 obs 적용되는듯 보임 ==> 이걸로 새로 똑같은 List생성하고 적용해야할듯
  final Map<String, dynamic> routine;

  @override
  State<UpdateModal> createState() => _UpdateModalState();
}

class _UpdateModalState extends State<UpdateModal> {

  @override
  void initState() {
    super.initState();
    print("init");

    updateController();
  }

  void updateController() {
    print("업뎃");
    print("루틴 : ${widget.routine}");
    late Map updateRoutine ={};
    updateRoutine = copyUpdateMap(widget.routine);
    print("루틴 초기화 ?: ${updateRoutine}");
    Get.find<ExerciseController>().key.value = updateRoutine["key"];
    Get.find<ExerciseController>().updateRestTime.value = updateRoutine["value"]["rest_time"];
    Get.find<ExerciseController>().updateRoutineList.value = updateRoutine["value"]["routine_list"];
    Get.find<ExerciseController>().updateRoutineName.value = updateRoutine["value"]["routine_name"];
    Get.find<ExerciseController>().update();
    print("${Get.find<ExerciseController>().updateRoutineList}");
  }

  // Map.from()을 obs로 연결된 Map에 영향을 미치므로
  // 가져온 Map을 복사해서 업데이트용으로 보여준다.
  Map<String, dynamic> copyUpdateMap(Map<String, dynamic> original) {
    Map<String, dynamic> copy = {};
    original.forEach((key, value) {
      if (value is Map<String, dynamic>) {
        copy[key] = copyUpdateMap(value); // 내부 맵의 깊은 복사
      } else if (value is List<dynamic>) {
        copy[key] = List.from(value); // 리스트의 경우 복사 후 내부 요소의 변경에 유의
      } else {
        copy[key] = value;
      }
    });
    return copy;
  }


  @override
  Widget build(BuildContext context) {
    TextEditingController routineNameCon = TextEditingController();
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Obx(
                        () {
                      final routineController = Get.find<ExerciseController>();
                      final routineName = routineController.updateRoutineName.value;
                      routineNameCon.text = routineName;
                      return TextField(
                        controller: routineNameCon,
                        onChanged: (value) {Get.find<ExerciseController>().updateRoutineNameText(value);},
                        decoration: InputDecoration(
                            label: Text('루틴 명', style: TextStyle(fontSize:MediaQuery.of(context).size.width * 0.04, fontFamily: 'pre'))
                        ),
                      );
                    }
                ),
              ),
            ),
          ),
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("운동명", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04,fontFamily: 'pre', fontWeight: FontWeight.w500)),
              Text("개수 / 세트", style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04,fontFamily: 'pre', fontWeight: FontWeight.w500)),
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
              itemCount: Get.find<ExerciseController>().updateRoutineList.length,
              itemBuilder:
                  (context, index) {
                return ListTile(
                    title: UpdateRoutineList(exerciseName: Get.find<ExerciseController>().updateRoutineList[index]["exercise"],
                      count: Get.find<ExerciseController>().updateRoutineList[index]["count"],
                      set: Get.find<ExerciseController>().updateRoutineList[index]["set"],
                      num: index,
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
          UpdateAddExercise(),
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
          UpdateSetRest(),
          SizedBox(
            child: Center(
              child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  margin: EdgeInsets.only(top: 10),
                  child: MediumButton(text: "루틴 수정하기",
                      btnFunc: (){
                        Get.find<ExerciseController>().updateRoutine();
                      },
                      color: AppColors.mainColor)
              ),
            ),
          )
        ],// End ListView children
      )
    );
  }
}

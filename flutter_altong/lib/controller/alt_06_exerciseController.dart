import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_altong/Firebase.dart';
import 'package:flutter_altong/screen/alt_03_Join.dart';
import 'package:flutter_altong/screen/alt_02_login.dart';
import 'package:flutter_altong/service/database_service.dart';
import 'package:get/get.dart';

class ExerciseController extends GetxController{
  List<String> exerciseList = ['스쿼트', '턱걸이', '팔굽혀펴기'];
  RxString selectExercise = "".obs;
  DatabaseService dbService = DatabaseService();
  RxList<dynamic> routineList = [].obs;

  //선택한 루틴 키값
  RxString selectKey = "".obs;

  RxInt count = 0.obs;
  RxInt set = 0.obs;
  RxInt rest = 0.obs;

  // 수정을 위해 필요한 변수
  RxString key = "".obs;
  RxInt updateRestTime = 0.obs;
  RxList updateRoutineList = [].obs;
  RxString updateRoutineName = "".obs;

  //루틴 데이터 받아오기
  void getRoutine(){
    Future<List?> routine = dbService.fetchRoutineData();
    // Future가 완료되면 해당 데이터를 RxList에 할당합니다.
    // RxList로 변환하기 위해 .value를 사용합니다.
    routine.then((data) {
      if (data != null) {
        routineList.value = data;
      }
      print("루틴 등록 : ${routineList.value}");
      update();
    }).catchError((error) {
      // 에러 처리
      print("Error fetching routine data: $error");
    });
  }

  // 루틴 삭제 처리
  void deleteRoutine(String routineKey) async{
    // 삭제 기능
    await dbService.fireBaseDeleteRoutine(routineKey);
    getRoutine();
    // 루틴 삭제 후 리빌딩
    String user = await getFirebaseUserName();
    int kcal = await getFirebaseUserKcal();
    Map<String, dynamic> arguments = {
      'user': user,
      'kcal': kcal
    };
    Get.offAllNamed("/main", arguments: arguments);
  }

  // 루틴 이름 변경
  void updateRoutineNameText(String name) {
    updateRoutineName.value = name;
  }

  void deleteExercise(num){
    updateRoutineList.removeAt(num);
  }
  // 추가 운동 선택
  void selectAddExercise(exercise){
    selectExercise.value = exercise;
  }

  void setCount(pm){
    if(pm == 1) {
      count.value += 1;
    } else {
      if(count.value != 0){
        count.value -= 1;
      }
    }
  }
  void setSet(pm){
    if(pm == 1) {
      set.value += 1;
    } else {
      if(set.value != 0){
        set.value -= 1;
      }
    }
  }

  void setRest(pm){
    if(pm == 1) {
      updateRestTime.value += 10;
    } else {
      if(updateRestTime.value != 0){
        updateRestTime.value -= 10;
      }
    }
  }
  // 업데이트 모달 운동 추가 버튼
  void exerciseUpdateConfirm(){
    String name = selectExercise.value;
    int cnt = count.value;
    int setNum = set.value;
    if (name != ""  && setNum != 0 && cnt != 0){
      Map<String, dynamic> exercise = {
        //"num": routine.length,
        "exercise": name,
        "count": cnt,
        "set": setNum,
      };
      updateRoutineList.add(exercise);
      selectExercise.value = exerciseList[0];
      count.value = 0;
      set.value = 0;
    }
    //print(routine);
  }
  void updateRoutine() async {
    // RxList 값을 복사해서 사용
    List<dynamic> routineList = List.from(updateRoutineList.value);
    // 루틴명이 존재하고, 루틴리스트에 1개이상의 루틴이있고, 쉬는시간이 0이상일때
    if(updateRoutineName.value != "" && routineList.length != 0 && updateRestTime.value != 0){
      await dbService.fireBaseUpdateRoutine(key, updateRoutineName.value, routineList, updateRestTime.value);
      updateRoutineList.clear();
      rest.value = 0;
      updateRoutineName.value = "";
      String user = await getFirebaseUserName();
      int kcal = await getFirebaseUserKcal();
      Map<String, dynamic> arguments = {
        'user': user,
        'kcal': kcal
      };
      Get.offAllNamed("/main", arguments: arguments);
    }
    else{
      print("else");
      // 없는거 스낵바로 알려주기 ? 리턴 ?필요 ?
    }
  }

  // 키값을 선택했을때 해당 키값으로 값 변경
  void selectRoutine(Key){
    selectKey.value = Key;
  }

}
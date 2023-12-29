import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_altong/Firebase.dart';
import 'package:flutter_altong/controller/alt_06_exerciseController.dart';
import 'package:flutter_altong/service/database_service.dart';
import 'package:get/get.dart';

class RoutineController extends GetxController{
  List<String> exerciseList = ['스쿼트', '턱걸이', '팔굽혀펴기'];
  RxString selectExercise = "".obs;
  RxInt count = 0.obs;
  RxInt set = 0.obs;
  RxInt rest = 0.obs;
  // 루틴명
  RxString routineName = "".obs;
  // 루틴 운동 리스트
  RxList routine = [].obs;
  ExerciseController exerciseController = ExerciseController();
  DatabaseService dbService = DatabaseService();

  void select(exercise){
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
      rest.value += 10;
    } else {
      if(rest.value != 0){
        rest.value -= 10;
      }
    }
  }

  void deleteExercise(num){
    routine.removeAt(num);
  }

  void exerciseConfirm(){
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
      routine.add(exercise);
      selectExercise.value = exerciseList[0];
      count.value = 0;
      set.value = 0;
    }
    //print(routine);
  }
  // 루틴 이름 변경
  void updateText(String name) {
    routineName.value = name;
  }

  // 루틴 저장
  void saveRoutine() async{
    // RxList 값을 복사해서 사용
    List<dynamic> routineList = List.from(routine.value);
    // 루틴명이 존재하고, 루틴리스트에 1개이상의 루틴이있고, 쉬는시간이 0이상일때
    if(routineName.value != "" && routineList.length != 0 && rest.value != 0){
      await dbService.fireBaseSaveRoutine(routineName.value, routineList, rest.value);
      routine.clear();
      rest.value = 0;
      routineName.value = "";
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

}
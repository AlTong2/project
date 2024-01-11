import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DatabaseService{

  DatabaseReference ref = FirebaseDatabase.instance.ref();


  // 루틴 데이터 저장하기
  // 저장 목록 : 루틴 이름, 회원 아이디, 운동 목록( 개수 / 세트 ), 휴식시간
  Future<void> fireBaseSaveRoutine(routineName, routineList, restTime) async {
    // 회원 정보 가져오기
    var auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      String? uid = auth.currentUser?.uid;
      FirebaseDatabase database = FirebaseDatabase.instance;
      DatabaseReference dbref = database.ref("PERSONAL_ROUTINE_INFO");
      return Future.delayed(Duration(seconds: 3)).then((value) async {
        var value = await dbref.child('$uid').get();
        await dbref.child(uid!).push().set({
          'routine_name': routineName,
          'routine_list': routineList,
          'rest_time': restTime,
        });
      }
      );
    }
  }

  // 루틴 데이터 받아오기
  Future<List<dynamic>?> fetchRoutineData() async {
    // 회원 정보 가져오기
    var auth = FirebaseAuth.instance;
    List<dynamic> resultData = [];
    if (auth.currentUser != null) {
      String? uid = auth.currentUser?.uid;
      DatabaseReference dbref = FirebaseDatabase.instance.reference().child("PERSONAL_ROUTINE_INFO").child(uid!);

      // 저장한 데이터 가져오기
      var savedData = await dbref.get();
      if (savedData != null && savedData.value != null) {
        print("저장 데이터: ${savedData.value}");
        Map<dynamic, dynamic> dataMap = jsonDecode(jsonEncode(savedData.value));

        dataMap.forEach((key, value) {
        // 여기서 데이터 처리
        Map<String, dynamic> routinedata = { "key" : key, "value" : dataMap[key]};
        resultData.add(routinedata);
         });
        // 가져온 데이터 처리
      } else {
        print("No data available");
      }
      return resultData;
    }
  }

  // 루틴 데이터 삭제하기
  Future<void> fireBaseDeleteRoutine(routineKey) async{
    // 회원 정보 가져오기
    var auth = FirebaseAuth.instance;
    // 현재 유저가 존재 할 경우
    if (auth.currentUser != null) {
      //현재 유저의 uid 취득후 해당 uid의 데이터 베이스로 접근
      String? uid = auth.currentUser?.uid;
      DatabaseReference dbref = FirebaseDatabase.instance.reference().child("PERSONAL_ROUTINE_INFO").child(uid!);
      dbref.child(routineKey).remove();
    }
  }

  // 루틴 데이터 업데이트
  Future<void> fireBaseUpdateRoutine(key, routineName, routineList, restTime) async {
    // 회원 정보 가져오기
    var auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      String? uid = auth.currentUser?.uid;
      FirebaseDatabase database = FirebaseDatabase.instance;
      DatabaseReference dbref = database.ref("PERSONAL_ROUTINE_INFO");
      return Future.delayed(Duration(seconds: 3)).then((value) async {
        await dbref.child('$uid').child('$key').set({
          'routine_name': routineName,
          'routine_list': routineList,
          'rest_time': restTime,
        });
      }
      );
    }
  }

  // 칼로리 업데이트
  Future<void> fireBaseUpdateKcal(name, key, int kcal) async {
    // 회원 정보 가져오기
    var auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      String? uid = auth.currentUser?.uid;
      String? email = auth.currentUser?.email;
      FirebaseDatabase database = FirebaseDatabase.instance;
      DatabaseReference dbref = database.ref("member_info");
      print("●●●●●●●●●●●●●●칼로리 ? ${kcal}");
      return Future.delayed(Duration(seconds: 3)).then((value) async {
        await dbref.child('$uid').update({
          'email' : email,
          'kcal': kcal,
          'name' : name
        });
      }
      );
    }
  }

  /* 루틴 시작 */
  // 1. 현재 진행중인 루틴데이터 확인
  Future<bool> checkRoutine() async  {
    bool result = false;
    var database = FirebaseDatabase.instance.ref();
    return Future.delayed(Duration(seconds: 3)).then((value) async {
      var event = await database.child("current_routine").once();
      var value = event.snapshot;
      print(value);
      if (value.exists) {
        // 루틴이 있을때 true 반환하여 루틴 실행중 다른 루틴이 실행되것 방지
        print("루틴 존재");
        result = true;
      }
      return result;
    });
  }

  // 2. 루틴데이터가 없을경우 현재 체크한 루틴 가져오기
  Future<bool> setCurrentRoutine(String routineKey) async{
    bool result = false;
    var auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      String? uid = auth.currentUser?.uid;
      List? getRoutine = await getRoutineData(uid!, routineKey);
      print("받아온 루틴${getRoutine}");
      String userKey = uid;
      int rest_time = 0;
      List<dynamic> routine = [];
      // 받아온 루틴을 current_routine에 저장
      for(int i= 0; i < getRoutine!.length-1; i++ ){
        if(getRoutine[i]["key"] == "rest_time"){
          rest_time = getRoutine[i]["value"];
        }
        if(getRoutine[i]["key"] == "routine_list"){
          routine = List.from(getRoutine[i]["value"]);
          for(int j = 0; j < routine.length; j ++){
            if( routine[j]["exercise"] == "스쿼트"){routine[j]["exercise"] = "Squat";}
            if( routine[j]["exercise"] == "턱걸이"){routine[j]["exercise"] = "Pullup";}
            if( routine[j]["exercise"] == "팔굽혀펴기"){routine[j]["exercise"] = "Pushup";}
          }
        }
      }
      print("유저키 : ${userKey}");
      print("쉬는시간 : ${rest_time}");
      print("운동 리스트 : ${routine}");
      FirebaseDatabase database = FirebaseDatabase.instance;
      DatabaseReference dbref = database.ref();
      await Future.delayed(Duration(seconds: 3)).then((value) async {
        await dbref.child('current_routine').set({
          'user_key': userKey,
          'routine': routine,
          'rest_time': rest_time,
        });
        result = true;
      }
      );

    }
    // 루틴 데이터 가져오기
    return result;
  }

  // 2-1) 루틴 데이터 가져오는 함수
  Future<List<dynamic>?> getRoutineData(String uid, String routinekey) async {
    // 회원 정보 가져오기
    List<dynamic> resultData = [];
      DatabaseReference dbref = FirebaseDatabase.instance.reference().child("PERSONAL_ROUTINE_INFO").child(uid).child(routinekey);
      // 저장한 데이터 가져오기
      var savedData = await dbref.get();
      if (savedData != null && savedData.value != null) {
        print("저장 데이터: ${savedData.value}");
        Map<dynamic, dynamic> dataMap = jsonDecode(jsonEncode(savedData.value));
        dataMap.forEach((key, value) {
          // 여기서 데이터 처리
          Map<String, dynamic> routinedata = { "key" : key, "value" : dataMap[key]};
          resultData.add(routinedata);
        });
        // 가져온 데이터 처리
      } else {
        print("No data available");
      }
      return resultData;
    }

}


/*
Future<String?> getUID({String? id}) {
  var databaseRef = FirebaseDatabase.instance.ref();
  return Future.delayed(dbTime).then((value) async {
    var event = await databaseRef.child('users/$id/uid').once();
    var value = event.snapshot;
    String uid;
    if (value.exists) {
      uid = value.value.toString();
    } else {
      uid = 'None';
    }
    print('uid : $uid');
    return uid;
  });
}
* */
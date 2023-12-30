import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_altong/Firebase.dart';
import 'package:flutter_altong/controller/alt_06_exerciseController.dart';
import 'package:flutter_altong/screen/alt_04_main.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{
  ExerciseController exerciseController = ExerciseController();

  void loginFunc(String email, String password) async{
    var auth = FirebaseAuth.instance;
    //TODO 로그인 기능 추가
    print("로그인 함수");
    try {
      UserCredential credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (FirebaseAuth.instance.currentUser != null) {
        print(auth.currentUser?.uid);
        print(credential);
        String user = await getFirebaseUserName();
        int kcal = await getFirebaseUserKcal();
        //exerciseController.getRoutine();
        print("로그인 성공 : ${user}");
        Map<String, dynamic> arguments = {
          'user': user,
          'kcal': kcal
        };
        Get.offAllNamed("/main", arguments: arguments);
      }
    } catch (e) {
      print("로그인 실패: $e");
    }
  }




 }



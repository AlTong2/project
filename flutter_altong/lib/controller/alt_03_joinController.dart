import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_altong/screen/alt_01_start.dart';
import 'package:get/get.dart';

class JoinController extends GetxController{
  void joinFunc(email, password, name, kcal ) async {
    //TODO 회원가입 기능 추가
    print("회원가입 함수");
    try {
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if(credential.user != null){
        // uid, email, name, kcal을 등록
        await createNewUser(uid: credential.user!.uid,email: email ,name: name, kcal : int.parse(kcal) );
      }
      Get.offAll(() => ALT01Start());
    } catch (e) {
      print("회원가입 실패: $e");
    }
  }

  Future<void> createNewUser({required String uid, required String email,required String name, required int kcal}) async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    DatabaseReference dbref = database.ref("member_info");
    return Future.delayed(Duration(seconds: 3)).then((value) async {
      var value = await dbref.child('$uid').get();
      if (value.exists) {
        print('$uid exists');
      } else {
        await dbref.update({
          '$uid/email': email,
          '$uid/name': name,
          '$uid/kcal': kcal,
        });
      }
    });
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '비밀번호를 입력해주세요.';
    } else if (value.length < 6) {
      return '비밀번호를 6자 이상 입력해주세요.';
    }
    return null; // 유효성 검사 통과
  }

 }

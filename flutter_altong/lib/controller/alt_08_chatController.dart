
import 'package:get/get.dart';

class ChatController extends GetxController{
  //TODO 채팅 입력 받았을때 GPT답변 받아오기
  RxList<String> messages = <String>[].obs; // RxList를 사용하여 관찰 가능한 리스트로 만듦
  //RxList<String> answers = <String>[].obs;
  void sendMessage(String message) {
    messages.add(message);
    //TODO message를 챗gpt로 보내는 코드 작성
    //TODO 받아온 답변을 messages 추가하는 코드 작성
    messages.add("알통이가 답변해줄겁니다.");
  }
}
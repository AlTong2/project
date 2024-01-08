
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ChatController extends GetxController{
  RxList<String> messages = <String>[].obs; // RxList를 사용하여 관찰 가능한 리스트로 만듦
  RxList<bool> answer = <bool>[].obs;

  //RxList<String> answers = <String>[].obs;
  void sendMessage(String message) async {
    messages.add(message);
    addTrue(true);
    String answer = await generateText(message);
    messages.add(answer);
    addTrue(false);
  }

  void addTrue(bool value) {
    answer.add(value);
  }
  void addFalse(bool value) {
    answer.add(value);
  }

  Future<String> generateText(String prompt) async {
    String answer = "";
    String model = dotenv.get("openAI_model");
    String apiKey = dotenv.get("openAI_key");
    String url = dotenv.get("openAI_url");
    var response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': model,
        "messages": [
          {"role": "user", "content": prompt}
        ],
        //'prompt': prompt,
        'max_tokens': 500,
        'temperature': 0.5,
        'n': 1,
        //'stop': '.'
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      print( "답변 확인 : ${data}");
      var responseBody = response.body;
      var decodedString = utf8.decode(responseBody.runes.toList());

      var content = utf8.decode(data['choices'][0]['message']['content'].codeUnits);
      print("변환된 답변: $content");
      answer = content;
    } else {
      var data = jsonDecode(response.body);
      print("리스폰스 코드 : ${response.statusCode}");
      print(data);
      answer = "오류";
    }

    return answer;
  }

  void sendFormat(String gender,String age,String height,String weight,String activityLevel,String goalWeight){
    String msg = "";
    msg += "성별 : " + gender + "\n";
    msg += "나이 : " + age + "\n";
    msg += "키 : " + height + "\n";
    msg += "몸무게 : " + weight + "\n";
    msg += "활동 수준 : " + activityLevel + "\n";
    msg += "목표 몸무게 : " + goalWeight + "\n";
    print(msg);
    sendMessage(msg);
    Get.back();
  }



}
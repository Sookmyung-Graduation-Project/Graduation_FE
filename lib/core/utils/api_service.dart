import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static final String baseUrl = 'http://localhost:8000';

  static Future<void> sendTokenToBackend(
      String accessToken, String provider) async {
    // 각 provider에 맞는 경로로 요청을 보냄
    String url = '$baseUrl/login/$provider'; // /login/kakao 또는 /login/google

    final body = json.encode({
      'access_token': accessToken,
    });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      // 응답 상태 코드와 본문을 로그로 출력
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('Token sent to backend successfully');
      } else {
        print('Failed to send token to backend: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending token to backend: $e');
    }
  }
}

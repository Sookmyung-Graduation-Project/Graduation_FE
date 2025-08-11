import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:phonics/core/const/const.dart';

class ApiService {
  static Future<void> sendTokenToBackend(
      String accessToken, String provider) async {
    String url = '${ApiUrls.loginUrl}/$provider';

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

      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        print('==백엔드로 access token 전송 성공==');
        final responseData = json.decode(response.body);
        print('Response data: $responseData');
        return responseData;
      } else {
        print('Error: ${response.statusCode}');
        return;
      }
    } catch (e) {
      print('Error sending token to backend: $e');
      return;
    }
  }

  // backend에서 user info를 가져오는 함수
}

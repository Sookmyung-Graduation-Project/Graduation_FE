import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:phonics/core/const/const.dart';

class ApiService {
  static Future<Map<String, dynamic>> sendTokenToBackend({
    required String accessToken,
    required String provider,
  }) async {
    final url = Uri.parse('${ApiUrls.loginUrl}/$provider');
    final body = json.encode({'access_token': accessToken});

    final resp = await http
        .post(url, headers: {'Content-Type': 'application/json'}, body: body)
        .timeout(const Duration(seconds: 10));

    if (resp.statusCode == 200) {
      return json.decode(resp.body) as Map<String, dynamic>;
    }
    throw Exception('Login failed: ${resp.statusCode} ${resp.body}');
  }

  // backend에서 user info를 가져오는 함수 - FetchMyInfo
  static Future<Map<String, dynamic>?> fetchMyInfo(
      {required String jwt}) async {
    final url = Uri.parse(ApiUrls.userInfoUrl);
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('==유저 정보조회 실패== ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('==유저 정보조회 실패== $e');
      return null;
    }
  }
}

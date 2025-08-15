import 'dart:async';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:phonics/core/const/api_urls.dart';

class ApiService {
  // 로그인 시 토큰을 백엔드로 전송
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

  // User 정보 조회
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

  // 내 음성 데이터 조회
  static Future<List<Map<String, dynamic>>?> fetchMyVoices({
    required String jwt,
  }) async {
    final url = Uri.parse(ApiUrls.fetchMyVoicesUrl);
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
      ).timeout(const Duration(seconds: 10));

      final bodyText = utf8.decode(response.bodyBytes);

      if (response.statusCode == 200) {
        final decoded = json.decode(bodyText);
        if (decoded is List) {
          // 각 요소를 Map<String, dynamic>으로 안전 캐스팅
          return decoded
              .map<Map<String, dynamic>>(
                  (e) => Map<String, dynamic>.from(e as Map))
              .toList(growable: false);
        } else {
          print('==보이스 조회 실패== 예기치 않은 응답 형태: $bodyText');
          return null;
        }
      } else if (response.statusCode == 401) {
        // 토큰 만료 가능성 → 호출부에서 재로그인/토큰갱신 유도
        print('==보이스 조회 실패(401)== 인증 오류: $bodyText');
        return null;
      } else {
        print('==보이스 조회 실패== ${response.statusCode} $bodyText');
        return null;
      }
    } on TimeoutException {
      print('==보이스 조회 실패== 요청 시간 초과');
      return null;
    } catch (e) {
      print('==보이스 조회 실패== $e');
      return null;
    }
  }
}

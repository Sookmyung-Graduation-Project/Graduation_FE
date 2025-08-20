import 'dart:async';
import 'dart:typed_data';

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

  // IVC 업로드
  static Future<Map<String, dynamic>?> uploadIvc({
    required String jwt,
    required String name,
    required List<String> files,
    String? description,
  }) async {
    final url = Uri.parse(ApiUrls.uploadIvcUrl);
    try {
      final request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $jwt';

      // 파일 리스트 멀티파트 필드로 추가
      for (var path in files) {
        final file = await http.MultipartFile.fromPath('files', path);
        request.files.add(file);
      }

      // 추가 필드(name, description)
      request.fields['name'] = name;
      if (description != null) {
        request.fields['description'] = description;
      }

      final streamedResponse = await request.send();

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('==IVC 업로드 실패== ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('==IVC 업로드 실패== $e');
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
          return decoded
              .map<Map<String, dynamic>>(
                  (e) => Map<String, dynamic>.from(e as Map))
              .toList(growable: false);
        } else {
          print('==보이스 조회 실패== 예기치 않은 응답 형태: $bodyText');
          return null;
        }
      } else if (response.statusCode == 401) {
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

  static Future<Map<String, dynamic>?> setDefaultVoice({
    required String jwt,
    required String voiceId,
  }) async {
    final url = Uri.parse(ApiUrls.updateDefaultVoiceUrl);
    final body = json.encode({'voice_id': voiceId});
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('==기본 음성 설정 실패== ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('==기본 음성 설정 실패== $e');
      return null;
    }
  }

  static updateDefaultVoice(
      {required String jwt, required String voiceId}) async {
    final url = Uri.parse(ApiUrls.updateDefaultVoiceUrl);
    final body = json.encode({'voice_id': voiceId});
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('==기본 음성 설정 실패== ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('==기본 음성 설정 실패== $e');
      return null;
    }
  }

  static deleteVoice({required String jwt, required String voiceId}) async {
    final url = Uri.parse(ApiUrls.deleteVoiceUrl);
    final body = json.encode({'voice_id': voiceId});
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
        body: body,
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('==음성 삭제 실패== ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('==음성 삭제 실패== $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> renameVoice({
    required String jwt,
    required String voiceId,
    required String newName,
  }) async {
    final url = Uri.parse(ApiUrls.renameVoiceUrl);
    final body = json.encode({
      'voice_id': voiceId,
      'new_name': newName,
    });

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data is Map<String, dynamic> ? data : null;
      } else {
        print('==음성 이름 변경 실패== ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('==음성 이름 변경 실패== $e');
      return null;
    }
  }

  static Future<Uint8List?> testTTSVoice({
    required String jwt,
    required String voiceId,
    required String text,
  }) async {
    final url = Uri.parse(ApiUrls.testVoiceUrl);
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $jwt',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'voice_id': voiceId,
          'text': text,
        },
      );

      if (response.statusCode == 200) {
        return response.bodyBytes; // 바이너리 오디오 데이터 반환
      } else {
        print('==TTS 실패== ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      print('==TTS 실패== $e');
      return null;
    }
  }
}

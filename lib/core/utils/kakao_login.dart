import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:phonics/core/user/data/kakao_login_result.dart';
import 'package:phonics/core/user/data/user_info.dart';
import 'package:phonics/core/user/data/user_state.dart';
import 'package:phonics/core/user/data/user_voice.dart';
import 'package:phonics/core/utils/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KakaoLoginApi {
  Future<KakaoLoginResult?> signWithKakao() async {
    try {
      OAuthToken token;

      // 1) 카카오 로그인
      if (await isKakaoTalkInstalled()) {
        try {
          token = await UserApi.instance.loginWithKakaoTalk();
        } catch (error) {
          print('카카오톡 로그인 실패: $error');
          if (error is PlatformException && error.code == 'CANCELED')
            return null;
          token = await UserApi.instance.loginWithKakaoAccount();
        }
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      // 2) 백엔드 로그인 (JWT)
      final login = await ApiService.sendTokenToBackend(
        accessToken: token.accessToken,
        provider: 'kakao',
      );
      print('==로그인 응답== $login');
      final jwt = login['access_token'] as String;

      // 3) 토큰 저장
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', jwt);

      // 4) 내 정보
      final meJson = await ApiService.fetchMyInfo(jwt: jwt);
      if (meJson == null) throw Exception("fetchMyInfo returned null");
      final me = UserInfo.fromJson(meJson);

      // 5) 내 보이스 목록 (실패해도 로그인은 계속)
      final getVoices = await ApiService.fetchMyVoices(jwt: jwt);
      final List<VoiceItem> voices = (getVoices ?? [])
          .map<VoiceItem>(
              (e) => VoiceItem.fromJson(Map<String, dynamic>.from(e)))
          .toList(growable: false);
      print('==보이스 목록== ${voices.length}개');

      // 6) 기본 보이스 로컬 저장
      final defaultVoiceDocId = meJson['default_voice_id'] as String?;
      if (defaultVoiceDocId != null && defaultVoiceDocId.isNotEmpty) {
        await prefs.setString('selected_voice_doc_id', defaultVoiceDocId);
      } else if (voices.isNotEmpty) {
        await prefs.setString('selected_voice_doc_id', voices.first.id);
      }

      // 7) 카카오 프로필 (UI용)
      final kakaoUser = await UserApi.instance.me();

      final userResponse = UserResponse(
        userId: kakaoUser.id.toString(),
        nickname: kakaoUser.properties?['nickname'] ?? 'No Name',
        profileImage: kakaoUser.properties?['profile_image'] ?? '',
        accessToken: jwt,
      );

      print('==로그인 성공== ${userResponse.nickname}');
      print('==유저 정보== ${me.nickname} / ${me.id} / provider=${me.provider}');

      return KakaoLoginResult(
        userResponse: userResponse,
        userInfo: me,
        voices: voices,
        defaultVoiceDocId: defaultVoiceDocId,
      );
    } catch (error) {
      print('카카오계정으로 로그인 실패: $error');
      return null;
    }
  }
}

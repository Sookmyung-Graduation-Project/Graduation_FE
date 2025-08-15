import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:phonics/core/user/data/kakao_login_result.dart';
import 'package:phonics/core/user/data/user_info.dart';
import 'package:phonics/core/user/data/user_state.dart';
import 'package:phonics/core/utils/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KakaoLoginApi {
  Future<KakaoLoginResult?> signWithKakao() async {
    try {
      OAuthToken token;
      //1. 카카오톡이 설치되어 있는지 확인
      if (await isKakaoTalkInstalled()) {
        try {
          token = await UserApi.instance.loginWithKakaoTalk();
        } catch (error) {
          print('카카오톡으로 로그인 실패 $error');

          if (error is PlatformException && error.code == 'CANCELED') {
            return null;
          }

          token = await UserApi.instance.loginWithKakaoAccount();
        }
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      //2. 백엔드에 액세스 토큰 전송
      final login = await ApiService.sendTokenToBackend(
        accessToken: token.accessToken,
        provider: 'kakao',
      );

      final jwt = login['access_token'] as String;

      // 3.  JWT 저장(shared_preferences 사용)
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', jwt);

      // 4. 백엔드에서 사용자 정보 가져오기
      final meJson = await ApiService.fetchMyInfo(jwt: jwt);
      if (meJson == null) {
        throw Exception("fetchMyInfo returned null");
      }

      final me = UserInfo.fromJson(meJson);

      // 카카오 로그인 후 사용자 정보 가져오기
      User user = await UserApi.instance.me();

      // User 객체 -> UserResponse로 변환하여 반환
      UserResponse userResponse = UserResponse(
        userId: user.id.toString(),
        nickname: user.properties?['nickname'] ?? 'No Name',
        profileImage: user.properties?['profile_image'] ?? '',
        accessToken: '',
      );
      print(
          '==로그인 성공==: ${userResponse.nickname}, accessToken: ${userResponse.accessToken}');
      print(
          '==유저 정보조회 성공 ==: UserNickname: ${me.nickname} , UserId: ${me.id}, ProfileImage: ${me.profileImage}, 소셜 로그인: ${me.provider}');
      return KakaoLoginResult(
        userResponse: userResponse,
        userInfo: me,
      );
    } catch (error) {
      print('카카오계정으로 로그인 실패: $error');
      return null;
    }
  }
}

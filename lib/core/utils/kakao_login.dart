import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:phonics/core/user/data/user_state.dart';
import 'package:phonics/core/utils/api_service.dart';

class KakaoLoginApi {
  Future<UserResponse?> signWithKakao() async {
    try {
      OAuthToken token;
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

      print('AccessToken: ${token.accessToken}');
      print('RefreshToken: ${token.refreshToken}');

      await ApiService.sendTokenToBackend(token.accessToken, 'kakao');

      // 카카오 로그인 후 사용자 정보 가져오기
      User user = await UserApi.instance.me();

      // User 객체 -> UserResponse로 변환하여 반환
      UserResponse userResponse = UserResponse(
        userId: user.id.toString(),
        nickname: user.properties?['nickname'] ?? 'No Name',
      );

      print('로그인 성공: ${userResponse.nickname}, UserId: ${userResponse.userId}');
      return userResponse; // UserResponse 객체 반환
    } catch (error) {
      print('카카오계정으로 로그인 실패: $error');
      return null; // 로그인 실패 시 null 반환
    }
  }
}

import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:phonics/core/utils/api_service.dart';

class KakaoLoginApi {
  Future<User?> signWithKakao() async {
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

      User user = await UserApi.instance.me();
      return user;
    } catch (error) {
      print('카카오계정으로 로그인 실패: $error');
      return null;
    }
  }
}

// lib/core/user/data/kakao_login_result.dart
import 'package:phonics/core/user/data/user_info.dart';
import 'package:phonics/core/user/data/user_state.dart';

class KakaoLoginResult {
  final UserResponse userResponse;
  final UserInfo userInfo;

  KakaoLoginResult({
    required this.userResponse,
    required this.userInfo,
  });
}

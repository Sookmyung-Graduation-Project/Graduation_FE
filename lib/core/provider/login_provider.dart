import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonics/core/user/data/user_state.dart';
import 'package:phonics/core/utils/kakao_login.dart'; // KakaoLoginApi

// 로그인 후 반환된 UserResponse 모델을 관리하는 Provider
// nickname, userId,
final userResponseProvider =
    StateNotifierProvider<UserResponseNotifier, UserResponse?>((ref) {
  return UserResponseNotifier();
});

class UserResponseNotifier extends StateNotifier<UserResponse?> {
  UserResponseNotifier() : super(null);

  // 카카오 로그인 후 userResponse 상태 업데이트
  Future<void> signInWithKakao() async {
    final kakaoLoginApi = KakaoLoginApi();
    final user = await kakaoLoginApi.signWithKakao();
    state = user;
  }

  // 로그아웃 처리 -> 상태 초기화
  void logout() {
    state = null;
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonics/core/user/data/user_state.dart';
// KakaoLoginApi

// 로그인 후 반환된 UserResponse 모델을 관리하는 Provider
// nickname, userId,
final userResponseProvider =
    StateNotifierProvider<UserResponseNotifier, UserResponse?>(
  (ref) => UserResponseNotifier(),
);

class UserResponseNotifier extends StateNotifier<UserResponse?> {
  UserResponseNotifier() : super(null);
  void set(UserResponse? v) => state = v;
  void clear() => state = null;
}

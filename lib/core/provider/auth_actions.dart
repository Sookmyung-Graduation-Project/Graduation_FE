// auth_actions.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonics/core/provider/login_provider.dart';
import 'package:phonics/core/provider/user_info_provider.dart';
import 'package:phonics/core/utils/kakao_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> signInWithKakao(WidgetRef ref) async {
  final kakao = KakaoLoginApi();
  final result = await kakao.signWithKakao();
  if (result == null) {
    if (kDebugMode) debugPrint('[auth] Kakao login canceled/failed');
    throw Exception('Kakao login canceled/failed');
  }

  ref.read(userResponseProvider.notifier).set(result.userResponse);
  ref.read(serverUserProvider.notifier).set(result.userInfo);
}

Future<void> logoutAll(WidgetRef ref) async {
  ref.read(userResponseProvider.notifier).clear();
  ref.read(serverUserProvider.notifier).clear();
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('access_token');
  if (kDebugMode) debugPrint('[auth] logoutAll: cleared state & token');
}

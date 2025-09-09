// lib/core/provider/jwt_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final jwtProvider = StateProvider<String?>((ref) => null);

// 앱 시작 시 한 번 호출해서 메모리에 올려두기
final jwtInitProvider = FutureProvider<void>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('access_token');
  ref.read(jwtProvider.notifier).state = token;
});

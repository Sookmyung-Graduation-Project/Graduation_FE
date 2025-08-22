// lib/core/provider/user_info_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonics/core/models/user/user_info.dart';

final serverUserProvider = StateNotifierProvider<ServerUserNotifier, UserInfo?>(
  (ref) => ServerUserNotifier(),
);

class ServerUserNotifier extends StateNotifier<UserInfo?> {
  ServerUserNotifier() : super(null);
  void set(UserInfo? v) => state = v;
  void clear() => state = null;
}

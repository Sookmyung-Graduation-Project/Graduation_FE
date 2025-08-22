// lib/core/user/data/kakao_login_result.dart
import 'package:phonics/core/models/user/user_info.dart';
import 'package:phonics/core/models/user/user_state.dart';
import 'package:phonics/core/models/user/user_voice.dart';

class KakaoLoginResult {
  final UserResponse userResponse;
  final UserInfo userInfo;
  final List<VoiceItem> voices;
  final String? defaultVoiceDocId;

  KakaoLoginResult({
    required this.userResponse,
    required this.userInfo,
    required this.voices,
    this.defaultVoiceDocId,
  });
}

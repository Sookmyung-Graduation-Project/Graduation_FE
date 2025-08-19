class DefaultVoice {
  final String voiceId;

  DefaultVoice({required this.voiceId});

  // JSON을 Dart 객체로 변환
  factory DefaultVoice.fromJson(Map<String, dynamic> json) {
    return DefaultVoice(
      voiceId: json['voice_id'] as String? ?? '',
    );
  }
  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'voice_id': voiceId,
    };
  }
}

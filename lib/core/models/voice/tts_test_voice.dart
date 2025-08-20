class TestTTSVoice {
  final String voiceId;

  TestTTSVoice({required this.voiceId});

  factory TestTTSVoice.fromJson(Map<String, dynamic> json) {
    return TestTTSVoice(
      voiceId: json['voice_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voice_id': voiceId,
    };
  }
}

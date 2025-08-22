class DefaultVoice {
  final String voiceId;

  DefaultVoice({required this.voiceId});

  factory DefaultVoice.fromJson(Map<String, dynamic> json) {
    return DefaultVoice(
      voiceId: json['voice_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voice_id': voiceId,
    };
  }
}

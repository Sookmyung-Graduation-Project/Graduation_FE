class DeleteVoice {
  final String voiceId;

  DeleteVoice({required this.voiceId});

  factory DeleteVoice.fromJson(Map<String, dynamic> json) {
    return DeleteVoice(
      voiceId: json['voice_id'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voice_id': voiceId,
    };
  }
}

class RenameVoice {
  final String voiceId;
  final String newName;

  RenameVoice({
    required this.voiceId,
    required this.newName,
  });

  factory RenameVoice.fromJson(Map<String, dynamic> json) {
    return RenameVoice(
      voiceId: json['voice_id'] as String? ?? '',
      newName: json['new_name'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voice_id': voiceId,
      'new_name': newName,
    };
  }
}

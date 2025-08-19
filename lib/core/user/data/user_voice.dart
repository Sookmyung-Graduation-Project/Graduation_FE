// lib/phonics/core/user/data/user_voice.dart
class VoiceItem {
  final String id; // "_id"
  final String voiceName; // "voice_name"
  final String voiceId; // "voice_id" (ElevenLabs)
  final String? description;
  final DateTime? createdAt;
  final bool defaultId;

  VoiceItem({
    required this.id,
    required this.voiceName,
    required this.voiceId,
    this.description,
    this.createdAt,
    required this.defaultId,
  });

  factory VoiceItem.fromJson(Map<String, dynamic> json) {
    return VoiceItem(
        id: json['_id'] as String,
        voiceName: json['voice_name'] as String? ?? '',
        voiceId: json['voice_id'] as String? ?? '',
        description: json['description'] as String?,
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'] as String)
            : null,
        defaultId: (json['default_id'] is bool) ? json['default_id'] : false);
  }
}

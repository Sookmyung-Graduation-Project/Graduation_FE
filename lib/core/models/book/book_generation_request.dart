class BookGenerationRequest {
  final String gender;
  final String ageGroup;
  final String lesson;
  final String character;
  final String voice;

  BookGenerationRequest({
    required this.gender,
    required this.ageGroup,
    required this.lesson,
    required this.character,
    required this.voice,
  });

  Map<String, dynamic> toJson() {
    return {
      'gender': gender,
      'age_group': ageGroup,
      'lesson': lesson,
      'character': character,
      'voice': voice,
    };
  }

  factory BookGenerationRequest.fromJson(Map<String, dynamic> json) {
    return BookGenerationRequest(
      gender: json['gender'] as String,
      ageGroup: json['age_group'] as String,
      lesson: json['lesson'] as String,
      character: json['character'] as String,
      voice: json['voice'] as String,
    );
  }
}

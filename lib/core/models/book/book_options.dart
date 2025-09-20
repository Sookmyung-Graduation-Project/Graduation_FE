class BookOptions {
  final List<String> genders;
  final List<String> ageGroups;
  final List<String> lessons;
  final List<String> characters;
  final List<String> voices;

  BookOptions({
    required this.genders,
    required this.ageGroups,
    required this.lessons,
    required this.characters,
    required this.voices,
  });

  factory BookOptions.fromJson(Map<String, dynamic> json) {
    return BookOptions(
      genders: (json['genders'] as List?)?.cast<String>() ?? [],
      ageGroups: (json['age_groups'] as List?)?.cast<String>() ?? [],
      lessons: (json['lessons'] as List?)?.cast<String>() ?? [],
      characters: (json['characters'] as List?)?.cast<String>() ?? [],
      voices: (json['voices'] as List?)?.cast<String>() ?? [],
    );
  }
}

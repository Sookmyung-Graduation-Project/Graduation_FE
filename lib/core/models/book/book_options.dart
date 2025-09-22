class BookOptions {
  final List<String> genders;
  final List<String> ageGroups;
  final List<String> lessons;
  final List<String> animals;
  final List<String> voiceOptions;

  BookOptions({
    required this.genders,
    required this.ageGroups,
    required this.lessons,
    required this.animals,
    required this.voiceOptions,
  });

  factory BookOptions.fromJson(Map<String, dynamic> json) {
    List<String> toList(dynamic v) =>
        (v as List).map((e) => e.toString()).toList();
    return BookOptions(
      genders: toList(json['genders']),
      ageGroups: toList(json['age_groups']),
      lessons: toList(json['lessons']),
      animals: toList(json['animals']),
      voiceOptions: toList(json['voice_options']),
    );
  }
}

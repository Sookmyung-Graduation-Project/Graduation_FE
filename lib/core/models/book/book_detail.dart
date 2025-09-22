class BookDetail {
  final String id;
  final String title;
  final String author;
  final String gender;
  final String ageGroup;
  final String lesson;
  final String animal;
  final String voiceOption;
  final List<String> pages;
  final String summary;
  final List<String> characters;
  final String setting;
  final DateTime createdAt;
  final DateTime updatedAt;

  const BookDetail({
    required this.id,
    required this.title,
    required this.author,
    required this.gender,
    required this.ageGroup,
    required this.lesson,
    required this.animal,
    required this.voiceOption,
    required this.pages,
    required this.summary,
    required this.characters,
    required this.setting,
    required this.createdAt,
    required this.updatedAt,
  });

  int get pageCount => pages.length;

  /// JSON -> Model
  factory BookDetail.fromJson(Map<String, dynamic> json) {
    List<String> toStringList(dynamic v) {
      if (v == null) return const <String>[];
      return (v as List).map((e) => e.toString()).toList(growable: false);
    }

    return BookDetail(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      gender: json['gender'] as String,
      ageGroup: json['age_group'] as String,
      lesson: json['lesson'] as String,
      animal: json['animal'] as String,
      voiceOption: json['voice_option'] as String,
      pages: toStringList(json['pages']),
      summary: json['summary'] as String,
      characters: toStringList(json['characters']),
      setting: json['setting'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'gender': gender,
        'age_group': ageGroup,
        'lesson': lesson,
        'animal': animal,
        'voice_option': voiceOption,
        'pages': pages,
        'summary': summary,
        'characters': characters,
        'setting': setting,
        'created_at': createdAt.toIso8601String(),
        'updated_at': updatedAt.toIso8601String(),
      };

  BookDetail copyWith({
    String? id,
    String? title,
    String? author,
    String? gender,
    String? ageGroup,
    String? lesson,
    String? animal,
    String? voiceOption,
    List<String>? pages,
    String? summary,
    List<String>? characters,
    String? setting,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      gender: gender ?? this.gender,
      ageGroup: ageGroup ?? this.ageGroup,
      lesson: lesson ?? this.lesson,
      animal: animal ?? this.animal,
      voiceOption: voiceOption ?? this.voiceOption,
      pages: pages ?? this.pages,
      summary: summary ?? this.summary,
      characters: characters ?? this.characters,
      setting: setting ?? this.setting,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() => 'BookDetail($title, $ageGroup, $lesson, $animal)';
}

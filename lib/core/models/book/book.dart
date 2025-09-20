class BookItem {
  final String id;
  final String title;
  final String author;
  final String ageGroup;
  final String lesson;
  final String animal;
  final String summary;
  final DateTime createdAt;
  final int pageCount;

  const BookItem({
    required this.id,
    required this.title,
    required this.author,
    required this.ageGroup,
    required this.lesson,
    required this.animal,
    required this.summary,
    required this.createdAt,
    required this.pageCount,
  });

  factory BookItem.fromJson(Map<String, dynamic> json) {
    return BookItem(
      id: json['id'] as String,
      title: json['title'] as String,
      author: json['author'] as String,
      ageGroup: json['age_group'] as String,
      lesson: json['lesson'] as String,
      animal: json['animal'] as String,
      summary: json['summary'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      pageCount: (json['page_count'] as num).toInt(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'age_group': ageGroup,
        'lesson': lesson,
        'animal': animal,
        'summary': summary,
        'created_at': createdAt.toIso8601String(),
        'page_count': pageCount,
      };
}

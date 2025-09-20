class BookSummary {
  final String bookId;
  final String title;
  final String createdAt;
  final String status;
  final String? thumbnailUrl;

  BookSummary({
    required this.bookId,
    required this.title,
    required this.createdAt,
    required this.status,
    this.thumbnailUrl,
  });

  factory BookSummary.fromJson(Map<String, dynamic> json) {
    return BookSummary(
      bookId: json['book_id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      createdAt: json['created_at'] as String? ?? '',
      status: json['status'] as String? ?? '',
      thumbnailUrl: json['thumbnail_url'] as String?,
    );
  }
}

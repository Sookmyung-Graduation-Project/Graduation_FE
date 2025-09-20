class BookGenerationResponse {
  final String bookId;
  final String title;
  final List<BookPage> pages;
  final String status;

  BookGenerationResponse({
    required this.bookId,
    required this.title,
    required this.pages,
    required this.status,
  });

  factory BookGenerationResponse.fromJson(Map<String, dynamic> json) {
    // API 응답에서 story_content 파싱
    final storyContent = json['story_content'] as String? ?? '';
    final pages = _parseStoryContent(storyContent);
    
    return BookGenerationResponse(
      bookId: json['book_id'] as String? ?? '',
      title: _extractTitle(storyContent),
      pages: pages,
      status: json['success'] == true ? 'completed' : 'failed',
    );
  }

  static String _extractTitle(String storyContent) {
    final titleMatch = RegExp(r'제목:\s*(.+?)(?:\n|$)').firstMatch(storyContent);
    return titleMatch?.group(1)?.trim() ?? 'Generated Story';
  }

  static List<BookPage> _parseStoryContent(String storyContent) {
    final pages = <BookPage>[];
    final pageRegex = RegExp(r'페이지\s*(\d+):\s*(.+?)(?=페이지\s*\d+:|$)');
    
    final matches = pageRegex.allMatches(storyContent);
    for (final match in matches) {
      final pageNumber = int.tryParse(match.group(1) ?? '0') ?? 0;
      final pageText = match.group(2)?.trim() ?? '';
      
      pages.add(BookPage(
        pageNumber: pageNumber,
        text: pageText,
        imageUrl: null, // 이미지는 별도로 생성될 수 있음
      ));
    }
    
    return pages;
  }
}

class BookPage {
  final int pageNumber;
  final String text;
  final String? imageUrl;

  BookPage({
    required this.pageNumber,
    required this.text,
    this.imageUrl,
  });

  factory BookPage.fromJson(Map<String, dynamic> json) {
    return BookPage(
      pageNumber: json['page_number'] as int? ?? 0,
      text: json['text'] as String? ?? '',
      imageUrl: json['image_url'] as String?,
    );
  }
}

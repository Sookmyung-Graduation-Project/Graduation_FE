import 'package:phonics/core/models/book/book_generation_response.dart';

/// 실제 API 응답을 기반으로 한 목업 데이터
class BookMockReal {
  /// 실제 API 응답 데이터
  static final Map<String, dynamic> realApiResponse = {
    "success": true,
    "message": "동화가 성공적으로 생성되었습니다.",
    "book_id": "68cebf912d3caa0cb977319a",
    "story_content": """제목: Benny the Bear's New Friends

요약: Benny the Bear discovered the joy of friendship while playing with Rabbit and Parrot. They learned that friends help each other and make fun times even better!

등장인물: Benny the Bear, Rabbit, Parrot

배경: A sunny day in a big, green forest

동화 내용:

페이지 1: Page 1: In a big, green forest, there lived a cuddly bear named Benny. Benny loved to explore and play all day long.
페이지 2: Page 2: One sunny morning, Benny woke up and decided he wanted to make some new friends. He smiled and set off on his adventure.
페이지 3: Page 3: As Benny walked, he saw a little rabbit hopping by. 'Hello, Rabbit! Would you like to play with me?' Benny asked excitedly.
페이지 4: Page 4: The rabbit smiled and said, 'Sure, Benny! Let's hop and play together!' Benny was happy to have a friend.
페이지 5: Page 5: Next, Benny and Rabbit found a colorful parrot sitting on a branch. 'Hello, Parrot! Come join us!' Benny called out.
페이지 6: Page 6: The parrot flapped its wings and said, 'I would love to! Let's play a game of hide and seek!' Together, they all had so much fun.
페이지 7: Page 7: As they played, they laughed and shared snacks. Benny felt warm and fuzzy inside because he had friends to share happiness with.
페이지 8: Page 8: Suddenly, Benny tripped and fell. Rabbit and Parrot rushed to help him up. 'Don't worry, Benny! We are here for you!' they said.
페이지 9: Page 9: Benny smiled and realized that friends help each other. 'Thank you, my friends! Together, we are strong!' he said happily.
페이지 10: Page 10: From that day on, Benny, Rabbit, and Parrot played together every day. They learned that friendship is special and makes every adventure better.""",
    "error": null
  };

  /// 실제 API 응답을 BookGenerationResponse로 변환
  static BookGenerationResponse get realBookResponse {
    return BookGenerationResponse.fromJson(realApiResponse);
  }

  /// 테스트용 간단한 책 데이터
  static BookGenerationResponse get testBookResponse {
    return BookGenerationResponse(
      bookId: "test_book_123",
      title: "Benny the Bear's New Friends",
      pages: [
        BookPage(pageNumber: 1, text: "In a big, green forest, there lived a cuddly bear named Benny. Benny loved to explore and play all day long."),
        BookPage(pageNumber: 2, text: "One sunny morning, Benny woke up and decided he wanted to make some new friends. He smiled and set off on his adventure."),
        BookPage(pageNumber: 3, text: "As Benny walked, he saw a little rabbit hopping by. 'Hello, Rabbit! Would you like to play with me?' Benny asked excitedly."),
        BookPage(pageNumber: 4, text: "The rabbit smiled and said, 'Sure, Benny! Let's hop and play together!' Benny was happy to have a friend."),
        BookPage(pageNumber: 5, text: "Next, Benny and Rabbit found a colorful parrot sitting on a branch. 'Hello, Parrot! Come join us!' Benny called out."),
      ],
      status: "completed",
    );
  }
}

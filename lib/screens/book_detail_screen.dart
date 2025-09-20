//lib/screens/book_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phonics/core/router/routes.dart';
import 'package:phonics/core/models/book/book_generation_response.dart';
import 'package:phonics/widgets/basic_lg_button_for_text.dart';
import 'package:phonics/widgets/book_detail/book_detail_card.dart';

class BookDetailScreen extends StatelessWidget {
  final BookGenerationResponse book;

  const BookDetailScreen({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFEB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BookDetailCard(
              title: book.title,
              imageUrl: book.pages.isNotEmpty ? book.pages.first.imageUrl : null,
              coin: 0, // API에서 제공하지 않음
              rating: 5.0, // 기본값
              age: '만 4~5세', // 기본값
              pages: '${book.pages.length} 페이지',
              duration: '10분', // 기본값
              summary: book.pages.isNotEmpty ? book.pages.first.text : '동화책 내용',
            ),
            GoToBookButton(book: book),
            const SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class GoToBookButton extends StatelessWidget {
  final BookGenerationResponse book;

  const GoToBookButton({
    super.key,
    required this.book,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: BasicLgButtonForText(
        onPressed: () {
          context.go(
            '${Routes.homeTab}/${Routes.bookDetail}/${Routes.bookContent}',
            extra: book,
          );
        },
        title: '책 읽으러 가기',
      ),
    );
  }
}

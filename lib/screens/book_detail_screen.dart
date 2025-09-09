//lib/screens/book_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phonics/core/router/routes.dart';
import 'package:phonics/widgets/basic_lg_button_for_text.dart';
import 'package:phonics/widgets/book_detail/book_detail_card.dart';

class BookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> book;

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
              title: book['title'],
              imageUrl: book['image'],
              coin: book['point'],
              rating: book['rating'],
              age: '만 4~5세',
              pages: '10 페이지',
              duration: '10분',
              summary: book['summary'],
            ),
            GoToBookButton(book: book),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }
}

class GoToBookButton extends StatelessWidget {
  final Map<String, dynamic> book;

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

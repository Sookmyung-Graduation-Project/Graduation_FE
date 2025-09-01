import 'package:flutter/material.dart';
import 'package:phonics/book_content_screen.dart';
import 'package:phonics/widgets/basic_lg_button_for_text.dart';
import 'package:phonics/widgets/book_detail/book_detail_card.dart';

class BookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFEB),
      appBar: AppBar(
        title: Text(book['title'] ?? '책 정보'),
        backgroundColor: Color(0xffFFFFEB),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
            BasicLgButtonForText(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BookContentScreen(
                      pages: List<String>.from(book['content']),
                    ),
                  ),
                );
              },
              title: '책 읽으러 가기',
            ),
          ],
        ),
      ),
    );
  }
}

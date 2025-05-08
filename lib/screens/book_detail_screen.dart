import 'package:flutter/material.dart';
import 'package:phonics/widgets/book_detail/book_detail_card.dart';

class BookDetailScreen extends StatelessWidget {
  final Map<String, dynamic> book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(book['title'] ?? '책 정보')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BookDetailCard(
          title: book['title'],
          imageUrl: book['image'],
          coin: book['point'],
          rating: book['rating'],
          age: '만 4~5세',
          pages: '10 페이지',
          duration: '10분',
        ),
      ),
    );
  }
}

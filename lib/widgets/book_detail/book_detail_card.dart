import 'package:flutter/material.dart';
import 'book_info_row.dart';
import 'book_rating_coin_row.dart';

class BookDetailCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int coin;
  final double rating;
  final String age;
  final String pages;
  final String duration;
  final String summary;

  const BookDetailCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.coin,
      required this.rating,
      required this.age,
      required this.pages,
      required this.duration,
      this.summary =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit...'});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BookRatingCoinRow(coin: coin, rating: rating, imageUrl: imageUrl),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        BookInfoRow(age: age, pages: pages, duration: duration),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.yellow[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            summary,
            style: TextStyle(fontSize: 13),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class BookInfoRow extends StatelessWidget {
  final String age;
  final String pages;
  final String duration;

  const BookInfoRow({
    super.key,
    required this.age,
    required this.pages,
    required this.duration,
  });

  Widget buildIconText(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, size: 32),
        const SizedBox(height: 4),
        Text(text, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildIconText(Icons.flag, age),
        buildIconText(Icons.menu_book, pages),
        buildIconText(Icons.hourglass_bottom, duration),
      ],
    );
  }
}

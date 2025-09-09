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
        Column(
          children: [
            Image.asset(
              'assets/images/library/age.png',
              width: 49,
            ),
            SizedBox(height: 4),
            Text(age, style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            Image.asset(
              'assets/images/library/pages.png',
              width: 49,
            ),
            SizedBox(height: 4),
            Text(pages, style: TextStyle(fontSize: 12)),
          ],
        ),
        Column(
          children: [
            Image.asset(
              'assets/images/library/duration.png',
              width: 49,
            ),
            SizedBox(height: 4),
            Text(duration, style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    );
  }
}

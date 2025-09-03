import 'package:flutter/material.dart';

class BookContentScreen extends StatelessWidget {
  final List<String> pages; // String → List<String>

  const BookContentScreen({super.key, required this.pages});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("책 읽기")),
      body: PageView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            child: Text(
              pages[index],
              style: const TextStyle(fontSize: 20, height: 1.6),
              textAlign: TextAlign.center,
            ),
          );
        },
      ),
    );
  }
}

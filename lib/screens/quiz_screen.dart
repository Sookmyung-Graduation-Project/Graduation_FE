import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Screen"),
        backgroundColor: const Color(0xffb7c0f9),
      ),
      body: const Center(
        child: Text(
          "Welcome to Quiz!",
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

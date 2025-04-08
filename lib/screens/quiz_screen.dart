import 'package:flutter/material.dart';
import '../widgets/LessonCompleteCard.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  void showLessonCompleteDialog(
      BuildContext context, double screenWidth, double screenHeight) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: LessonCompleteCard(
            screenWidth: screenWidth,
            screenHeight: screenHeight,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz Screen"),
        backgroundColor: const Color(0xffb7c0f9),
      ),
      body: const Center(
        child: Text("퀴즈 내용이 여기에 들어갑니다."),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showLessonCompleteDialog(context, screenWidth, screenHeight);
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

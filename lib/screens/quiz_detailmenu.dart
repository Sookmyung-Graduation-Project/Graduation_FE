import 'dart:ui';

import 'package:flutter/material.dart';
import 'lesson_screen.dart';
import '../widgets/quiz_menu_container.dart'; // LessonScreen import
import '../widgets/quiz_detailmenu_container.dart';

class QuizDetailmenu extends StatelessWidget {
  const QuizDetailmenu({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFEB),
        title: const Text("Quiz Detail Menu"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); //뒤로 가기
          },
          color: const Color(0xff7C7B73),
          icon: const Icon(Icons.arrow_back),
          iconSize: 30,
        ),
      ),
      body: Container(
        color: const Color(0xffFFFFEB), // 원하는 배경 색상 지정
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Level 1',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                '6 Questions',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              QuizDetailMenuContainer(
                width: screenWidth,
                height: screenHeight,
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

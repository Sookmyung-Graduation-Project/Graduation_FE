import 'dart:ui';

import 'package:flutter/material.dart';
import 'lesson_screen.dart';
import '../widgets/quiz_menu_container.dart'; // LessonScreen import

class QuizMenu extends StatelessWidget {
  const QuizMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFEB),
        title: const Text("Quiz Menu"),
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
        color: const Color(0xffFFFFEB),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hi, ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff363535),
                            ),
                          ),
                          Text(
                            'nickname',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xff363535),
                            ),
                          )
                        ],
                      ),
                      Text(
                        "Let's make this day productive",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffA0A09A),
                        ),
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/dinosaur.png',
                    width: 75,
                    height: 75,
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Let's play!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff363535),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuizMenuContainer(
                    onTap: () {},
                  ),
                  QuizMenuContainer(
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuizMenuContainer(
                    onTap: () {},
                  ),
                  QuizMenuContainer(
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  QuizMenuContainer(
                    onTap: () {},
                  ),
                  QuizMenuContainer(
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

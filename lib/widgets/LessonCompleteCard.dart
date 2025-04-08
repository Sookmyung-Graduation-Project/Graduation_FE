import 'package:flutter/material.dart';
import 'dart:math';

class LessonCompleteCard extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;

  const LessonCompleteCard({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: screenWidth * 0.85277777777,
        height: screenHeight * 0.28,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffFAC632),
            width: 10,
          ),
          borderRadius: BorderRadius.circular(45),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 5.0,
              spreadRadius: 0.0,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Stack(
          children: [
            Transform.translate(
              offset:
                  Offset(0, screenWidth * 0.41666666666), // x는 그대로, y를 60px 아래로
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(pi * 2),
                child: Image.asset(
                  'assets/images/words/starburst.png',
                  width: screenWidth * 0.24166666666,
                  height: screenHeight * 0.08265424912,
                ),
              ),
            ),
            //우측 상단
            Transform.translate(
              offset: Offset(screenWidth * 0.60444444444, 0),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateX(pi)
                  ..rotateY(pi), // X축과 Y축 둘 다 π 회전
                child: Image.asset(
                  'assets/images/words/starburst.png',
                  width: screenWidth * 0.24166666666,
                  height: screenHeight * 0.08265424912,
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: screenHeight * 0.03492433061,
                  ),
                  const Text(
                    "Great job!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff363535),
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "You've completed the lesson!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromARGB(255, 197, 146, 7),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // 닫기 버튼
                  SizedBox(
                    height: screenHeight * 0.03492433061,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // <-- Dialog 닫기
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffFAC632),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Icon(Icons.arrow_forward_sharp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

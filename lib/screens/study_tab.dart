import 'package:flutter/material.dart';
import '../widgets/phonics_button.dart';
import '../widgets/quiz_button.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key});

  @override
  _StudyScreenState createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지 + 버튼들
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/phonics_background1.png'),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(20),
            alignment: Alignment.center,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PhonicsButton(),
                SizedBox(height: 20),
                QuizButton(),
              ],
            ),
          ),
          // 왼쪽 상단 뒤로가기 버튼
          Positioned(
            left: screenWidth * 0.055,
            top: screenWidth * 0.055,
            child: SafeArea(
              child: Container(
                width: screenWidth * 0.1,
                height: screenWidth * 0.1,
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0, 2),
                        color: Colors.black.withOpacity(0.3),
                      )
                    ]),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

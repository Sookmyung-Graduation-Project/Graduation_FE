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
      backgroundColor: const Color(0xffFFFFEB),
      appBar: AppBar(
        title: const Text("Quiz Screen"),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/words/Union.png',
                  height: screenHeight * 0.12,
                ),
                Positioned(
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: screenHeight * 0.01164144353),
                    child: const Text(
                      'what is the missing letter?',
                      style: TextStyle(
                        color: Color(0xff363535),
                        fontSize: 26,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

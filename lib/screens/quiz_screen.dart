import 'package:flutter/material.dart';
import 'package:phonics/widgets/basic_lg_button.dart';
import '../widgets/LessonCompleteCard.dart';
import '../widgets/quiz_select_container.dart';
import 'custom_progress_bar.dart';
import 'dart:ui';
import '../data/quizData.dart';
import 'package:flutter/services.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  double progress = 0.0;
  int currentQuestionIndex = 0;
  bool isAnswered = false;
  String? selectedChoice;
  bool isCorrectAnswerSelected = false;

  void _updateProgress() {
    setState(() {
      progress += 0.1;
      if (progress > 1.0) progress = 1.0;
    });
  }

  void goToNextQuiz() {
    if (currentQuestionIndex == quizData.length - 1) {
      Future.delayed(const Duration(milliseconds: 300), () {
        showLessonCompleteDialog(
          context,
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height,
        );
      });
    } else {
      setState(() {
        currentQuestionIndex++;
        progress += 1 / quizData.length;
        isAnswered = false;
      });
    }
  }

  void handleAnswer(String selected) {
    final correct = quizData[currentQuestionIndex]['correctAnswer'];

    setState(() {
      isAnswered = true;
      selectedChoice = selected;
      isCorrectAnswerSelected = selected == correct;
    });

    if (selected == correct) {
      Future.delayed(const Duration(seconds: 1), () {
        if (currentQuestionIndex == quizData.length - 1) {
          showLessonCompleteDialog(
            context,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          );
        } else {
          setState(() {
            currentQuestionIndex++;
            progress += 1 / quizData.length;
            isAnswered = false;
            selectedChoice = null;
            isCorrectAnswerSelected = false;
          });
        }
      });
    } else {
      // 오답이면 다시 선택 가능 상태로
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isAnswered = false;
          selectedChoice = null;
          isCorrectAnswerSelected = false;
        });
      });

      HapticFeedback.heavyImpact();
    }
  }

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

    final currentQuiz = quizData[currentQuestionIndex];
    final String? word = currentQuiz['word'];
    final String? correct = currentQuiz['correctAnswer'];
    final int? missingIndex = currentQuiz['missingIndex'];
    return Scaffold(
      backgroundColor: const Color(0xffFFFFEB),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Progress bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                children: [
                  Expanded(child: DinosaurProgressBar(progress: progress)),
                ],
              ),
            ),

            // 말풍선
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/words/Union.png',
                  height: screenHeight * 0.12,
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: screenHeight * 0.0116),
                  child: const Text(
                    'What is the missing letter?',
                    style: TextStyle(
                      color: Color(0xff363535),
                      fontSize: 26,
                    ),
                  ),
                ),
              ],
            ),

            // 퀴즈 이미지
            Image.asset(
              currentQuiz['image'],
              width: screenWidth * 0.5,
            ),
            // 퀴즈 단어 표시
            // 퀴즈 단어 표시
            Text.rich(
              (word != null &&
                      missingIndex != null &&
                      missingIndex >= 0 &&
                      missingIndex < word.length)
                  ? (isAnswered
                      ? TextSpan(
                          text: word, // 정답 맞춘 전체 단어
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2FAF8A),
                          ),
                        )
                      : TextSpan(
                          text: word.replaceRange(
                              missingIndex, missingIndex + 1, '_'),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ))
                  : const TextSpan(
                      text: '_____',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            // 선택지
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Wrap(
                children: currentQuiz['choices']
                    .map<Widget>((choice) => QuizSelectItem(
                          text: choice,
                          isAnswered: isAnswered,
                          isCorrect: choice == correct,
                          isSelected: selectedChoice == choice,
                          showCorrect: isCorrectAnswerSelected,
                          onPressed: () => handleAnswer(choice),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

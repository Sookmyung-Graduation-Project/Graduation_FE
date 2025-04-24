import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../widgets/basic_lg_button.dart';
import '../../widgets/LessonCompleteCard.dart';
import '../../widgets/quiz_select_container.dart';
import '../../widgets/custom_progress_bar.dart';
import '../../data/quiz_data.dart';

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
          setState(() {
            progress = 1.0;
          });
          showLessonCompleteDialog(
            context,
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height,
          );
        } else {
          setState(() {
            currentQuestionIndex++;
            progress += 1.0 / quizData.length;
            isAnswered = false;
            selectedChoice = null;
            isCorrectAnswerSelected = false;
          });
        }
      });
    } else {
      HapticFeedback.heavyImpact();
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isAnswered = false;
          selectedChoice = null;
          isCorrectAnswerSelected = false;
        });
      });
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                children: [
                  Expanded(child: DinosaurProgressBar(progress: progress)),
                ],
              ),
            ),
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
            Image.asset(
              currentQuiz['image'],
              width: screenWidth * 0.5,
            ),
            Text.rich(
              (word != null &&
                      missingIndex != null &&
                      missingIndex >= 0 &&
                      missingIndex < word.length)
                  ? (isAnswered && selectedChoice == correct
                      ? TextSpan(
                          text: word,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2FAF8A),
                          ),
                        )
                      : isAnswered && selectedChoice != correct
                          ? TextSpan(
                              text: word.replaceRange(missingIndex,
                                  missingIndex + 1, selectedChoice!),
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
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

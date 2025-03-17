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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/phonics_background1.png'),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PhonicsButton(),
            SizedBox(height: 20),
            QuizButton(),
          ],
        ),
      ),
    );
  }
}

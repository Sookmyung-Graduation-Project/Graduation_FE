import 'package:flutter/material.dart';
import 'package:phonics/screens/quiz_menu.dart';
import 'package:phonics/screens/quiz_screen.dart';
import 'draggable_widget.dart';
import 'phonics_word_widget.dart';

class QuizButton extends StatelessWidget {
  const QuizButton({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildButton(
      imageAsset: 'assets/images/start_quiz_button_logo.png',
      color: const Color(0xffb7c0f9),
      onTap: () {
        Navigator.push(
          context,
          // MaterialPageRoute(builder: (context) => const QuizScreen()),

          MaterialPageRoute(builder: (context) => const QuizMenu()),
        );
      },
    );
  }
}

Widget _buildButton({
  required String imageAsset,
  required Color color,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 280,
      height: 195,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(30),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(3, 3),
          ),
        ],
      ),
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 2.0,
          left: 10,
        ),
        child: Image.asset(
          imageAsset,
          width: 252,
          height: 168.7,
          fit: BoxFit.contain,
        ),
      ),
    ),
  );
}

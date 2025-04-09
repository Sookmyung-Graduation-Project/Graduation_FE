import 'package:flutter/material.dart';
import 'package:phonics/screens/quiz_detailmenu.dart';
import 'package:phonics/screens/quiz_screen.dart';

class QuizDetailMenuContainer extends StatefulWidget {
  final VoidCallback onTap;
  final double width;
  final double height;

  const QuizDetailMenuContainer({
    super.key,
    required this.onTap,
    required this.width,
    required this.height,
  });

  @override
  _QuizDetailMenuContainer createState() => _QuizDetailMenuContainer();
}

class _QuizDetailMenuContainer extends State<QuizDetailMenuContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QuizScreen()),
        );
      },
      child: Container(
        width: widget.width * 0.92,
        height: widget.height * 0.08498253783,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 6.0,
              spreadRadius: 0.0,
              offset: const Offset(2, 4),
            )
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question 1',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class QuizSelectItem extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isAnswered;
  final bool isCorrect;
  final bool isSelected;
  final bool showCorrect;

  const QuizSelectItem({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isAnswered,
    required this.isCorrect,
    required this.isSelected,
    required this.showCorrect,
  });

  @override
  State<QuizSelectItem> createState() => _QuizSelectItemState();
}

class _QuizSelectItemState extends State<QuizSelectItem> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    Color textColor = const Color(0xff363535);

    if (widget.isAnswered) {
      if (widget.isCorrect && widget.showCorrect) {
        backgroundColor = const Color(0xff2FAF8A); // 정답
        textColor = Colors.white;
      } else if (widget.isSelected) {
        backgroundColor = Colors.red; // 오답
        textColor = Colors.white;
      }
    } else {
      // 아직 정답 안 눌렀을 때 눌림 효과
      if (isPressed) {
        backgroundColor = Colors.grey[300]!;
      }
    }

    return GestureDetector(
      onTapDown: (_) {
        if (!widget.isAnswered) {
          setState(() {
            isPressed = true;
          });
        }
      },
      onTapUp: (_) {
        if (!widget.isAnswered) {
          setState(() {
            isPressed = false;
          });
          widget.onPressed();
        }
      },
      onTapCancel: () {
        if (!widget.isAnswered) {
          setState(() {
            isPressed = false;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          widget.text,
          style: TextStyle(
            fontSize: 26,
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

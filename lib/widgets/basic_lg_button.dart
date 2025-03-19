import 'package:flutter/material.dart';
import 'package:phonics/screens/lesson_screen.dart';

class BasicLgButton extends StatelessWidget {
  const BasicLgButton({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildButton(
      color: const Color(0xffFAC632),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const LessonScreen(lessonNumber: 2), // 올바르게 수정
          ),
        );
      },
    );
  }

  /// 버튼을 생성하는 위젯
  Widget _buildButton({
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 331,
        height: 55,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffE9B729),
              spreadRadius: 2, // 그림자 확산 정도
              offset: Offset(2, 2), // 그림자 위치 (X, Y)
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_forward_rounded,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}

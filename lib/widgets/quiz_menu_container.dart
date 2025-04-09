import 'package:flutter/material.dart';
import 'package:phonics/screens/quiz_detailmenu.dart';
import 'package:phonics/screens/quiz_screen.dart';

class QuizMenuContainer extends StatefulWidget {
  final VoidCallback onTap;

  const QuizMenuContainer({super.key, required this.onTap});

  @override
  _QuizMenuContainer createState() => _QuizMenuContainer();
}

class _QuizMenuContainer extends State<QuizMenuContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const QuizDetailmenu()),
        );
      },
      child: Container(
        width: 175,
        height: 165,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 6.0,
              spreadRadius: 0.0,
              offset: const Offset(2, 4),
            )
          ],
        ),
        child: Stack(
          alignment: AlignmentDirectional.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: -15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/abc_letter_logo.png',
                    width: 150,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Level 1 ABC',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '6 Questions',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffA5A5A5)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

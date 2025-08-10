import 'package:flutter/material.dart';
import 'package:phonics/screens/study_tab/quiz_detailmenu.dart';

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
        padding: const EdgeInsets.all(16),
        width: double.infinity,
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
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/abc_letter_logo.png',
                      width: 150,
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
              ],
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded,
                size: 26, color: Color(0xffA5A5A5)),
          ],
        ),
      ),
    );
  }
}

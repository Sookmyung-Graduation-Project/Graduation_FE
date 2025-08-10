import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'lesson_screen.dart'; // LessonScreen import

class PhonicsScreen extends StatelessWidget {
  const PhonicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: const AssetImage('assets/images/phonics_background2.png'),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: List.generate(
                    25,
                    (index) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                LessonScreen(lessonNumber: index + 1),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          "Phonics Lesson ${index + 1}",
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: screenWidth * 0.055,
              top: screenWidth * 0.055,
              child: SafeArea(
                child: Container(
                  width: screenWidth * 0.1,
                  height: screenWidth * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 2),
                          color: Colors.black.withOpacity(0.3),
                        )
                      ]),
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 25,
                    ),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DinosaurProgressBar extends StatefulWidget {
  const DinosaurProgressBar({super.key});

  @override
  _DinosaurProgressBarState createState() => _DinosaurProgressBarState();
}

class _DinosaurProgressBarState extends State<DinosaurProgressBar> {
  double progress = 0.0; // 0.0 ~ 1.0 (0% ~ 100%)

  void _increaseProgress() {
    setState(() {
      progress += 0.2;
      if (progress > 1.0) progress = 1.0; // 최대 100%
    });
  }

  @override
  Widget build(BuildContext context) {
    double barWidth = 320; // 프로그레스 바의 너비

    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE5), // 배경색 (연한 크림색)
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                // 프로그레스 바 배경
                Container(
                  width: barWidth,
                  height: 33,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade300, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                ),

                // 진행 상태 1 (yellow bar stroke 부분)
                Positioned(
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(5), // 10dp 패딩 추가
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: (barWidth * progress - 10)
                          .clamp(0, barWidth - 10), // 최소 0 보장
                      height: 23,
                      decoration: BoxDecoration(
                        color: const Color(0xffffdf83), //FFDF83
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                // 진행 상태 2 (yellow bar body 부분)
                Positioned(
                  left: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8), // 10dp 패딩 추가
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: (barWidth * progress - 15)
                          .clamp(0, barWidth - 15), // 최소 0 보장
                      height: 18,
                      decoration: BoxDecoration(
                        color: const Color(0xffFAC632), //FFDF83
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                // 진행 상태 3 (yellow bar 명암 - 밝은 부분)
                Positioned(
                  left: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 9.0, left: 12, right: 20),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      width: (barWidth * progress - 20)
                          .clamp(0, barWidth - 20), // 최소 0 보장
                      height: 8,
                      decoration: BoxDecoration(
                        color: const Color(0x88ffe18d), //FFDF83
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                // 공룡 아이콘 (진행도에 따라 이동)
                Positioned(
                  left: (barWidth - 24) * progress - 30,
                  top: -40,
                  child: SizedBox(
                    child: Image.asset(
                      'assets/images/dinosaur.png',
                      width: 64,
                      height: 45,
                    ),
                  ),
                ),
              ],
            ),

            // 버튼: 진행도 증가
            ElevatedButton(
              onPressed: _increaseProgress,
              child: const Text("클릭"),
            ),
          ],
        ),
      ),
    );
  }
}

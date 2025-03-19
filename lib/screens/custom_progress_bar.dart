import 'package:flutter/material.dart';

class DinosaurProgressBar extends StatelessWidget {
  final double progress; // 진행 상태 값 추가

  const DinosaurProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    double barWidth = 320; // 프로그레스 바의 너비

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.center, // 전체 Stack을 가운데 정렬
          child: Stack(
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

              // 진행 상태 1 (노란색 바)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: (barWidth * progress - 10).clamp(0, barWidth - 10),
                    height: 23,
                    decoration: BoxDecoration(
                      color: const Color(0xffffdf83),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              // 진행 상태 2 (노란색 바 - 밝은 부분)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: (barWidth * progress - 15).clamp(0, barWidth - 15),
                    height: 18,
                    decoration: BoxDecoration(
                      color: const Color(0xffFAC632),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              // 진행 상태 3 (노란색 바 - 명암)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 9.0, left: 10, right: 10),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: (barWidth * progress - 23).clamp(0, barWidth - 23),
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0x88ffe18d),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              // 공룡 아이콘 (진행도에 따라 중앙 이동)
              AnimatedPositioned(
                duration: const Duration(milliseconds: 500), // 애니메이션 추가
                curve: Curves.easeInOut, // 부드러운 이동
                left: (barWidth * progress) - 58, // 중앙 정렬 적용
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
        ),
      ],
    );
  }
}

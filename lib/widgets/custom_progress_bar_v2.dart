// 공룡 아이콘 없는 프로그래스 바바
import 'package:flutter/material.dart';

class DinosaurProgressBar extends StatelessWidget {
  final double progress; // 진행 상태 값 추가

  const DinosaurProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double barWidth = screenWidth * 0.88888888888; // 프로그레스 바의 너비

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Align(
          alignment: Alignment.center,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // 프로그레스 바 배경
              Container(
                width: barWidth,
                height: screenHeight * 0.03841676367,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 3,
                  ),
                  boxShadow: [BoxShadow(color: Colors.black)],
                ),
              ),

              // 진행 상태 1
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: (barWidth * progress - 10).clamp(
                      0,
                      barWidth - 10,
                    ),
                    height: 23,
                    decoration: BoxDecoration(
                      color: const Color(0xffffdf83),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              // 진행 상태 2
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: (barWidth * progress - 15).clamp(
                      0,
                      barWidth - 15,
                    ),
                    height: 18,
                    decoration: BoxDecoration(
                      color: const Color(0xffFAC632),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),

              // 진행 상태 3
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
            ],
          ),
        ),
      ],
    );
  }
}

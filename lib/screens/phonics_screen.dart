import 'dart:ui';

import 'package:flutter/material.dart';

class PhonicsScreen extends StatelessWidget {
  const PhonicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // 배경을 포함하는 리스트뷰
          ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/phonics_background2.png'),
                    repeat: ImageRepeat.repeatY,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: List.generate(
                          50,
                          (index) => Container(
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
              ),
            ],
          ),
          // 상단에 뒤로가기 아이콘 배치
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.topLeft,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50), // 둥근 버튼 효과
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), // 흐림 효과
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.6), // 반투명 효과
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Color(0xff7C7B73),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

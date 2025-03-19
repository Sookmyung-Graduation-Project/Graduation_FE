import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:phonics/widgets/basic_lg_button.dart';
import 'custom_progress_bar.dart'; // 공룡 ProgressBar Import

class LessonScreen extends StatelessWidget {
  final int lessonNumber;

  const LessonScreen({super.key, required this.lessonNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFEB),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); //뒤로가기
          },
          color: const Color(0xff7C7B73),
          icon: const Icon(Icons.arrow_back),
          iconSize: 30,
        ),
      ),
      backgroundColor: const Color(0xffFFFFEB),
      body: Column(
        children: [
          // 뒤로 가기 버튼 + ProgressBar 한 줄에 배치
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Row(
              children: [
                const SizedBox(width: 10), // 버튼과 ProgressBar 사이 여백 추가
                Expanded(
                    child:
                        _buildProgressBar()), // ProgressBar가 가능한 공간을 차지하도록 설정
              ],
            ),
          ),

          // 레슨 콘텐츠 (예: 텍스트 등 추가 가능)
          Expanded(
            child: Center(
              child: Text(
                'Content for Lesson $lessonNumber',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // 하단 버튼을 배치
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: _buildBasicButton(),
          ),
        ],
      ),
    );
  }

  /// ProgressBar 배치
  Widget _buildProgressBar() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: DinosaurProgressBar(), // ProgressBar 추가
    );
  }

  /// 다음으로 넘어가는 버튼 (하단)
  Widget _buildBasicButton() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: BasicLgButton(),
    );
  }
}

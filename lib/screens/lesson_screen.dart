import 'package:flutter/material.dart';
import 'custom_progress_bar.dart'; // 공룡 ProgressBar Import
import '../widgets/basic_lg_button.dart';

class LessonScreen extends StatefulWidget {
  final int lessonNumber;

  const LessonScreen({super.key, required this.lessonNumber});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  double progress = 0.0; // 진행도 상태

  /// 진행도를 증가시키는 함수
  void _updateProgress() {
    setState(() {
      progress += 0.2;
      if (progress > 1.0) progress = 1.0; // 최대 100%
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFEB),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: const Color(0xff7C7B73),
          icon: const Icon(Icons.arrow_back),
          iconSize: 30,
        ),
      ),
      backgroundColor: const Color(0xffFFFFEB),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Expanded(
                    child: DinosaurProgressBar(progress: progress)), // 상태 반영
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Lesson ${widget.lessonNumber} Content', // 레슨 번호 반영
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: BasicLgButton(onPressed: _updateProgress), // 버튼이 눌리면 진행도 증가
          ),
        ],
      ),
    );
  }
}

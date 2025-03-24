import 'package:flutter/material.dart';
import 'custom_progress_bar.dart'; // 공룡 ProgressBar import
import '../widgets/basic_lg_button.dart'; // 진행 버튼 import
import '../widgets/draggable_widget.dart'; // draggable 위젯 import
import '../widgets/phonics_word_widget.dart'; // scale transition 되는 <이미지, text> 위젯 import
import '../data/word_data.dart'; // 단어 데이터 파일 import

class LessonScreen extends StatefulWidget {
  final int lessonNumber;

  const LessonScreen({super.key, required this.lessonNumber});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  double progress = 0.0; // 진행도 상태
  Offset draggablePosition = const Offset(100, 100); // 기본 드래그 위치
  bool _isDraggableVisible = true;
  bool _isButtonLgVisible = false;
  bool _isPhonicsWordVisible = false;
  int _currentWordIndex = 0; // 🔹 현재 표시할 단어 인덱스 추가

  /// progress bar 진행도 증가
  void _updateProgress() {
    setState(() {
      progress += 0.07;
      if (progress > 1.0) progress = 1.0;
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isButtonLgVisible = false;
          _isPhonicsWordVisible = true;
        });
      }
    });
  }

  /// 드래그 종료 시 위치 업데이트
  void _onDragEnd(Offset position) {
    setState(() {
      draggablePosition = position;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isDraggableVisible = false;
          _isButtonLgVisible = true;
          _isPhonicsWordVisible = false;
        });
      }
    });
  }

  /// scale transition 후 다음 단어로 변경
  void _afterTransition() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isPhonicsWordVisible = false;
        _isButtonLgVisible = true;
        _currentWordIndex =
            (_currentWordIndex + 1) % phonicsWords.length; // 다음 단어로 변경
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final word = phonicsWords[_currentWordIndex]; //현재 단어 가져오기

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFEB),
        title: Text("Phonics level ${widget.lessonNumber} Content"),
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
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    Expanded(child: DinosaurProgressBar(progress: progress)),
                  ],
                ),
              ),
              if (_isPhonicsWordVisible)
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: PhonicsWordWidget(
                    imagePath: word["imagePath"]!,
                    firstLetter: word["firstLetter"]!,
                    restOfWord: word["restOfWord"]!,
                    onFinished: _afterTransition, // 🔹 단어 변경 콜백
                  ),
                ),
              const Expanded(child: Center()),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: _isButtonLgVisible
                    ? BasicLgButton(onPressed: _updateProgress)
                    : const SizedBox(),
              ),
            ],
          ),
          if (_isDraggableVisible) DraggableContainer(onDragEnd: _onDragEnd),
        ],
      ),
    );
  }
}

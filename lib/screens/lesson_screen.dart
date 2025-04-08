import 'package:flutter/material.dart';
import 'custom_progress_bar.dart';
import '../widgets/basic_lg_button.dart';
import '../widgets/draggable_widget.dart';
import '../widgets/phonics_word_widget.dart';
import '../data/word_data.dart';
import '../widgets/LessonCompleteCard.dart';

class LessonScreen extends StatefulWidget {
  final int lessonNumber;

  const LessonScreen({super.key, required this.lessonNumber});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  double progress = 0.0;
  Offset draggablePosition = const Offset(100, 100);
  bool _isDraggableVisible = true;
  bool _isButtonLgVisible = false;
  bool _isPhonicsWordVisible = false;
  int _currentGroupIndex = 0;
  int _currentWordInGroupIndex = 0;

  void _updateProgress() {
    setState(() {
      progress += 0.1;
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

  void _afterTransition() {
    Future.delayed(const Duration(milliseconds: 800), () {
      setState(() {
        _isPhonicsWordVisible = false;

        if (_currentWordInGroupIndex == 0) {
          //A -> apple[0], airplane[1]
          _currentWordInGroupIndex = 1;
          _isButtonLgVisible = true;
        } else {
          _currentWordInGroupIndex = 0;
          _currentGroupIndex += 1;

          // 다음 그룹 시작: 드래그 다시 등장
          _isDraggableVisible = true;
          _isButtonLgVisible = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    if (_currentGroupIndex >= 4) {
      return Scaffold(
        backgroundColor: const Color(0xffFFFFEB),
        body: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.3), // 반투명 블랙 배경
            ),
            Center(
              child: LessonCompleteCard(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
              ),
            ),
          ],
        ),
      );
    }

    final currentGroup = groupedPhonicsWords[_currentGroupIndex];
    final currentWord = currentGroup["words"][_currentWordInGroupIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFEB),
        title: Text("Phonics level ${widget.lessonNumber} Content"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context); //뒤로 가기
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
                    Expanded(child: DinosaurProgressBar(progress: progress)),
                  ],
                ),
              ),
              if (_isPhonicsWordVisible)
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: PhonicsWordWidget(
                    imagePath: currentWord["imagePath"] ?? '',
                    firstLetter: currentWord["firstLetter"] ?? '',
                    restOfWord: currentWord["restOfWord"] ?? '',
                    onFinished: _afterTransition,
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
          if (_isDraggableVisible)
            DraggableContainer(
              text:
                  '${currentWord["firstLetter"]}${currentWord["firstSmallLetter"]}',
              onDragEnd: _onDragEnd,
              screenWidth: screenWidth,
              screenHeight: screenHeight,
            ),
        ],
      ),
    );
  }
}

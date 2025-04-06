import 'package:flutter/material.dart';
import 'custom_progress_bar.dart';
import '../widgets/basic_lg_button.dart';
import '../widgets/draggable_widget.dart';
import '../widgets/phonics_word_widget.dart';
import '../data/word_data.dart';

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
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _isPhonicsWordVisible = false;
        _isButtonLgVisible = true;

        if (_currentWordInGroupIndex == 0) {
          _currentWordInGroupIndex = 1;
        } else {
          _currentWordInGroupIndex = 0;
          _currentGroupIndex += 1;
          _isDraggableVisible = true;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_currentGroupIndex >= groupedPhonicsWords.length) {
      return const Scaffold(
        backgroundColor: Color(0xffFFFFEB),
        body: Center(
          child: Text(
            "Great job! You've completed the lesson!",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
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
            ),
        ],
      ),
    );
  }
}

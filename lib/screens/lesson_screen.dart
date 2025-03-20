import 'package:flutter/material.dart';
import 'custom_progress_bar.dart'; // 공룡 ProgressBar Import
import '../widgets/basic_lg_button.dart';
import '../widgets/draggable_widget.dart'; // 새로운 위젯 import

class LessonScreen extends StatefulWidget {
  final int lessonNumber;

  const LessonScreen({super.key, required this.lessonNumber});

  @override
  _LessonScreenState createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  double progress = 0.0; // 진행도 상태
  Offset draggablePosition = const Offset(100, 100); // 기본 드래그 위치
  bool _isDraggableVisible = true; // 드래그 가능한 위젯의 가시성 상태
  bool _isButtonLgVisible = false;

  /// 진행도를 증가시키는 함수
  void _updateProgress() {
    setState(() {
      progress += 0.07; // 1단계당 15, step 0.066667 반올림
      if (progress > 1.0) progress = 1.0; // 최대 100%
    });

    // 500ms(0.5초) 후에 버튼 숨기기
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isButtonLgVisible = false;
        });
      }
    });
  }

  /// 드래그 종료 시 위치 업데이트
  void _onDragEnd(Offset position) {
    setState(() {
      draggablePosition = position;
    });

    /// 800ms 후에 DraggableContainer 숨기고 버튼 표시
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isDraggableVisible = false;
          _isButtonLgVisible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFEB),
        title: Text(
          "Phonics level ${widget.lessonNumber} Content",
        ),
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
                    Expanded(
                        child:
                            DinosaurProgressBar(progress: progress)), // 상태 반영
                  ],
                ),
              ),
              const Expanded(
                child: Center(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: _isButtonLgVisible
                    ? BasicLgButton(
                        onPressed: _updateProgress) // 버튼이 눌리면 진행도 증가
                    : const SizedBox(),
              ),
            ],
          ),
          // 드래그 가능한 컨테이너 추가
          if (_isDraggableVisible) DraggableContainer(onDragEnd: _onDragEnd),
        ],
      ),
    );
  }
}

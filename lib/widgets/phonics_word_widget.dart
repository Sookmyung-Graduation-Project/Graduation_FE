import 'package:flutter/material.dart';

class PhonicsWordWidget extends StatefulWidget {
  final String imagePath;
  final String firstLetter;
  final String restOfWord;

  const PhonicsWordWidget({
    super.key,
    required this.imagePath,
    required this.firstLetter,
    required this.restOfWord,
  });

  @override
  State<PhonicsWordWidget> createState() => _PhonicsWordWidgetState();
}

class _PhonicsWordWidgetState extends State<PhonicsWordWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _repeatCount = 0;
  final int _maxRepeats = 4; //scale transition 반복 횟수 지정

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _animation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _repeatCount++;
        if (_repeatCount < _maxRepeats) {
          _controller.forward(from: 0); // 다시 시작
        }
      }
    });

    _controller.forward(); // 첫 시작
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: Column(
        children: [
          Image.asset(
            widget.imagePath,
            width: 200,
            height: 200,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.firstLetter,
                style: const TextStyle(
                  fontSize: 64,
                  color: Color(0xffd84040),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.restOfWord,
                style: const TextStyle(fontSize: 64, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

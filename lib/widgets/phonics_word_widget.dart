import 'package:flutter/material.dart';

class PhonicsWordWidget extends StatefulWidget {
  final String imagePath;
  final String firstLetter;
  final String restOfWord;
  final int repeatCount;
  final VoidCallback? onFinished;

  const PhonicsWordWidget({
    super.key,
    required this.imagePath,
    required this.firstLetter,
    required this.restOfWord,
    this.repeatCount = 3,
    this.onFinished,
  });

  @override
  State<PhonicsWordWidget> createState() => _PhonicsWordWidgetState();
}

class _PhonicsWordWidgetState extends State<PhonicsWordWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  int _currentRepeat = 0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
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
        _currentRepeat++;
        if (_currentRepeat < widget.repeatCount) {
          _controller.forward(from: 0);
        } else {
          widget.onFinished?.call();
        }
      }
    });

    _controller.forward();
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

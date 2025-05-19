import 'dart:async';
import '../../widgets/constants.dart';
import '../../widgets/custom_progress_bar_v2.dart';
import '../../widgets/speech_bubble.dart';
import '../../widgets/go_button.dart';
import 'package:flutter/material.dart';

class GeneratingScreen extends StatefulWidget {
  const GeneratingScreen({super.key});

  @override
  State<GeneratingScreen> createState() => _GeneratingScreenState();
}

class _GeneratingScreenState extends State<GeneratingScreen> {
  double _progress = 0.0;
  String _message = '책을 생성하고 있어요';

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _progress += 0.4;
        if (_progress >= 1.5) {
          _progress = 1.0;
          _message = '책이 완성되었어요!';
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 배경 이미지
          Positioned.fill(
            child: Image.asset(
              'assets/images/backgroud_mask.png',
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
          ),

          // 그라데이션 오버레이
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, AppColors.backgroundColor],
                  stops: [0.1, 0.5],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomPaint(
                    painter: SpeechBubblePainter(),
                    child: Container(
                      width: 220,
                      height: 50,
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      child: Center(
                        child: Text(
                          _message,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/baby_dino.png',
                        width: 350,
                        height: 350,
                      ),
                      if (_message == '책이 완성되었어요!')
                        Positioned(
                          top: 10,
                          left: -50,
                          child: Image.asset(
                            'assets/images/light.png',
                            width: 180,
                            height: 180,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: DinosaurProgressBar(progress: _progress),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

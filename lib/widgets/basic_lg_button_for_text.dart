import 'package:flutter/material.dart';

class BasicLgButtonForText extends StatefulWidget {
  final VoidCallback onPressed;
  final String title;

  const BasicLgButtonForText(
      {super.key, required this.onPressed, required this.title});

  @override
  _BasicLgButtonForTextState createState() => _BasicLgButtonForTextState();
}

class _BasicLgButtonForTextState extends State<BasicLgButtonForText> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        widget.onPressed(); // 버튼 클릭 시 진행도 증가
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          alignment: Alignment.center,
          transform: _isPressed
              ? Matrix4.translationValues(0, 4, 0)
              : Matrix4.identity(),
          width: double.infinity,
          height: screenHeight * 0.06402793946,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 100),
          decoration: BoxDecoration(
            color: const Color(0xffFAC632),
            borderRadius: BorderRadius.circular(22),
            boxShadow: _isPressed
                ? []
                : [
                    const BoxShadow(
                      color: Color(0xffE9B729),
                      spreadRadius: 2,
                      offset: Offset(2, 2),
                    ),
                  ],
          ),
          child: Text(
            widget.title,
            style: const TextStyle(
              fontFamily: 'GyeonggiTitleBold',
              color: Colors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BasicLgButton extends StatefulWidget {
  final VoidCallback onPressed; // 버튼이 눌릴 때 실행될 콜백

  const BasicLgButton({super.key, required this.onPressed});

  @override
  _BasicLgButtonState createState() => _BasicLgButtonState();
}

class _BasicLgButtonState extends State<BasicLgButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
          transform: _isPressed
              ? Matrix4.translationValues(0, 4, 0)
              : Matrix4.identity(),
          width: screenWidth * 0.91944444444,
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
          child: const Icon(
            Icons.arrow_forward_rounded,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}

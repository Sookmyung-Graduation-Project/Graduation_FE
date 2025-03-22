import 'dart:math';
import 'package:flutter/material.dart';

class PhonicsWordWidget extends StatefulWidget {
  const PhonicsWordWidget({super.key});

  @override
  _PhonicsWordWidgetState createState() => _PhonicsWordWidgetState();
}

class _PhonicsWordWidgetState extends State<PhonicsWordWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Column 전체를 중앙 정렬
        child: Column(
          children: [
            Image.asset(
              'assets/images/1.png',
              width: 200,
              height: 200,
            ),
            const Row(
              mainAxisSize: MainAxisSize.min, // 내용만큼만 Column이 차지하게
              children: [
                Text(
                  'A',
                  style: TextStyle(
                      fontSize: 64,
                      color: Color(0xffd84040),
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'pple',
                  style: TextStyle(fontSize: 64, color: Colors.black),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

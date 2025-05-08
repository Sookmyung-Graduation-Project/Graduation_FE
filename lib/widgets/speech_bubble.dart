import 'constants.dart';
import 'package:flutter/material.dart';

class SpeechBubblePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = AppColors.kPrimaryBorderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = AppColors.kPrimaryBorderWidth;

    const borderRadius = 18.0;
    const triangleHeight = 12.0;
    const triangleWidth = 20.0;
    final triangleCenter = size.width * 0.3;

    final path = Path();

    // 시작점: 좌상단
    path.moveTo(borderRadius, 0);

    // 상단 라인
    path.lineTo(size.width - borderRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, borderRadius);

    // 우측 라인
    path.lineTo(size.width, size.height - triangleHeight - borderRadius);
    path.quadraticBezierTo(
      size.width,
      size.height - triangleHeight,
      size.width - borderRadius,
      size.height - triangleHeight,
    );

    // 하단 라인
    path.lineTo(
        triangleCenter + triangleWidth / 2, size.height - triangleHeight);
    path.lineTo(triangleCenter, size.height);
    path.lineTo(
        triangleCenter - triangleWidth / 2, size.height - triangleHeight);

    path.lineTo(borderRadius, size.height - triangleHeight);
    path.quadraticBezierTo(
      0,
      size.height - triangleHeight,
      0,
      size.height - triangleHeight - borderRadius,
    );

    // 좌측 라인
    path.lineTo(0, borderRadius);
    path.quadraticBezierTo(0, 0, borderRadius, 0);

    path.close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

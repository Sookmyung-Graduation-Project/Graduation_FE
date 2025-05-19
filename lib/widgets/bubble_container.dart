import 'package:flutter/material.dart';

class BubbleContainer extends StatelessWidget {
  final String text;
  final double width;
  final double height;

  const BubbleContainer({
    super.key,
    required this.text,
    this.width = 230,
    this.height = 85,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(5),
        ),
        border: Border.all(
          color: Color(0xFFEBC755),
          width: 2,
        ), // 스트로크 색상 EBC755
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: -10,
            left: 30,
            child: CustomPaint(size: Size(20, 10), painter: TrianglePainter()),
          ),
          Text(text, style: TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill
          ..strokeWidth = 2
          ..color = Color(0xFFEBC755)
          ..style = PaintingStyle.stroke;

    Path path =
        Path()
          ..moveTo(0, 0)
          ..lineTo(size.width, 0)
          ..lineTo(size.width / 2, size.height)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

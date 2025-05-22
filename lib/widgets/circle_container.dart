import 'constants.dart';
import 'package:flutter/material.dart';

class CircleContainer extends StatelessWidget {
  final String imagePath;
  final String? label;
  final Color backgroundColor;

  const CircleContainer({
    super.key,
    required this.imagePath,
    this.backgroundColor = Colors.white, //기본 배경
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.kPrimaryBorderColor,
          width: AppColors.kPrimaryBorderWidth,
        ),
      ),
      child: ClipOval(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            width: 100, height: 100,
            // fit: BoxFit.contain,
          ),
          if (label != null) ...[
            Text(
              label!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
            )
          ]
        ],
      )),
    );
  }
}

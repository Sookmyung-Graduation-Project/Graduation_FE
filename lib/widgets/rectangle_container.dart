import 'constants.dart';
import 'package:flutter/material.dart';

class RectangleContainer extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final bool isFixedWidth;

  const RectangleContainer({
    super.key,
    required this.label,
    this.isFixedWidth = true,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    // 글자 길이에 따라 너비 조정
    if (!isFixedWidth) {
      return Material(
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: AppColors.kPrimaryBorderColor,
            width: AppColors.kPrimaryBorderWidth,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ),
      );
    }

    return Container(
      width: 140,
      height: 50,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.kPrimaryBorderColor,
          width: AppColors.kPrimaryBorderWidth,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}

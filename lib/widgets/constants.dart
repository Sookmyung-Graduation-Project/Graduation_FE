import 'package:flutter/material.dart';

class AppColors {
  // 테두리, 기본 버튼 색상
  static const Color kPrimaryBorderColor = Color(0xFFEBC755);
  static const Color backgroundColor = Color(0xFFFEFFED);

  static const kPrimaryBorderWidth = 2.0;

  /// 선택된 상태 색상
  static final Color selected =
      HSLColor.fromColor(kPrimaryBorderColor).withLightness(0.8).toColor();
}

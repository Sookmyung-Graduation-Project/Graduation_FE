import 'option_selection_screen.dart';
import 'package:flutter/material.dart';

class LessonSelectionScreen extends StatelessWidget {
  final void Function(String) onLessonSelected;
  final String selectedLesson;
  final String selectedGender;
  final String selectedAgeGroup;

  final VoidCallback onBackToGenderAge;
  final VoidCallback onBackToLesson;

  const LessonSelectionScreen({
    super.key,
    required this.onLessonSelected,
    required this.selectedLesson,
    required this.selectedGender,
    required this.selectedAgeGroup,
    required this.onBackToLesson,
    required this.onBackToGenderAge,
  });

  @override
  Widget build(BuildContext context) {
    return OptionSelectionScreen(
      title: '교훈',
      options: [
        '우정의 소중함',
        '용기와 자신감',
        '용서와 이해',
        '인내와 겸손',
        '열린 마음과 배려',
        '창의성과 상상력',
        '책임감과 신뢰',
        '성실한 노력의 가치',
        '타인에 대한 이해',
        '공평함과 정의',
      ],
      selectedOption: selectedLesson,
      onOptionSelected: onLessonSelected,
      onBackToLesson: onBackToLesson,
      onBackToGenderAge: onBackToGenderAge,
      selectedLesson: selectedLesson,
      selectedGender: selectedGender,
      selectedAgeGroup: selectedAgeGroup,
    );
  }
}

import 'option_selection_screen.dart';
import 'package:flutter/material.dart';

class CharacterSelectionScreen extends StatelessWidget {
  final void Function(String) onCharacterSelected;
  final String selectedCharacter;
  final String selectedLesson;
  final String selectedGender;
  final String selectedAgeGroup;
  final VoidCallback onBackToLesson;

  /// 성별/연령대 선택 화면으로 돌아갈 때 호출
  final VoidCallback onBackToGenderAge;

  const CharacterSelectionScreen({
    super.key,
    required this.onCharacterSelected,
    required this.selectedCharacter,
    required this.selectedLesson,
    required this.selectedGender,
    required this.selectedAgeGroup,
    required this.onBackToLesson,
    required this.onBackToGenderAge,
  });

  @override
  Widget build(BuildContext context) {
    return OptionSelectionScreen(
      title: '동물',
      options: const [
        '곰',
        '공룡',
        '사자',
        '토끼',
        '고양이',
        '거북',
        '사슴',
        '돼지',
        '말',
        '코끼리',
        '원숭이',
        '강아지',
      ],
      selectedOption: selectedCharacter,
      onOptionSelected: onCharacterSelected,

      // 뒤로 가기 콜백 2개
      onBackToLesson: onBackToLesson,
      onBackToGenderAge: onBackToGenderAge,

      // 이전 선택된 교훈, 성별/연령대
      selectedLesson: selectedLesson,
      selectedGender: selectedGender,
      selectedAgeGroup: selectedAgeGroup,
    );
  }
}

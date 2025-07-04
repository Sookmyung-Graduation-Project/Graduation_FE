import 'generate_screen.dart';
import '../../widgets/custom_dropdown.dart';
import '../../widgets/show_selected.dart';
import '../../widgets/create_button.dart';
import 'package:flutter/material.dart';
import '../mypage_tab/mypage_to_voicesetting.dart';

class VoiceSelectionScreen extends StatelessWidget {
  final String selectedVoice;
  final ValueChanged<String> onVoiceSelected;
  final VoidCallback onBackToCharacterSelection;
  final VoidCallback onBackToLesson;
  final VoidCallback onBackToGenderAge;
  final String selectedCharacter;
  final String selectedLesson;
  final String selectedGender;
  final String selectedAgeGroup;

  const VoiceSelectionScreen({
    super.key,
    required this.selectedVoice,
    required this.onVoiceSelected,
    required this.onBackToCharacterSelection,
    required this.onBackToLesson,
    required this.onBackToGenderAge,
    required this.selectedCharacter,
    required this.selectedLesson,
    required this.selectedGender,
    required this.selectedAgeGroup,
  });

  void _goToVoiceSettingScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MypageToVoicesetting(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(
          '목소리 선택',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 10),
        CustomDropdown(
          items: ['보호자1(기본)', '보호자2', '보호자3'],
          selectedItem: selectedVoice.isNotEmpty ? selectedVoice : null,
          onChanged: onVoiceSelected,
        ),
        TextButton(
          onPressed: () => _goToVoiceSettingScreen(context),
          child: Text(
            '새로운 목소리 모델 추가하기',
            style: TextStyle(
              color: Color(0xFF49C5D3),
              fontSize: 14,
              decoration: TextDecoration.underline,
              decorationColor: Color(0xFF49C5D3),
              decorationThickness: 1,
              height: 1.2,
            ),
          ),
        ),
        ShowSelected(
          label: '주인공',
          value: selectedCharacter,
          onPressed: onBackToCharacterSelection,
        ),
        SizedBox(height: 20),
        if (selectedLesson.isNotEmpty)
          ShowSelected(
            label: '교훈',
            value: selectedLesson,
            onPressed: onBackToLesson,
          ),
        SizedBox(height: 20),
        ShowSelected(
          label: '성별/연령대',
          value: '$selectedGender / $selectedAgeGroup',
          onPressed: onBackToGenderAge,
        ),
        SizedBox(height: 40),
        CreateButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const GeneratingScreen(),
              ),
            );
          },
        ),
      ],
    );
  }
}

import 'package:phonics/core/utils/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<void> _createBookAndNavigate(BuildContext context) async {
    if (selectedGender.isEmpty ||
        selectedAgeGroup.isEmpty ||
        selectedLesson.isEmpty ||
        selectedCharacter.isEmpty ||
        selectedVoice.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('모든 항목을 선택해 주세요.')),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('access_token');

    BuildContext? dialogContext;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dctx) {
        dialogContext = dctx;
        return const Center(child: CircularProgressIndicator());
      },
    );

    try {
      final res = await ApiService.createBook(
        jwt: (jwt != null && jwt.isNotEmpty) ? jwt : null,
        gender: selectedGender,
        ageGroup: selectedAgeGroup,
        lesson: selectedLesson,
        animal: selectedCharacter,
        voiceOption: selectedVoice,
      );

      if (dialogContext != null) {
        Navigator.of(dialogContext!, rootNavigator: true).pop();
        dialogContext = null;
      }

      if (!context.mounted) return;

      if (res != null && res['success'] == true) {
        final bookId = res['book_id'] as String?;
        debugPrint('📘 생성된 book_id: $bookId');

        if (bookId != null && bookId.isNotEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!context.mounted) return;
            // bookId를 GeneratingScreen으로 넘김
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => GeneratingScreen(bookId: bookId),
              ),
            );
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('book_id를 받지 못했어요. 다시 시도해 주세요.')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(res?['message'] ?? '동화 생성 실패')),
        );
      }
    } catch (e) {
      if (dialogContext != null) {
        Navigator.of(dialogContext!, rootNavigator: true).pop();
        dialogContext = null;
      }
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('오류: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text('목소리 선택', style: TextStyle(fontSize: 18)),
        const SizedBox(height: 10),
        CustomDropdown(
          items: const ['보호자1(기본)', '보호자2', '보호자3'],
          selectedItem: selectedVoice.isNotEmpty ? selectedVoice : null,
          onChanged: onVoiceSelected,
        ),
        TextButton(
          onPressed: () => _goToVoiceSettingScreen(context),
          child: const Text(
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
            onPressed: onBackToCharacterSelection),
        const SizedBox(height: 20),
        if (selectedLesson.isNotEmpty)
          ShowSelected(
              label: '교훈', value: selectedLesson, onPressed: onBackToLesson),
        const SizedBox(height: 20),
        ShowSelected(
            label: '성별/연령대',
            value: '$selectedGender / $selectedAgeGroup',
            onPressed: onBackToGenderAge),
        const SizedBox(height: 40),
        CreateButton(
          onPressed: () => _createBookAndNavigate(context),
        ),
      ],
    );
  }
}

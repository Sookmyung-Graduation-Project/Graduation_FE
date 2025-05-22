import '../../widgets/show_selected.dart';
import 'package:flutter/material.dart';
import '../../widgets/rectangle_container.dart';

class OptionSelectionScreen extends StatelessWidget {
  final String title;
  final List<String> options;
  final String selectedOption;
  final void Function(String) onOptionSelected;

  final VoidCallback? onBackToLesson; // 교훈 화면으로
  final VoidCallback onBackToGenderAge; // 성별/연령대 화면으로

  final String? selectedLesson;
  final String selectedGender;
  final String selectedAgeGroup;

  const OptionSelectionScreen({
    super.key,
    required this.title,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
    this.onBackToLesson,
    required this.onBackToGenderAge,
    this.selectedLesson,
    required this.selectedGender,
    required this.selectedAgeGroup,
  });

  @override
  Widget build(BuildContext context) {
    final selectedColor =
        HSLColor.fromColor(Color(0xFFEBC755)).withLightness(0.8).toColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text(title, style: TextStyle(fontSize: 18)),
        SizedBox(height: 10),

        // 옵션들
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: options.map((opt) {
            return GestureDetector(
              onTap: () => onOptionSelected(opt),
              child: RectangleContainer(
                label: opt,
                isFixedWidth: false,
                backgroundColor:
                    opt == selectedOption ? selectedColor : Colors.white,
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 40),

        // 선택했을 때만 보여줌
        if (selectedLesson != null && selectedLesson!.isNotEmpty) ...[
          ShowSelected(
            label: '교훈',
            value: selectedLesson!,
            onPressed: onBackToLesson!,
          ),
          SizedBox(height: 20),
        ],
        SizedBox(height: 20),
        ShowSelected(
          label: '성별/연령대',
          value: '$selectedGender / $selectedAgeGroup',
          onPressed: onBackToGenderAge,
        ),
      ],
    );
  }
}

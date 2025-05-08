import '../../widgets/constants.dart';
import 'package:flutter/material.dart';
import '../../widgets/rectangle_container.dart';
import '../../widgets/circle_container.dart';

class GenderAgeSelectionScreen extends StatefulWidget {
  final Function(String) onGenderSelected;
  final Function(String) onAgeGroupSelected;
  final String selectedGender;
  final String selectedAgeGroup;

  const GenderAgeSelectionScreen({
    super.key,
    required this.onGenderSelected,
    required this.onAgeGroupSelected,
    required this.selectedGender,
    required this.selectedAgeGroup,
  });

  @override
  State<GenderAgeSelectionScreen> createState() =>
      _GenderAgeSelectionScreenState();
}

class _GenderAgeSelectionScreenState extends State<GenderAgeSelectionScreen> {
  final selectedColor = AppColors.selected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('성별',
                style: TextStyle(
                  fontSize: 18,
                )),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildGenderOption(
              '남아',
              'assets/images/kid_boy.png',
            ),
            SizedBox(width: 20),
            _buildGenderOption(
              '여아',
              'assets/images/kid_girl.png',
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('연령대',
                style: TextStyle(
                  fontSize: 18,
                )),
          ],
        ),
        SizedBox(height: 10),
        Wrap(
          spacing: 20.0,
          runSpacing: 12.0,
          children: [
            _buildAgeButton('1세 이하'),
            _buildAgeButton('1~2세'),
            _buildAgeButton('3~4세'),
            _buildAgeButton('5~6세'),
            _buildAgeButton('7~8세'),
            _buildAgeButton('9~10세'),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption(String label, String imagePath) {
    bool isSelected = widget.selectedGender == label;

    return GestureDetector(
      onTap: () => widget.onGenderSelected(label),
      child: Column(
        children: [
          CircleContainer(
            imagePath: imagePath,
            label: label,
            backgroundColor: isSelected ? selectedColor : Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildAgeButton(String label) {
    bool isSeleted = widget.selectedAgeGroup == label;

    return GestureDetector(
      onTap: () => widget.onAgeGroupSelected(label),
      child: RectangleContainer(
        label: label,
        backgroundColor: isSeleted ? selectedColor : Colors.white,
      ),
    );
  }
}

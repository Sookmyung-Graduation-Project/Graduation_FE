import 'package:go_router/go_router.dart';
import 'package:phonics/core/router/routes.dart';

import 'character_selection_screen.dart';
import 'gender_age_screen.dart';
import 'lesson_selection_screen.dart';
import 'voice_selection_screen.dart';
import '../../widgets/constants.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_progress_bar_v2.dart';

class CreateBookScreen extends StatefulWidget {
  const CreateBookScreen({super.key});

  @override
  _CreateBookScreenState createState() => _CreateBookScreenState();
}

class _CreateBookScreenState extends State<CreateBookScreen> {
  String selectedGender = '';
  String selectedAgeGroup = '';
  String selectedLesson = '';
  String selectedCharacter = '';
  String selectedVoice = '보호자1(기본)';

  bool isStep1Completed = false;
  bool isStep2Completed = false;
  bool isStep3Completed = false;
  double progress = 0.15; //프로그레스 상태 변수 추가

  void _onGenderSelected(String gender) {
    setState(() {
      selectedGender = gender;
      _checkStep1Completion();
    });
  }

  void _onAgeGroupSelected(String ageGroup) {
    setState(() {
      selectedAgeGroup = ageGroup;
      _checkStep1Completion();
    });
  }

  void _checkStep1Completion() {
    if (selectedGender.isNotEmpty && selectedAgeGroup.isNotEmpty) {
      isStep1Completed = true;
      progress = 0.33;
    }
  }

  void _onLessonSelected(String lesson) {
    setState(() {
      selectedLesson = lesson;
      isStep2Completed = true;
      progress = 0.66;
    });
  }

  void _onCharacterSelected(String character) {
    setState(() {
      selectedCharacter = character;
      isStep3Completed = true;
      progress = 0.9;
    });
  }

  void _onVoiceSelected(String? voice) {
    setState(() {
      selectedVoice = voice ?? '';
      progress = 1.0;
    });
  }

  void _onBackToGenderAge() {
    setState(() {
      isStep1Completed = false;
      isStep2Completed = false;
      isStep3Completed = false;
      progress = 0.15;
    });
  }

  void _onBackToLesson() {
    setState(() {
      isStep2Completed = false;
      isStep3Completed = false;
      progress = 0.33;
    });
  }

  void _onBackToCharacterSelection() {
    setState(() {
      isStep3Completed = false;
      progress = 0.66;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.backgroundColor,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    DinosaurProgressBar(progress: progress),
                    const SizedBox(height: 10),
                    if (!isStep1Completed)
                      Column(
                        children: [
                          buildSectionTitle('독자의 성별과 연령대를 알려주세요!'),
                          const SizedBox(height: 30),
                          GenderAgeSelectionScreen(
                            onGenderSelected: _onGenderSelected,
                            onAgeGroupSelected: _onAgeGroupSelected,
                            selectedGender: selectedGender,
                            selectedAgeGroup: selectedAgeGroup,
                          ),
                        ],
                      ),
                    if (isStep1Completed && !isStep2Completed)
                      Column(
                        children: [
                          buildSectionTitle('생성할 동화의 교훈을 선택해 주세요!'),
                          LessonSelectionScreen(
                            onLessonSelected: _onLessonSelected,
                            selectedLesson: selectedLesson,
                            selectedGender: selectedGender,
                            selectedAgeGroup: selectedAgeGroup,
                            onBackToLesson: _onBackToLesson,
                            onBackToGenderAge: _onBackToGenderAge,
                          ),
                        ],
                      ),
                    if (isStep1Completed &&
                        isStep2Completed &&
                        !isStep3Completed)
                      Column(
                        children: [
                          buildSectionTitle('생성할 동화의 주인공을 선택해 주세요!'),
                          CharacterSelectionScreen(
                            onCharacterSelected: _onCharacterSelected,
                            selectedCharacter: selectedCharacter,
                            selectedLesson: selectedLesson,
                            selectedGender: selectedGender,
                            selectedAgeGroup: selectedAgeGroup,
                            onBackToLesson: _onBackToLesson,
                            onBackToGenderAge: _onBackToGenderAge,
                          ),
                        ],
                      ),
                    if (isStep1Completed &&
                        isStep2Completed &&
                        isStep3Completed)
                      Column(
                        children: [
                          buildSectionTitle('동화를 읽어줄 목소리를 선택하세요!'),
                          VoiceSelectionScreen(
                            selectedVoice: selectedVoice,
                            onVoiceSelected: _onVoiceSelected,
                            onBackToCharacterSelection:
                                _onBackToCharacterSelection,
                            onBackToLesson: _onBackToLesson,
                            onBackToGenderAge: _onBackToGenderAge,
                            selectedCharacter: selectedCharacter,
                            selectedLesson: selectedLesson,
                            selectedGender: selectedGender,
                            selectedAgeGroup: selectedAgeGroup,
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ),
          // 되돌아가기 버튼
          Positioned(
            left: 20,
            top: 20,
            child: SafeArea(
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 2),
                      color: Colors.black.withOpacity(0.3),
                    )
                  ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded, size: 20),
                  onPressed: () {
                    context.go(Routes.home);
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 33.5, fontWeight: FontWeight.bold),
    );
  }
}

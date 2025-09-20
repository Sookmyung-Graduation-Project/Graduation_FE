import 'package:go_router/go_router.dart';
import 'package:phonics/core/router/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:phonics/core/utils/api_service.dart';
import 'package:phonics/core/models/book/book_generation_request.dart';
import 'package:phonics/core/models/book/book_options.dart';

import 'character_selection_screen.dart';
import 'gender_age_screen.dart';
import 'lesson_selection_screen.dart';
import 'voice_selection_screen.dart';
import 'generate_screen.dart';
import '../book_detail_screen.dart';
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
  
  // API 관련 상태
  BookOptions? bookOptions;
  bool isLoadingOptions = false;
  bool isGenerating = false;

  @override
  void initState() {
    super.initState();
    _loadBookOptions();
  }

  Future<void> _loadBookOptions() async {
    setState(() {
      isLoadingOptions = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final jwt = prefs.getString('access_token');
      
      if (jwt != null) {
        final options = await ApiService.fetchBookOptions(jwt: jwt);
        setState(() {
          bookOptions = options;
          isLoadingOptions = false;
        });
      } else {
        setState(() {
          isLoadingOptions = false;
        });
        _showErrorDialog('로그인이 필요합니다.');
      }
    } catch (e) {
      setState(() {
        isLoadingOptions = false;
      });
      _showErrorDialog('옵션을 불러오는데 실패했습니다.');
    }
  }

  Future<void> _generateBook() async {
    if (isGenerating) return;

    setState(() {
      isGenerating = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final jwt = prefs.getString('access_token');
      
      if (jwt == null) {
        _showErrorDialog('로그인이 필요합니다.');
        return;
      }

      final request = BookGenerationRequest(
        gender: selectedGender,
        ageGroup: selectedAgeGroup,
        lesson: selectedLesson,
        character: selectedCharacter,
        voice: selectedVoice,
      );

      final response = await ApiService.generateBook(
        jwt: jwt,
        request: request,
      );

      if (response != null) {
        // 책 생성 성공 - 바로 책 읽기 화면으로 이동
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BookDetailScreen(book: response),
            ),
          );
        }
      } else {
        _showErrorDialog('책 생성에 실패했습니다. 다시 시도해주세요.');
      }
    } catch (e) {
      _showErrorDialog('책 생성 중 오류가 발생했습니다.');
    } finally {
      setState(() {
        isGenerating = false;
      });
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('오류'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

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
          // 로딩 상태 처리
          if (isLoadingOptions)
            const Center(
              child: CircularProgressIndicator(),
            )
          else
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
                          const SizedBox(height: 30),
                          // 책 생성 버튼
                          if (progress == 1.0)
                            SizedBox(
                              width: double.infinity,
                              height: 60,
                              child: ElevatedButton(
                                onPressed: isGenerating ? null : _generateBook,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  elevation: 5,
                                ),
                                child: isGenerating
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : const Text(
                                        '동화 생성하기',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                              ),
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

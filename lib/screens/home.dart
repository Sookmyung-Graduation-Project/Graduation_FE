import 'package:flutter/material.dart';
import 'package:phonics/screens/library_tab/home_tab_screen.dart';
import 'package:phonics/screens/study_tab/study_tab.dart';
import '../widgets/bottom_nav_bar.dart';
import '../screens/mypage_tab/mypage_screen.dart';
import 'createbook_tab/createbook_screen.dart';
import '../data/dailyword_data.dart';
import 'package:flutter_tts/flutter_tts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  int _consecutiveDays = 0;
  bool _isChecked = false;
  bool _showBubble = false;
  AnimationController? _bubbleAnimationController;
  Animation<double>? _bubbleAnimation;
  DailyWord? _todayWord;
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _loadTodayWord();
    _setupBubbleAnimation();
  }

  void _loadTodayWord() {
    setState(() {
      _todayWord = getTodayWord();
    });
  }

  Future<void> _ttsTodayWord() async {
    if (_todayWord != null) {
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(_todayWord!.word);
    }
  }

  void _setupBubbleAnimation() {
    _bubbleAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _bubbleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _bubbleAnimationController!,
      curve: Curves.easeInOut,
    ));
  }

  void _onCheckPressed() {
    setState(() {
      _isChecked = true;
      _consecutiveDays = 1;
      _showBubble = true;
    });

    // 말풍선 애니메이션 실행
    _bubbleAnimationController?.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          _bubbleAnimationController?.reverse().then((_) {
            setState(() {
              _showBubble = false;
            });
          });
        }
      });
    });
  }

  void _onTabTapped(int index) {
    if (_selectedIndex == index) return;

    setState(() {
      _selectedIndex = index;
    });

    Widget page;
    switch (index) {
      case 0:
        page = const MyHomePage();
        break;
      case 1:
        page = const HomeTabScreen();
        break;
      case 2:
        page = const StudyScreen();
        break;
      case 3:
        page = const CreateBookScreen();
        break;
      case 4:
        page = const MypageScreen();
        break;
      default:
        page = const MyHomePage();
    }

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => page,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }

  @override
  void dispose() {
    _bubbleAnimationController?.dispose();
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8E1),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 앱 로고/이름
                    const Text(
                      'APP LOGO | NAME',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 연속 출석 카드
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                _consecutiveDays > 0 ? '연속 학습' : '연속 출석',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                _consecutiveDays.toString(),
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 6,
                              ),
                              Text(
                                '일',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                width: 70,
                              ),
                              ElevatedButton(
                                onPressed: _isChecked ? null : _onCheckPressed,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 2),
                                  backgroundColor: const Color(0xFFFFB74D),
                                  foregroundColor: Colors.white,
                                  disabledBackgroundColor: Colors.grey[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                child: const Text('CHECK'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // 요일별 체크박스
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDayCheckbox('월',
                                  DateTime.now().weekday == 1 && _isChecked),
                              _buildDayCheckbox('화',
                                  DateTime.now().weekday == 2 && _isChecked),
                              _buildDayCheckbox('수',
                                  DateTime.now().weekday == 3 && _isChecked),
                              _buildDayCheckbox('목',
                                  DateTime.now().weekday == 4 && _isChecked),
                              _buildDayCheckbox('금',
                                  DateTime.now().weekday == 5 && _isChecked),
                              _buildDayCheckbox('토',
                                  DateTime.now().weekday == 6 && _isChecked),
                              _buildDayCheckbox('일',
                                  DateTime.now().weekday == 7 && _isChecked),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // 공룡 이미지
                    SizedBox(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            _isChecked
                                ? 'assets/images/baby_dino_smile.png'
                                : 'assets/images/baby_dino.png',
                            errorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                'assets/images/baby_dino.png',
                              );
                            },
                          ),

                          // 말풍선 팝업
                          if (_showBubble && _bubbleAnimation != null)
                            Positioned(
                              top: 160,
                              right: 10,
                              child: AnimatedBuilder(
                                animation: _bubbleAnimation!,
                                builder: (context, child) {
                                  return Transform.scale(
                                    scale: _bubbleAnimation!.value,
                                    child: Opacity(
                                      opacity: _bubbleAnimation!.value,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: const Text(
                                          'Have a nice day ❤',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 150,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEB9B55),
                    ),
                    child: const Text(
                      'TODAY WORD',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  if (_todayWord != null)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                          left: 12, right: 12, bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                _todayWord!.word,
                                style: const TextStyle(
                                  fontSize: 42,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4B45B5),
                                ),
                              ),
                              const SizedBox(width: 8),
                              IconButton(
                                onPressed: _ttsTodayWord,
                                icon: const Icon(
                                  Icons.volume_up,
                                  color: Colors.black,
                                  size: 32,
                                ),
                              ),
                            ],
                          ),

                          // 한국어 의미
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFE0B2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  '뜻',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _todayWord!.meaning,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          // 예문
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 12),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              border: const Border(
                                left: BorderSide(
                                  color: Colors.black26,
                                  width: 4,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _todayWord!.example,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _todayWord!.exampleKo,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }

  Widget _buildDayCheckbox(String day, bool isChecked) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isChecked ? const Color(0xFFFFB74D) : Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: isChecked
            ? const Icon(
                Icons.star,
                color: Colors.white,
                size: 28,
              )
            : Text(
                day,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonics/core/provider/login_provider.dart';
import 'package:phonics/core/provider/user_info_provider.dart';
import '../data/dailyword_data.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../core/utils/api_service.dart';
import '../screens/home_calendar.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage>
    with TickerProviderStateMixin {
  int _consecutiveDays = 0;
  bool _isChecked = false;
  bool _showBubble = false;
  // 금주 요일 출석(0=월 ~ 6=일)
  Set<int> _attendedDays = <int>{};
  AnimationController? _bubbleAnimationController;
  Animation<double>? _bubbleAnimation;
  DailyWord? _todayWord;
  FlutterTts flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _initTts();
    _loadTodayWord();
    _setupBubbleAnimation();
    _loadAttendanceStatus();
  }

  void _loadTodayWord() {
    setState(() {
      _todayWord = getTodayWord();
    });
  }

  Future<void> _initTts() async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.setSpeechRate(0.42);
    await flutterTts.setPitch(1.0);
    await flutterTts.setVolume(1.0);
    await flutterTts.setLanguage('en-US');

    try {
      await flutterTts.setEngine('com.google.android.tts');
      await Future.delayed(const Duration(milliseconds: 200));
    } catch (_) {}

    final voices = await flutterTts.getVoices;
    if (voices is List) {
      final en = voices
          .whereType<Map>()
          .map((m) => m.map((k, v) => MapEntry(k.toString(), '${v ?? ''}')))
          .firstWhere(
            (v) =>
                (v['locale'] ?? '').toLowerCase().startsWith('en-us') ||
                (v['locale'] ?? '').toLowerCase().startsWith('en-'),
            orElse: () => const {},
          );
      if (en.isNotEmpty) {
        await flutterTts.setVoice(en);
        await flutterTts.setLanguage('en-US');
      }
    }
  }

  Future<void> _ttsTodayWord() async {
    final text = _todayWord?.word.trim();
    if (text == null || text.isEmpty) return;
    try {
      await flutterTts.stop();
    } catch (_) {}
    await flutterTts.speak(text);
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

  Future<void> _loadAttendanceStatus() async {
    final user = ref.read(userResponseProvider);
    final serverUser = ref.read(serverUserProvider);
    if (user == null || serverUser == null) return;
    try {
      final resp = await ApiService.getAttendanceStatus(
          jwt: user.accessToken, userId: serverUser.id);
      print('=== 출석현황 응답 ===');
      print('consecutive_days: ${resp['consecutive_days']}');
      print('attended_days: ${resp['attended_days']}');

      final consecutive = (resp['consecutive_days'] ?? 0) as int;
      final List<dynamic> days = (resp['attended_days'] ?? []) as List<dynamic>;
      setState(() {
        _consecutiveDays = consecutive;
        _attendedDays = days.map((e) => (e as num).toInt()).toSet();
        // 오늘 요일(월=1..일=7)을 0 기반(월=0..일=6)으로 변환해 체크 상태 계산
        final int todayIndex = DateTime.now().weekday - 1;
        _isChecked = _attendedDays.contains(todayIndex);
      });
    } catch (e) {
      print('출석현황 로드 오류: $e');
      // 무시하고 화면은 기본값 유지
    }
  }

  Future<void> _onCheckPressed() async {
    final user = ref.read(userResponseProvider);
    final serverUser = ref.read(serverUserProvider);
    if (user == null || serverUser == null) return;
    try {
      final resp = await ApiService.markAttendance(
          jwt: user.accessToken, userId: serverUser.id, isPresent: true);

      print('=== 출석체크 응답 ===');
      print('consecutive_days: ${resp['consecutive_days']}');
      print('status: ${resp['status']}');

      // 성공 시 UI 반영 및 애니메이션
      final int todayIndex = DateTime.now().weekday - 1; // 0=월
      final updatedConsecutiveDays = (resp['consecutive_days'] ?? 0) as int;

      setState(() {
        _isChecked = true;
        _attendedDays = {..._attendedDays, todayIndex};
        _consecutiveDays = updatedConsecutiveDays; // 서버에서 받은 정확한 연속출석일 사용
        _showBubble = true;
      });

      _bubbleAnimationController?.forward().then((_) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            _bubbleAnimationController?.reverse().then((_) {
              if (mounted) {
                setState(() {
                  _showBubble = false;
                });
              }
            });
          }
        });
      });
    } catch (e) {
      print('출석체크 오류: $e');
      // 실패 시 스낵바 알림
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('출석 체크 실패')),
      );
    }
  }

  @override
  void dispose() {
    _bubbleAnimationController?.dispose();
    flutterTts.stop();
    super.dispose();
  }

  void _goToCalendarScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CalendarScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        reverseTransitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userResponse = ref.watch(userResponseProvider);

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
                    Text(
                      'APP LOGO | ${userResponse?.nickname ?? 'Guest'} 님',
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
                                '연속 학습',
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
                                width: 60,
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
                              SizedBox(
                                width: 15,
                              ),
                              IconButton(
                                onPressed: () => _goToCalendarScreen(context),
                                icon: Image.asset(
                                  'assets/navigation_icons/hometocal_icon.png',
                                  width: 25,
                                  height: 25,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // 요일별 체크박스
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildDayCheckbox('월', _attendedDays.contains(0)),
                              _buildDayCheckbox('화', _attendedDays.contains(1)),
                              _buildDayCheckbox('수', _attendedDays.contains(2)),
                              _buildDayCheckbox('목', _attendedDays.contains(3)),
                              _buildDayCheckbox('금', _attendedDays.contains(4)),
                              _buildDayCheckbox('토', _attendedDays.contains(5)),
                              _buildDayCheckbox('일', _attendedDays.contains(6)),
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
                      height: 170,
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

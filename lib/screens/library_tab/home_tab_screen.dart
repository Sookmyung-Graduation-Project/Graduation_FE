import 'package:flutter/material.dart';
import 'recent_section.dart';
import 'ranking_section.dart';
import 'favorite_section.dart';
import 'package:phonics/widgets/bottom_nav_bar.dart';
import '../home.dart';
import '../study_tab/study_tab.dart';
import '../mypage_tab/mypage_screen.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 1;

  //int _selectedIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
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
      // case 3:
      //   page = const CreateBookPage();
      //   break;
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF), // 전체 배경색
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.only(top: 12), // ← 상단 padding 조절
          child: AppBar(
            backgroundColor: const Color(0xFFFFFFFF),
            elevation: 0,
            title: const Text(
              'App Logo',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: false,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 18,
                  left: 10,
                  right: 10,
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double width = constraints.maxWidth * 0.999; // 338.48 / 375
                    double height = width * 0.084; // 비율 유지

                    return SizedBox(
                      width: width,
                      height: height,
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: '제목으로 책을 찾아 보세요',
                          hintStyle: const TextStyle(
                            color: Color(0xFF343434),
                            fontWeight: FontWeight.normal,
                          ),
                          prefixIcon: const Padding(
                            padding: EdgeInsets.only(left: 12, right: 0),
                            child: Icon(Icons.search, color: Color(0xFF343434)),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 30,
                            minHeight: 30,
                          ),
                          filled: true,
                          fillColor: const Color(0xFFF3F3F3),
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 탭바
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFEB),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: const Color(0xFFFFFFEB), // 터치 효과 제거용
                    highlightColor: const Color(0xFFFFFFEB),
                    dividerColor: const Color(0xFFFFFFEB), // 요거 중요!
                  ),
                  child: TabBar(
                    controller: _tabController,

                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: 1.0, // 가로 폭은 줄이면 늘어난 효과! (좌우 마진 작게)
                      vertical: 0.4, // 세로 높이 줄이기 (indicator 얇아짐)
                    ),
                    indicator: BoxDecoration(
                      color: const Color(0xFFFFFFEB), // 배경색
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          //color: Colors.black.withOpacity(0.25),
                          color:
                              Colors.black.withAlpha(64), // 0.25 * 255 = 약 64
                          offset: const Offset(4, 0),
                          blurRadius: 4,
                        ),
                      ],
                    ),

                    indicatorColor: const Color(0xFFFFFFEB), // 기본 선 제거
                    labelColor: const Color(0xFF343434),
                    unselectedLabelColor: Colors.grey,
                    // 여기서 텍스트 스타일 지정
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                    tabs: const [
                      Tab(text: 'Recent'),
                      Tab(text: 'Ranking'),
                      Tab(text: 'Favorite'),
                    ],
                  ),
                ),
              ),

              // 탭뷰 (남은 영역 모두 차지)
              Expanded(
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFEB),
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFFFFFEB), // 상단 선 제거
                        width: 0,
                      ),
                    ),
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: const [
                      RecentSection(),
                      RankingSection(),
                      FavoriteSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomNavBar(
              selectedIndex: _selectedIndex,
              onTabTapped: _onTabTapped,
            ),
          ),
        ],
      ),
    );
  }
}

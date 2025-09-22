import 'package:flutter/material.dart';
import 'recent_section.dart';
import 'ranking_section.dart';
import 'favorite_section.dart';

class HomeTabScreen extends StatefulWidget {
  const HomeTabScreen({super.key});

  @override
  State<HomeTabScreen> createState() => _HomeTabScreenState();
}

class _HomeTabScreenState extends State<HomeTabScreen>
    with SingleTickerProviderStateMixin {
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: AppBar(
            backgroundColor: const Color(0xFFFFFFFF),
            elevation: 0,
            title: Image.asset(
              'assets/logo_icons/typo_en.png',
              width: 170,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
              errorBuilder: (context, error, stackTrace) {
                return const Text(
                  'Buddy Books',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
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
                    double width = constraints.maxWidth * 0.999;
                    double height = width * 0.084;

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
                    splashColor: const Color(0xFFFFFFEB),
                    highlightColor: const Color(0xFFFFFFEB),
                    dividerColor: const Color(0xFFFFFFEB),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.symmetric(
                      horizontal: 1.0,
                      vertical: 0.4,
                    ),
                    indicator: BoxDecoration(
                      color: const Color(0xFFFFFFEB),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(64),
                          offset: const Offset(4, 0),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    indicatorColor: const Color(0xFFFFFFEB),
                    labelColor: const Color(0xFF343434),
                    unselectedLabelColor: Colors.grey,
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.zero,
                  margin: EdgeInsets.zero,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFFFEB),
                    border: Border(
                      top: BorderSide(
                        color: Color(0xFFFFFFEB),
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
              SizedBox(
                height: 100,
              )
            ],
          ),
        ],
      ),
    );
  }
}

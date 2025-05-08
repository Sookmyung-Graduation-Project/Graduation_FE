import 'package:flutter/material.dart';

class RankingSection extends StatefulWidget {
  const RankingSection({super.key});

  @override
  State<RankingSection> createState() => _RankingSectionState();
}

class _RankingSectionState extends State<RankingSection>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this); // 4개 탭
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 🏆 상단 Top 10
        const Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            children: [
              Icon(Icons.emoji_events, color: Colors.amber),
              SizedBox(width: 12),
              Text(
                'Top 10 Books',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ],
          ),
        ),
        const RankingCarousel(), // ← 바로 이렇게 사용
        Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Container(
            color: const Color(0xFFFFFFFF), // ← 원하는 배경색
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF343434), // 선택된 탭 텍스트 색
              unselectedLabelColor: Colors.grey, // 선택 안 된 탭 텍스트 색
              indicatorColor: Colors.transparent,
              // ✅ 여기서 텍스트 스타일 지정
              labelStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.normal,
              ),
              tabs: const [
                Tab(text: 'Newest'),
                Tab(text: 'Popular'),
                Tab(text: 'Best Seller'),
                Tab(text: 'Open Books'),
              ],
            ),
          ),
        ),

        // 📚 탭 콘텐츠
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              Center(child: Text('Newest List')),
              Center(child: Text('Popular List')),
              Center(child: Text('Best Seller List')),
              Center(child: Text('Open Books List')),
            ],
          ),
        ),
      ],
    );
  }
}

// 👇 이게 밑에 따라오는 보조 위젯
class RankingCarousel extends StatefulWidget {
  const RankingCarousel({super.key});

  @override
  State<RankingCarousel> createState() => _RankingCarouselState();
}

class _RankingCarouselState extends State<RankingCarousel> {
  late ScrollController _scrollController;
  final int itemCount = 10;
  final double itemAspectRatio = 94 / 67.4;

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double _calculateScale(
    double itemCenter,
    double viewCenter,
    double maxDistance,
  ) {
    final distance = (itemCenter - viewCenter).abs();
    return (1 - (distance / maxDistance)).clamp(0.75, 1.0);
  }

  double _calculateOpacity(
    double itemCenter,
    double viewCenter,
    double maxDistance,
  ) {
    final distance = (itemCenter - viewCenter).abs();
    return (1 - (distance / maxDistance)).clamp(0.5, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // 동적으로 화면당 몇 개 보여줄지 설정 (무조건 홀수)
    final visibleItemCount = screenWidth > 900
        ? 7
        : screenWidth > 600
            ? 5
            : 3;
    final itemWidth = screenWidth / visibleItemCount;
    final itemHeight = itemWidth * (94 / 67.4);

    return SizedBox(
      height: itemHeight + 30,
      child: NotificationListener<ScrollNotification>(
        onNotification: (_) {
          setState(() {});
          return false;
        },
        child: ListView.builder(
          controller: _scrollController,
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemBuilder: (context, index) {
            final offset = _scrollController.offset;
            final itemCenter =
                index * (itemWidth + 16) + itemWidth / 2 - offset;
            final viewCenter = screenWidth / 2;
            final maxDistance = screenWidth / 2;

            final scale = _calculateScale(itemCenter, viewCenter, maxDistance);
            final opacity = _calculateOpacity(
              itemCenter,
              viewCenter,
              maxDistance,
            );

            return Opacity(
              opacity: opacity,
              child: Transform.scale(
                scale: scale,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: ClipRRect(
                    child: Image.network(
                      'https://covers.openlibrary.org/b/id/8231856-L.jpg',
                      width: itemWidth,
                      height: itemHeight,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

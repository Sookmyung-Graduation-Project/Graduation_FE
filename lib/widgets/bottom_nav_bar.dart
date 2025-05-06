import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabTapped,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double iconSize = 70;

    return SafeArea(
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            height: screenHeight * 0.072,
            // width: screenWidth, // 이 줄은 빼세요!
            decoration: BoxDecoration(
              color: const Color(0xffFFFCC3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.09),
                  blurRadius: 4,
                  offset: const Offset(2, 4),
                ),
              ],
              borderRadius: const BorderRadius.all(Radius.circular(29.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 탭 1
                Expanded(
                  child: _buildTabItem(
                    index: 1,
                    label: '서재',
                    activeIcon:
                        'assets/navigation_icons/library_icon_active.png',
                    inactiveIcon:
                        'assets/navigation_icons/library_icon_inactive.png',
                    screenWidth: screenWidth,
                  ),
                ),
                // 탭 2
                Expanded(
                  child: _buildTabItem(
                    index: 2,
                    label: '학습페이지',
                    activeIcon: 'assets/navigation_icons/study_icon_active.png',
                    inactiveIcon:
                        'assets/navigation_icons/study_icon_inactive.png',
                    screenWidth: screenWidth,
                  ),
                ),
                // 중앙 홈 버튼 공간용 (아무것도 없음)
                const SizedBox(width: 60), // 홈버튼이 겹치지 않게 적당히 공간 확보
                // 탭 3
                Expanded(
                  child: _buildTabItem(
                    index: 3,
                    label: '책 만들기',
                    activeIcon:
                        'assets/navigation_icons/createbook_icon_active.png',
                    inactiveIcon:
                        'assets/navigation_icons/createbook_icon_inactive.png',
                    screenWidth: screenWidth,
                  ),
                ),
                // 탭 4
                Expanded(
                  child: _buildTabItem(
                    index: 4,
                    label: '마이페이지',
                    activeIcon:
                        'assets/navigation_icons/mypage_icon_active.png',
                    inactiveIcon:
                        'assets/navigation_icons/mypage_icon_inactive.png',
                    screenWidth: screenWidth,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -20,
            child: Container(
              width: screenWidth * 0.2,
              height: screenWidth * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.09),
                    blurRadius: 4,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: -15,
            child: GestureDetector(
              onTap: () {
                if (selectedIndex != 0) {
                  onTabTapped(0);
                }
              },
              child: Container(
                height: screenWidth * 0.17,
                width: screenWidth * 0.17,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xffFFFCC3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.09),
                      blurRadius: 4,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Image.asset(
                    selectedIndex == 0
                        ? 'assets/navigation_icons/home_icon_active.png'
                        : 'assets/navigation_icons/home_icon_inactive.png',
                    width: screenWidth * 0.062,
                    height: screenWidth * 0.062,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required String label,
    required String activeIcon,
    required String inactiveIcon,
    required double screenWidth,
  }) {
    return GestureDetector(
      onTap: () {
        if (selectedIndex != index) {
          onTabTapped(index);
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            selectedIndex == index ? activeIcon : inactiveIcon,
            height: screenWidth * 0.055,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: selectedIndex == index
                  ? const Color(0xff363535)
                  : const Color.fromARGB(255, 169, 169, 169),
            ),
          ),
        ],
      ),
    );
  }
}

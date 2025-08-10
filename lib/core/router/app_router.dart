import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phonics/screens/home.dart';
import 'package:phonics/screens/library_tab/home_tab_screen.dart';
import 'package:phonics/screens/mypage_tab/mypage_screen.dart';
import 'package:phonics/screens/study_tab/study_tab.dart';
import 'package:phonics/screens/createbook_tab/createbook_screen.dart';
import 'package:phonics/widgets/bottom_nav_bar.dart';
import 'package:phonics/core/router/routes.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.home,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        // 현재 경로에 맞는 selectedIndex 값 설정
        int selectedIndex = 0;
        if (state.uri.toString() == Routes.homeTab) {
          selectedIndex = 1;
        } else if (state.uri.toString() == Routes.study) {
          selectedIndex = 2;
        } else if (state.uri.toString() == Routes.bookCreation) {
          selectedIndex = 3;
        } else if (state.uri.toString() == Routes.myPage) {
          selectedIndex = 4;
        }

        // study 화면에서는 하단 네비게이션 바를 숨기도록 처리
        bool showBottomNavBar = state.uri.toString() != Routes.study;

        return Scaffold(
          backgroundColor: Colors.transparent, // 전체 배경을 투명하게 설정
          resizeToAvoidBottomInset: false, // 하단 네비게이션이 콘텐츠를 밀지 않도록 설정
          body: Stack(
            children: [
              Positioned.fill(child: child), // 하위 화면을 Stack 내에 배치

              // 하단 네비게이션 바가 필요할 때만 표시
              if (showBottomNavBar)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CustomBottomNavBar(
                    selectedIndex: selectedIndex,
                    onTabTapped: (index) {
                      switch (index) {
                        case 0:
                          context.go(Routes.home); // 홈으로 이동
                          break;
                        case 1:
                          context.go(Routes.homeTab); // 홈탭으로 이동
                          break;
                        case 2:
                          context.go(Routes.study); // 학습으로 이동
                          break;
                        case 3:
                          context.go(Routes.bookCreation); // 책 생성으로 이동
                          break;
                        case 4:
                          context.go(Routes.myPage); // 마이페이지로 이동
                          break;
                        default:
                          context.go(Routes.home); // 기본적으로 홈
                      }
                    },
                  ),
                ),
            ],
          ),
        );
      },
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (context, state) => const MyHomePage(),
        ),
        GoRoute(
          path: Routes.homeTab,
          builder: (context, state) => const HomeTabScreen(),
        ),
        GoRoute(
          path: Routes.myPage,
          builder: (context, state) => const MypageScreen(),
        ),
        GoRoute(
          path: Routes.bookCreation,
          builder: (context, state) => const CreateBookScreen(),
        ),
        GoRoute(
          path: Routes.study,
          builder: (context, state) => const StudyScreen(),
        ),
      ],
    ),
  ],
);

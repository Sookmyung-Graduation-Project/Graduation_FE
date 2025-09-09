import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phonics/book_content_screen.dart';
import 'package:phonics/core/screens/login_screen.dart';
import 'package:phonics/screens/book_detail_screen.dart';
import 'package:phonics/screens/home.dart';
import 'package:phonics/screens/library_tab/home_tab_screen.dart';
import 'package:phonics/screens/mypage_tab/mypage_screen.dart';
import 'package:phonics/screens/mypage_tab/mypage_to_deleteaccount.dart';
import 'package:phonics/screens/mypage_tab/mypage_to_favoritebooks.dart';
import 'package:phonics/screens/mypage_tab/mypage_to_voicesetting.dart';
import 'package:phonics/screens/study_tab/phonics_menu.dart';
import 'package:phonics/screens/study_tab/quiz_menu.dart';
import 'package:phonics/screens/study_tab/study_tab.dart';
import 'package:phonics/screens/createbook_tab/createbook_screen.dart';
import 'package:phonics/widgets/bottom_nav_bar.dart';
import 'package:phonics/core/router/routes.dart';
import 'package:phonics/screens/study_tab/quiz_detailmenu.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: Routes.login,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
      routes: [
        GoRoute(
          path: Routes.home,
          builder: (context, state) => const MyHomePage(),
        ),
      ],
    ),
    ShellRoute(
      builder: (context, state, child) {
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

        bool showBottomNavBar = state.uri.toString() == Routes.home ||
            state.uri.toString() == Routes.homeTab ||
            state.uri.toString() == Routes.myPage;

        return Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Positioned.fill(child: child),
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
                          context.go(Routes.home);
                          break;
                        case 1:
                          context.go(Routes.homeTab);
                          break;
                        case 2:
                          context.go(Routes.study);
                          break;
                        case 3:
                          context.go(Routes.bookCreation);
                          break;
                        case 4:
                          context.go(Routes.myPage);
                          break;
                        default:
                          context.go(Routes.home);
                      }
                    },
                  ),
                ),
            ],
          ),
        );
      },
      routes: [
        // 홈
        GoRoute(
          path: Routes.home,
          builder: (context, state) => const MyHomePage(),
        ),
        //서재
        GoRoute(
            path: Routes.homeTab,
            builder: (context, state) => const HomeTabScreen(),
            routes: [
              GoRoute(
                  path: Routes.bookDetail,
                  builder: (context, state) {
                    final book = state.extra as Map<String, dynamic>;
                    return BookDetailScreen(book: book);
                  },
                  routes: [
                    GoRoute(
                      path: Routes.bookContent,
                      builder: (context, state) {
                        final book = state.extra as Map<String, dynamic>;
                        final pages = List<String>.from(
                            book['content'] ?? const <String>[]);
                        return BookContentScreen(pages: pages);
                      },
                    ),
                  ]),
            ]),
        //마이페이지
        GoRoute(
            path: Routes.myPage,
            builder: (context, state) => const MypageScreen(),
            routes: [
              GoRoute(
                path: Routes.voiceSetting,
                builder: (context, state) => const MypageToVoicesetting(),
              ),
              GoRoute(
                path: Routes.mypageToFavoritebooks,
                builder: (context, state) => const MypageToFavoritebooks(),
              ),
              GoRoute(
                path: Routes.mypageToFavoritebooks,
                builder: (context, state) => const MypageToFavoritebooks(),
              ),
              GoRoute(
                path: Routes.mypageToDeleteaccount,
                builder: (context, state) => const MypageToDeleteaccount(),
              ),
            ]),
        // 책 만들기
        GoRoute(
          path: Routes.bookCreation,
          builder: (context, state) => const CreateBookScreen(),
        ),
        // 학습 페이지
        GoRoute(
          path: Routes.study,
          builder: (context, state) => const StudyScreen(),
          routes: [
            GoRoute(
                path: Routes.quiz,
                builder: (context, state) => const QuizMenu(),
                routes: [
                  GoRoute(
                      path: Routes.quizDetail,
                      builder: (context, state) => QuizDetailmenu()),
                ]),
            GoRoute(
              path: Routes.phonics,
              builder: (context, state) => const PhonicsScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

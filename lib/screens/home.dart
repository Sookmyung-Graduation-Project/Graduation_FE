import 'package:flutter/material.dart';
import 'package:phonics/screens/library_tab/home_tab_screen.dart';
import 'package:phonics/screens/study_tab/study_tab.dart';
import '../widgets/bottom_nav_bar.dart';
import '../screens/mypage_tab/mypage_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

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
      body: Center(
        child: Text('선택된 탭: $_selectedIndex'),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabTapped: _onTabTapped,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MypageToFavoritebooks extends StatefulWidget {
  const MypageToFavoritebooks({super.key});

  @override
  State<MypageToFavoritebooks> createState() => _MypageToFavoritebooksState();
}

class _MypageToFavoritebooksState extends State<MypageToFavoritebooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('찜한 책 목록'),
      ),
      body: const Column(
        children: [
          Text('찜한 책 목록'),
        ],
      ),
    );
  }
}

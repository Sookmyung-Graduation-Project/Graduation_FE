import 'package:flutter/material.dart';

class MypageToNotice extends StatefulWidget {
  const MypageToNotice({super.key});

  @override
  State<MypageToNotice> createState() => _MypageToNoticeState();
}

class _MypageToNoticeState extends State<MypageToNotice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('공지사항'),
      ),
      body: const Column(
        children: [
          Text('공지사항'),
        ],
      ),
    );
  }
}

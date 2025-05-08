import 'package:flutter/material.dart';

class MypageToVoicesetting extends StatefulWidget {
  const MypageToVoicesetting({super.key});

  @override
  State<MypageToVoicesetting> createState() => _MypageToVoicesettingState();
}

class _MypageToVoicesettingState extends State<MypageToVoicesetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('음성세팅'),
      ),
      body: const Column(
        children: [
          Text('음성세팅'),
        ],
      ),
    );
  }
}

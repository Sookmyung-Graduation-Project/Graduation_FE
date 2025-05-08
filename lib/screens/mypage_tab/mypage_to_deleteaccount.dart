import 'package:flutter/material.dart';
import 'package:phonics/screens/study_tab/quiz_screen.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class MypageToDeleteaccount extends StatefulWidget {
  const MypageToDeleteaccount({super.key});

  @override
  State<MypageToDeleteaccount> createState() => _MypageToDeleteaccountState();
}

class _MypageToDeleteaccountState extends State<MypageToDeleteaccount> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffFFFFEB),
      appBar: AppBar(
        backgroundColor: const Color(0xffFFFFEB),
        title: const Text('탈퇴하기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'App Name을 탈퇴하기 전에 \n 확인해주세요',
              style: TextStyle(
                color: Color(0xff363535),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15.0),
              width: screenWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffFAC632).withOpacity(0.3),
              ),
              child: const Text('탈퇴가 완료되면 개인정보는 즉시 파기되며, 복구가 불가해요.'),
            ),
            const Text('탈퇴 사유'),
          ],
        ),
      ),
    );
  }
}

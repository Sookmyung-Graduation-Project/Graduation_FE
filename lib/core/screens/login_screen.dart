import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phonics/core/provider/login_provider.dart';
import 'package:phonics/core/provider/user_info_provider.dart';
import 'package:phonics/core/provider/voice_provider.dart';
import 'package:phonics/core/router/routes.dart';
import 'package:phonics/core/utils/api_service.dart';
import 'package:phonics/core/utils/kakao_login.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFEB),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 카카오 로그인 버튼
                TextButton(
                  onPressed: () async {
                    final result = await KakaoLoginApi().signWithKakao();
                    if (result != null) {
                      ref.read(userResponseProvider.notifier).state =
                          result.userResponse;

                      ref.read(voicesProvider.notifier).state = result.voices;

                      ref.read(serverUserProvider.notifier).state =
                          result.userInfo;

                      context.go(Routes.home, extra: result.userResponse);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffF5E04D),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/images/core/kakaotalk_logo.png',
                              width: 30),
                          const SizedBox(width: 20),
                          const Text(
                            '카카오톡으로 계속하기',
                            style: TextStyle(
                              fontFamily: 'GyeonggiTitle_Medium',
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Google 로그인 버튼 (임시로 카카오 로그인 버튼을 추가)
                TextButton(
                  onPressed: () async {
                    final userResponse = await KakaoLoginApi().signWithKakao();
                    if (userResponse != null) {
                      // 로그인 성공 후 홈 화면으로 이동
                      print('로그인 성공: ${userResponse.userInfo.nickname}');
                      context.go(Routes.home); // GoRouter 사용
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color(0xffFEFEFE),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/core/google_logo.png',
                            width: 20,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          const Text(
                            'Google로 계속하기',
                            style: TextStyle(
                                fontFamily: 'GyeonggiTitle_Medium',
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

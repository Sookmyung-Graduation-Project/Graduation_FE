import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';
import 'package:phonics/core/screens/login_screen.dart';
import 'screens/study_tab/study_tab.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final String kakaoNativeAppKey = dotenv.get('KAKAO_NATIVE_APP_KEY');
  final String kakaoJavaScriptKey = dotenv.get('KAKAO_JAVASCRIPT_KEY');

  KakaoSdk.init(
      nativeAppKey: kakaoNativeAppKey, javaScriptAppKey: kakaoJavaScriptKey);
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Background Image',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/home',
      routes: {
        '/home': (context) => const LoginScreen(),
        '/study': (context) => const StudyScreen(),
      },
    );
  }
}

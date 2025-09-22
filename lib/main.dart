import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_common.dart';
import 'package:phonics/core/router/app_router.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:phonics/core/provider/jwt_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:phonics/core/provider/loading_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();
  await dotenv.load(fileName: ".env");

  final kakaoNativeAppKey = dotenv.get('KAKAO_NATIVE_APP_KEY');
  final kakaoJavaScriptKey = dotenv.get('KAKAO_JAVASCRIPT_KEY');

  KakaoSdk.init(
    nativeAppKey: kakaoNativeAppKey,
    javaScriptAppKey: kakaoJavaScriptKey,
  );
  setPathUrlStrategy();

  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(jwtInitProvider, (previous, next) {
      FlutterNativeSplash.remove();
    });

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      builder: (context, child) {
        // 로딩 위젯 추가
        final isLoading = ref.watch(isLoadingProvider);
        debugPrint('isLoading: $isLoading');
        return Stack(
          children: [
            child ?? const SizedBox.shrink(),
            if (isLoading)
              Positioned.fill(
                child: Stack(
                  children: [
                    const ModalBarrier(
                        color: Colors.black45, dismissible: false),
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          'assets/logo_icons/logo_loading.gif',
                          width: 50,
                          gaplessPlayback: true,
                          filterQuality: FilterQuality.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

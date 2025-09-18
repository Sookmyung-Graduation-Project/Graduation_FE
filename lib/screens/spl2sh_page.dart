import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phonics/core/router/routes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

class Spl2shPage extends StatefulWidget {
  const Spl2shPage({super.key});

  @override
  State<Spl2shPage> createState() => _Spl2shPageState();
}

class _Spl2shPageState extends State<Spl2shPage> {
  Timer? _timer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(
      const AssetImage('assets/logo_icons/splash_second.png'),
      context,
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timer = Timer(const Duration(milliseconds: 900), () {
        if (!mounted) return;
        context.go(Routes.login);
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final logoWidth =
        (size.width < size.height ? size.width : size.height) * 0.7;
    return Scaffold(
      backgroundColor: Color.fromRGBO(188, 227, 156, 1.0),
      body: Center(
        child: Image(
          image: AssetImage('assets/logo_icons/splash_second.png'),
          width: logoWidth,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
        ),
      ),
    );
  }
}

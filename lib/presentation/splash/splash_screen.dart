import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../presentation/home/home_screen.dart';

class SplashScreen extends HookConsumerWidget {
  const SplashScreen({super.key});
  static const route = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future.delayed(const Duration(seconds: 3), () {
        context.pushReplacement(HomeScreen.route);
      });
      return null;
    }, []);

    return Scaffold(
      body: Center(
        child: Lottie.asset("assets/splash.json"),
      ),
    );
  }
}

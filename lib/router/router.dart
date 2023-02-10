import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../presentation/home/home_screen.dart';
import '../../presentation/home/screens/image_details.dart';

import '../presentation/home/screens/edit_screen.dart';
import '../presentation/splash/splash_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier();

  final listenable = ValueNotifier<bool>(true);

  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: listenable,
    routes: router._routes,
    errorPageBuilder: router._errorPageBuilder,
    observers: [BotToastNavigatorObserver()],
  );
});

class RouterNotifier extends ChangeNotifier {
  List<GoRoute> get _routes => [
        GoRoute(
          path: SplashScreen.route,
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: HomeScreen.route,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: ImageDetails.route,
          builder: (context, state) => ImageDetails(
            index: int.parse(state.queryParams['index']!),
          ),
        ),
        GoRoute(
          path: EditorScreen.route,
          builder: (context, state) => EditorScreen(
            url: state.queryParams['url']!,
          ),
        ),
      ];
  Page<void> _errorPageBuilder(BuildContext context, GoRouterState state) =>
      MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text('Error: ${state.error.toString()}'),
          ),
        ),
      );
}

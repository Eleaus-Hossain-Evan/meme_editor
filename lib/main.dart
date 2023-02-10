import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'application/global.dart';
import 'application/local_storage/storage_handler.dart';
import 'router/router.dart';
import 'server/api_routes.dart';
import 'utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer(
    observers: [ProviderLog()],
  );

  Logger.init(
    kDebugMode, // isEnable ，if production ，please false
    isShowFile: false, // In the IDE, whether the file name is displayed
    isShowTime: false, // In the IDE, whether the time is displayed
    levelVerbose: 247,
    levelDebug: 15,
    levelInfo: 10,
    levelWarn: 5,
    levelError: 9,
    phoneVerbose: Colors.white,
    phoneDebug: Colors.lightBlue,
    phoneInfo: Colors.greenAccent,
    phoneWarn: Colors.yellow.shade600,
    phoneError: Colors.redAccent,
  );

  final api = NetworkHandler.instance;

  api.setup(baseUrl: APIRoute.baseURL, showLogs: true);

  final box = container.read(hiveProvider);
  await box.init();

  final String token = box.get(KStrings.token, defaultValue: '');

  NetworkHandler.instance
    ..setup(baseUrl: APIRoute.baseURL, showLogs: false)
    ..setToken(token);

  Logger.d('token: $token');

  runApp(
    ProviderScope(
      parent: container,
      child: const MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return DismissKeyboard(
      child: ScreenUtilInit(
        designSize: const Size(411.4, 843.4),
        builder: (context, child) {
          return MaterialApp.router(
            title: KStrings.appName,
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: ref.watch(scaffoldKeyProvider),
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            theme: ThemeData(
              fontFamily: GoogleFonts.josefinSans().fontFamily,
            ),
            routerDelegate: router.routerDelegate,
            scrollBehavior: const ScrollBehavior().copyWith(
              physics: const BouncingScrollPhysics(),
            ),
            builder: BotToastInit(),
          );
        },
      ),
    );
  }
}

class ProviderLog extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    Logger.i('''
{
  "PROVIDER": "${provider.name}; ${provider.runtimeType.toString()}"
  
}''');
    log("$newValue");
  }
}

import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'common/routes/routes.dart';
import 'common/utils/FirebaseMassagingHandler.dart';
import 'common/utils/app_style.dart';
import 'global.dart';

Future<void> main() async {
  // Initialize global configurations
  await Global.init();

  // Initialize Firebase and setup notification channels
  await firebaseInit();

  // Run the app
  runApp(const ProviderScope(child: MyApp()));
}

Future firebaseInit() async {
  FirebaseMessaging.onBackgroundMessage(
    FirebaseMassagingHandler.firebaseMessagingBackground,
  );
  if (Platform.isAndroid) {
    FirebaseMassagingHandler.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()!
        .createNotificationChannel(FirebaseMassagingHandler.channel_message);
  }
}


final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

// Define the app widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        navigatorKey: navKey,  // Use global navigator key
        scaffoldMessengerKey: Global.rootScaffoldMessengerKey,  // Use global scaffold messenger key
        title: 'Flutter Demo',
        theme: AppTheme.appThemeData,
        onGenerateRoute: AppPages.generateRouteSettings,  // Route generation
      ),
    );
  }
}

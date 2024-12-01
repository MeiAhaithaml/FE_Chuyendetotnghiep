import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:study_app/common/utils/topSnackBar.dart';
import 'common/services/storage.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';



class Global{
  static late StorageService storageService;
  static GlobalKey<TopSnackbarState> TopSnakbarKey = GlobalKey<TopSnackbarState>();
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();
  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      name: 'SaMLearning',
       options: DefaultFirebaseOptions.currentPlatform,
    );
    storageService = await StorageService().init();
  }
  static TransitionBuilder MaterialAppBuilder({
    TransitionBuilder? builder,
  }) {
    return (BuildContext context, Widget? child) {
      if (builder != null) {
        return builder(
            context,
            Overlay(initialEntries: [
              OverlayEntry(builder: (BuildContext context) {
                return FlutterEasyLoading(key:GlobalKey(),child: child);
              }),
              OverlayEntry(builder: (BuildContext context) {
                return TopSnackbar(key:GlobalKey());
              })
            ]));
      } else {
        return Overlay(initialEntries: [
          OverlayEntry(builder: (BuildContext context) {
            return FlutterEasyLoading(key:GlobalKey(),child: child);
          }),
          OverlayEntry(builder: (BuildContext context) {
            return TopSnackbar(key:TopSnakbarKey);
          })
        ]);
      }
    };
  }
  static void setSystemUi() {
    if (Platform.isAndroid) {
      SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarDividerColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}







import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ekub/views/screens/splash_screen.dart';
import 'package:ekub/routes.dart';
import 'package:ekub/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

    try {
      await Firebase.initializeApp();
      print('Firebase initialized successfully!');
    } catch (e) {
      print('Failed to initialize Firebase: $e');
    }

  ErrorWidget.builder = (details) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
            fontFamily: 'Montserrat',
            scaffoldBackgroundColor: Colors.white,
          ),
        );
      },
    );
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            fontFamily: 'Montserrat',
            scaffoldBackgroundColor: Colors.white,
          ),
          initialRoute: SplashScreen.route,
          routes: getRoutes(),
        );
      },
    );
  }
}

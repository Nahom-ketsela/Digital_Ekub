import 'package:ekub/views/auth/login_page.dart';
import 'package:ekub/views/auth/register_page.dart';
import 'package:ekub/views/pages/donate_page.dart';
import 'package:ekub/views/pages/ekub_page.dart';
import 'package:ekub/views/pages/lostpeople_page.dart';
import 'package:ekub/views/pages/profile_page.dart';
import 'package:ekub/views/pages/setting_page.dart';
import 'package:ekub/views/screens/main_screen.dart';
import 'package:ekub/views/screens/onboarding_screen.dart';
import 'package:ekub/views/screens/splash_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    SplashScreen.route: (context) => SplashScreen(),
    MainScreen.route: (context) => MainScreen(),
    LoginPage.route: (context) => LoginPage(),
    SignupPage.route: (context) => SignupPage(),
    EkubPage.route: (context) => EkubPage(),
    DonatePage.route: (context) => DonatePage(),
    LostPeoplePage.route: (context) => LostPeoplePage(),
    SettingsPage.route: (context) => SettingsPage(),
    ProfilePage.route: (context) => ProfilePage(),
    OnboardingScreen.route: (context) => OnboardingScreen(),
  };
}

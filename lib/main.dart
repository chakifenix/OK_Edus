import 'package:flutter/material.dart';

import 'package:ok_edus/core/api/api-call.dart';
import 'package:ok_edus/features/login-page/view/login-page-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/main-bar-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/profile-screen.dart';
import 'package:ok_edus/features/onboarding-page/view/onboarding-screen.dart';
import 'package:ok_edus/features/splash-page/view/splash-screen.dart';
import 'package:ok_edus/preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/main-bar-page/view/main-screen.dart';

int? initScreen;
bool? isLogged;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = await preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  isLogged = preferences.getBool('isLogged') ?? false;
  // PreferenceTest.sharedPref();
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: initScreen == 0 || initScreen == null ? 'onboard' : 'home',
      routes: {
        'home': (context) => (!isLogged!) ? LoginPageScreen() : MainBarScreen(),
        'onboard': (context) => OnboardingScreen()
      },
      // home: Container(
      //     decoration: BoxDecoration(
      //         gradient: LinearGradient(
      //       begin: Alignment(0.74, -0.67),
      //       end: Alignment(-0.74, 0.67),
      //       colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
      //     )),
      //     child: OnboardingScreen()));
      // Login();
    );
  }
}

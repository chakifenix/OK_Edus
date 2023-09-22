import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ok_edus/features/login-page/view/login-page-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/main-bar-screen.dart';
import 'package:ok_edus/features/onboarding-page/view/onboarding-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? initScreen;
bool? isLogged;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  isLogged = preferences.getBool('isLogged') ?? false;
  // PreferenceTest.sharedPref();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ru')],
      fallbackLocale: const Locale('en'),
      path: 'translations',
      child: const MainPage()));
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: initScreen == 0 || initScreen == null ? 'onboard' : 'home',
      routes: {
        'home': (context) =>
            (!isLogged!) ? LoginPageScreen() : const MainBarScreen(),
        'onboard': (context) => const OnboardingScreen()
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

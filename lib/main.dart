import 'package:flutter/material.dart';

import 'package:ok_edus/core/api/api-call.dart';
import 'package:ok_edus/features/login-page/view/login-page-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/main-bar-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/profile-screen.dart';
import 'package:ok_edus/features/onboarding-page/view/onboarding-screen.dart';
import 'package:ok_edus/features/splash-page/view/splash-screen.dart';

import 'features/main-bar-page/view/main-screen.dart';

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment(0.74, -0.67),
              end: Alignment(-0.74, 0.67),
              colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
            )),
            child: MainBarScreen()));
    // Login();
  }
}

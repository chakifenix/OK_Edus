import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ok_edus/features/login-page/view/login-page-screen.dart';
import 'package:ok_edus/features/onboarding-page/view/onboarding-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkFirstLaunch();
  }

  void checkFirstLaunch() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool isFirstLaunch = preferences.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      print(isFirstLaunch);
      Future.delayed(Duration(seconds: 3)).then((value) {
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (context) => OnboardingScreen()));
      });
      preferences.setBool('isFirstLaunch', false);
    } else {
      Future.delayed(Duration(seconds: 3)).then((value) {
        Navigator.of(context).pushReplacement(
            CupertinoPageRoute(builder: (context) => LoginPageScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 390;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment(0.74, -0.67),
        end: Alignment(-0.74, 0.67),
        colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
      )),
      child: Stack(
        children: [
          Positioned(
              left: -27,
              top: 126.39,
              child: Align(
                child: SizedBox(
                  width: 152.84 * fem,
                  height: 152.84 * fem,
                  child: Image.asset(
                      'images/elements-geometric-shape-abstract-oval-sharp-xxw.png'),
                ),
              )),
          Positioned(
              left: 107.9046173096 * fem,
              top: -50,
              child: Align(
                child: SizedBox(
                  width: 152.84 * fem,
                  height: 152.84 * fem,
                  child: Image.asset(
                      'images/elements-geometric-shape-flower-1-nature-5Yb.png'),
                ),
              )),
          Positioned(
              left: 231.6908454895 * fem,
              top: 303.9845504761 * fem,
              child: Align(
                child: SizedBox(
                  width: 152.84 * fem,
                  height: 152.84 * fem,
                  child: Image.asset(
                      'images/elements-geometric-shape-star-flower-EoH.png'),
                ),
              )),
          Positioned(
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      22.5 * fem, 18.02 * fem, 23.5 * fem, 15.56 * fem),
                  width: 150 * fem,
                  height: 150 * fem,
                  decoration: BoxDecoration(
                    color: Color(0xffffb52d),
                    borderRadius: BorderRadius.circular(30 * fem),
                  ),
                  child: Center(
                      child: SizedBox(
                    width: 104 * fem,
                    height: 116.42 * fem,
                    child: Image.asset('images/image-1.png'),
                  )),
                ),
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  'images/logo.png',
                  width: 152.84 * fem,
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}

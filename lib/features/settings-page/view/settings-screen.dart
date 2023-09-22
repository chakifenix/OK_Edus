import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ok_edus/features/change-password-page/view/change-password-screen.dart';
import 'package:ok_edus/features/login-page/view/login-page-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/main-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/profile-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../language-page/view/language-screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isSwitched = false;
  bool? isLogged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, context.locale);
          },
          color: Colors.black,
        ),
        title: Text(
          'settings'.tr(),
          style: TextStyle(
            color: Color(0xFF424242),
            fontSize: 20,
            fontFamily: 'SF Pro Display',
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 24,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23, right: 23),
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16, left: 16, bottom: 21),
                    //width: 100,
                    //height: 100,
                    // color: Colors.red,
                    child: Text('news'.tr()),
                  ),
                  Container(
                      // color: Colors.green,
                      child: Switch(
                    value: isSwitched,
                    onChanged: ((value) {
                      setState(() {
                        isSwitched = value;
                      });
                    }),
                  ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23, right: 23),
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16, left: 16, bottom: 21),
                    //width: 100,
                    //height: 100,
                    // color: Colors.red,
                    child: Text('sms'.tr()),
                  ),
                  Container(
                      // color: Colors.green,
                      child: Switch(
                    value: isSwitched,
                    onChanged: ((value) {
                      setState(() {
                        isSwitched = value;
                      });
                    }),
                  ))
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23, right: 23),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LanguageScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 16, left: 16, bottom: 21),
                      //width: 100,
                      //height: 100,
                      // color: Colors.red,
                      child: Text('change-lang'.tr()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 16,
                      ),
                      child: RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.grey,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23, right: 23),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChangePasswordScreen()));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 16, left: 16, bottom: 21),
                      //width: 100,
                      //height: 100,
                      // color: Colors.red,
                      child: Text('change-pass'.tr()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 16,
                      ),
                      child: RotatedBox(
                          quarterTurns: 2,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.grey,
                          )),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23, right: 23),
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16, left: 16, bottom: 21),
                    //width: 100,
                    //height: 100,
                    // color: Colors.red,
                    child: Text('faq'.tr()),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 23, right: 23),
            child: Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final url = 'https://support.edus.kz/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 16, left: 16, bottom: 21),
                      //width: 100,
                      //height: 100,
                      // color: Colors.red,
                      child: Text('support'.tr()),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  isLogged = prefs.getBool('isLogged');
                  await prefs.setBool('isLogged', false);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => LoginPageScreen()),
                      (route) => false);
                },
                child: Text('out'.tr()),
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 40)),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.red,
                    ))),
          ),
        ],
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('data'),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.setString('myLang', 'kk');
              setState(() {
                context.setLocale(Locale('en'));
                Navigator.pop(context);
              });
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
                    child: Text('Казакша'),
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
          GestureDetector(
            onTap: () async {
              SharedPreferences preferences =
                  await SharedPreferences.getInstance();
              await preferences.setString('myLang', 'ru');
              setState(() {
                context.setLocale(Locale('ru'));
                Navigator.pop(context);
              });
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
                    child: Text('Русcкий'),
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
        ],
      ),
    );
  }
}

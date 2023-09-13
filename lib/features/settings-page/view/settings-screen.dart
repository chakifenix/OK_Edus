import 'package:flutter/material.dart';
import 'package:ok_edus/features/login-page/view/login-page-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        leading: BackButton(color: Colors.black),
        title: Text(
          'Баптаулар',
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
                    child: Text('Push хабарламасы'),
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
                    child: Text('SMS хабарламасы'),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16, left: 16, bottom: 21),
                    //width: 100,
                    //height: 100,
                    // color: Colors.red,
                    child: Text('Тілді өзгерту'),
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 16, left: 16, bottom: 21),
                    //width: 100,
                    //height: 100,
                    // color: Colors.red,
                    child: Text('Құпиясөзді өзгерту'),
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
                    child: Text('Жиі қойылатын сұрақтар'),
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
                  Container(
                    padding: EdgeInsets.only(top: 16, left: 16, bottom: 21),
                    //width: 100,
                    //height: 100,
                    // color: Colors.red,
                    child: Text('Техникалық қолдау'),
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
                child: Text('Шығу'),
                style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 40)),
                    backgroundColor: MaterialStateProperty.all(
                      Colors.red,
                    ))),
          )
        ],
      ),
    );
  }
}

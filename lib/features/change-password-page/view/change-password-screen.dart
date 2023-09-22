import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ok_edus/core/api/Networking.dart';

import '../../../gradiend.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  var oldPassword = TextEditingController();
  var newPassword = TextEditingController();

  Future<void> changePassword(String oldPassword, String newPassword) async {
    var scopedToken = await SubjectsService.getToken();
    String lang = await SubjectsService.getLang();
    try {
      final response = await SubjectsService.fetchPasswordChangePost(
          oldPassword, newPassword);
      var data = jsonDecode(response.toString());

      if (response.statusCode == 200) {
        print(response.data);
      } else {}
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          //Text('data');
          print('Request failed with status code: ${e.response!.statusCode}');
        }
        throw e;
      }
    }
  }

  var passwordController = TextEditingController();
  int classN = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (classN >= 5 && classN <= 9)
          ? MyTheme.teenColor()
          : (classN >= 1 && classN <= 4)
              ? MyTheme.kidsColor()
              : MyTheme.adultColor(),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(color: Colors.blue),
          title: Text(
            'Изменить пароль',
            style: TextStyle(
              color: Color(0xFF1F2024),
              fontSize: 20,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500,
              height: 0,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        //resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 320,
                height: 50,
                padding: const EdgeInsets.only(left: 6, right: 6),
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: oldPassword,
                  decoration: InputDecoration(
                      border: InputBorder.none, labelText: 'старый пароль'),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 320,
                height: 50,
                padding: const EdgeInsets.only(left: 6, right: 6),
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: newPassword,
                  decoration: InputDecoration(
                      border: InputBorder.none, labelText: 'новый пароль'),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    try {
                      await changePassword(oldPassword.text, newPassword.text);
                      final snackBar = SnackBar(
                        content: const Text('password changed'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      Navigator.pop(context);
                    } catch (e) {
                      final snackBar = SnackBar(
                        content: const Text('Incorrect password'),
                        action: SnackBarAction(
                          label: 'Undo',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: Text('изменить'))
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'package:http/http.dart';

import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/core/api/login_service.dart';
import 'package:ok_edus/features/main-bar-page/view/main-bar-screen.dart';
import 'package:ok_edus/main.dart';
import 'package:ok_edus/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageScreen extends StatefulWidget {
  LoginPageScreen({super.key});

  @override
  State<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends State<LoginPageScreen> {
  String? token;
  bool? isLogged;
  @override
  final _login = LoginService();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  Future<Map<String, dynamic>> login(String a, String b) async {
    Dio dio = Dio();
    Response response;
    try {
      response = await dio.post(
        'https://mobile.mektep.edu.kz/api_ok_edus/public/api/ru/login',
        data: {'login': a, 'password': b},
      );

      Map<String, dynamic> responseData = response.data;
      token = responseData['access_token'];
      await SubjectsService.storeToken(token!);
      return responseData; // Возвращаем JSON-данные вместо response
    } catch (e) {
      if (e is DioError) {
        if (e.response != null) {
          //Text('data');
          print('Request failed with status code: ${e.response!.statusCode}');
        }
      }
      throw e; // Пробрасываем ошибку дальше
    }
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment(0.74, -0.67),
        end: Alignment(-0.74, 0.67),
        colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
      )),
      child: Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(
                left: 5,
                top: 141.39,
                child: Align(
                  child: SizedBox(
                    width: 152.84,
                    height: 152.84,
                    child: SvgPicture.asset(
                        'images/Elements-geometric-shape-abstract-oval-sharp.svg'),
                  ),
                )),
            Positioned(
                left: 107.9046173096,
                top: -40,
                child: Align(
                  child: SizedBox(
                    width: 152.84,
                    height: 152.84,
                    child: SvgPicture.asset(
                        'images/Elements-geometric-shape-flower-1-nature.svg'),
                  ),
                )),
            Positioned(
                left: 236.6908454895,
                top: 313.9845504761,
                child: Align(
                  child: SizedBox(
                    width: 152.84,
                    height: 152.84,
                    child: SvgPicture.asset(
                        'images/Elements-geometric-shape-star-flower.svg'),
                  ),
                )),
            Positioned(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Оқушының кабинеті',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(
                    height: 27,
                  ),
                  const SizedBox(
                    width: 309,
                    child: Text(
                      'Логиніңізді мұғалімнен сұрау арқылы немесе ата-ана кабинетінен қарап біле аласыздар!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                  const SizedBox(
                    height: 76,
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
                      controller: emailController,
                      decoration: InputDecoration(
                          border: InputBorder.none, labelText: 'Логин'),
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
                      controller: passwordController,
                      decoration: InputDecoration(
                          border: InputBorder.none, labelText: 'Пароль'),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        // var user = _login.login(
                        //     emailController.text, passwordController.text);
                        //
                        // print(user!.token);
                        try {
                          await login(
                              emailController.text, passwordController.text);
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          isLogged = prefs.getBool('isLogged');
                          await prefs.setBool('isLogged', true);
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => MainBarScreen()),
                              (route) => false);

                          //print(token);

                          print(emailController.text);
                        } catch (e) {
                          final snackBar = SnackBar(
                            content: const Text('Incorrect user or password!'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        // final connectivityResult =
                        //     await Connectivity().checkConnectivity();
                        //     if(connectivityResult==connectivityResult.mobile)
                      },
                      child: Text('Login'))
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ok_edus/core/api/Networking.dart';

class ApiCall1 extends StatefulWidget {
  @override
  State<ApiCall1> createState() => _ApiCall1State();
}

class _ApiCall1State extends State<ApiCall1> {
  var jsonList;
  @override
  void initState() {
    fetchApi();
    super.initState();
  }

  int day = 0;
  bool click = true;
  int uzilis1 = 0;

  void fetchApi() async {
    var scopedToken = await SubjectsService.getToken();
    Dio dio = Dio();
    var response = await dio.get(
        'https://mobile.mektep.edu.kz/api_ok_edus/public/api/ru/schedule',
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $scopedToken',
        }));

    // print(response);
    if (response.statusCode == 200) {
      setState(() {
        jsonList = response.data['schedule'] as List;
      });
    } else {
      print(response.statusCode);
    }
    //print(jsonList[4]['lessons'].length);
    // var a = response.data;
    // print(a.runtimeType);
    // return response.data;
  }

  @override
  Widget build(BuildContext context) {
    //print(jsonList.length);
    //print(jsonList.length);
    // TODO: implement build
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment(0.74, -0.67),
          end: Alignment(-0.74, 0.67),
          colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
        )),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  calendar(0, 'ДС'),
                  calendar(1, 'СС'),
                  calendar(2, 'СР'),
                  calendar(3, 'БС'),
                  calendar(4, 'ЖМ'),
                  // Container(
                  //   height: 36,
                  //   width: 40,
                  //   decoration: BoxDecoration(
                  //       color: Color(0xFFF7F8FD),
                  //       borderRadius: BorderRadius.circular(16)),
                  // ),
                  // Container(
                  //   height: 36,
                  //   width: 40,
                  //   decoration: BoxDecoration(
                  //       color: Color(0xFFF7F8FD),
                  //       borderRadius: BorderRadius.circular(16)),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount:
                      jsonList == null ? 0 : jsonList[day]['lessons'].length,
                  itemBuilder: (context, index) {
                    return ListOfLessons(
                      lessonName: jsonList[day]['lessons'][index]
                          ['predmet_name'],
                      teacherName: jsonList[day]['lessons'][index]
                          ['teacher_name'],
                      teacherSurname: jsonList[day]['lessons'][index]
                          ['teacher_surname'],
                      startLesson: jsonList[day]['lessons'][index]
                          ['start_time'],
                      endLesson: jsonList[day]['lessons'][index]['end_time'],
                      numOfLesson: index,
                      uzilis: index,
                    );
                  }),
            ),
          ],
        ));
  }

  GestureDetector calendar(int day, String nameDay) {
    return GestureDetector(
      onTap: () {
        setState(() {
          fetchApi();
          this.day = day;
        });
        print('pressed');
        print(day);
      },
      child: Container(
        child: Center(
          child: Text(
            nameDay,
          ),
        ),
        height: 36,
        width: 40,
        decoration: BoxDecoration(
            color: (this.day == day) ? Colors.blue : Color(0xFFF7F8FD),
            borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class ListOfLessons extends StatelessWidget {
  String lessonName;
  String teacherName;
  String teacherSurname;
  String startLesson;
  String endLesson;
  int numOfLesson;
  int uzilis;

  ListOfLessons(
      {required this.lessonName,
      required this.teacherName,
      required this.teacherSurname,
      required this.startLesson,
      required this.endLesson,
      required this.numOfLesson,
      required this.uzilis});

  @override
  Widget build(BuildContext context) {
    var sum = numOfLesson + 1;
    var uzilis1 = (numOfLesson + 1) ~/ 2;
    uzilis1.toInt;
    return (sum == 2 || sum == 4)
        ? Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        '$sum сабак',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontSize: 16,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Expanded(
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFF9F9F9),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(8),
                          //width: 270,

                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      lessonName,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF1E1E1E),
                                        fontSize: 16,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    startLesson,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF7A7A7A),
                                      fontSize: 12,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$teacherSurname $teacherName',
                                    style: TextStyle(
                                      color: Color(0xFF7A7A7A),
                                      fontSize: 12,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    '$endLesson',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF7A7A7A),
                                      fontSize: 12,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(0xFFF9F9F9),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text('$uzilis1'),
                    ),
                  ),
                )
              ],
            ),
          )
        : Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    '$sum сабак',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  width: 11,
                ),
                Expanded(
                  child: Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(8),
                      //width: 270,

                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  lessonName,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF1E1E1E),
                                    fontSize: 16,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Text(
                                startLesson,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF7A7A7A),
                                  fontSize: 12,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$teacherSurname $teacherName',
                                style: TextStyle(
                                  color: Color(0xFF7A7A7A),
                                  fontSize: 12,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '$endLesson',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF7A7A7A),
                                  fontSize: 12,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            ),
          );
  }
}

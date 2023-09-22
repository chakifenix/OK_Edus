import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:intl/intl.dart';
import 'package:ok_edus/gradiend.dart';

class ApiCall extends StatefulWidget {
  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  var jsonList;
  int classN = 0;
  @override
  void initState() {
    dayName();
    fetchApi();
    getClass();
    super.initState();
  }

  DateTime today1 = DateTime.now();

  int? day;
  bool click = true;
  int uzilis1 = 0;

  void fetchApi() async {
    var scopedToken = await SubjectsService.getToken();
    String lang = await SubjectsService.getLang();
    Dio dio = Dio();
    var response = await dio.get(
        'https://mobile.mektep.edu.kz/api_ok_edus/public/api/${lang}/schedule',
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

  void dayName() {
    String formattedDate = DateFormat('dd.MM.yyyy').format(today1);
    print(formattedDate);
    //print('${today.hour}, ${today.minute}');
    var dayOfWeek = DateFormat('EEEE').format(today1);
    print(dayOfWeek);
    if (dayOfWeek == 'понедельник') {
      day = 0;
    } else if (dayOfWeek == 'вторник') {
      day = 1;
    } else if (dayOfWeek == 'среда') {
      day = 2;
    } else if (dayOfWeek == 'четверг') {
      day = 3;
    } else if (dayOfWeek == 'пятница') {
      day = 4;
    }
  }

  void getClass() async {
    var str = await SubjectsService.getClass();
    classN = int.parse(str!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
//print(jsonList.length);
    //print(jsonList.length);
    // TODO: implement build
    return Container(
        decoration: (classN >= 5 && classN <= 9)
            ? MyTheme.teenColor()
            : (classN >= 1 && classN <= 4)
                ? MyTheme.kidsColor()
                : MyTheme.adultColor(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  calendar(0, 'MN'.tr()),
                  calendar(1, 'TS'.tr()),
                  calendar(2, 'WD'.tr()),
                  calendar(3, 'TH'.tr()),
                  calendar(4, 'FR'.tr()),
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
              child: (day != null)
                  ? ListView.builder(
                      itemCount: jsonList == null
                          ? 0
                          : jsonList[day]['lessons'].length,
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
                          endLesson: jsonList[day]['lessons'][index]
                              ['end_time'],
                          numOfLesson: index,
                          uzilis: index,
                          classN: classN,
                        );
                      })
                  : Container(
                      child: Center(
                        child: Text("Демалыс"),
                      ),
                    ),
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
            //color: (this.day == day) ? (Colors.blue) : Color(0xFFF7F8FD),
            borderRadius: BorderRadius.circular(16),
            gradient: (this.day == day)
                ? ((classN >= 5 && classN <= 9)
                    ? LinearGradient(
                        begin: Alignment(0.74, -0.67),
                        end: Alignment(-0.74, 0.67),
                        colors: [Color(0xFF60B0F5), Color(0xFF1572C3)],
                      )
                    : (classN >= 1 && classN <= 4)
                        ? LinearGradient(
                            begin: Alignment(0.74, -0.67),
                            end: Alignment(-0.74, 0.67),
                            colors: [Color(0xFFFAEC2F), Color(0xFFEFA612)],
                          )
                        : LinearGradient(
                            begin: Alignment(0.74, -0.67),
                            end: Alignment(-0.74, 0.67),
                            colors: [Color(0xFFFAEC2F), Color(0xFFEFA612)],
                          ))
                : LinearGradient(
                    begin: Alignment(0.74, -0.67),
                    end: Alignment(-0.74, 0.67),
                    colors: [Colors.white, Colors.white],
                  )),
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
  int classN;

  ListOfLessons(
      {required this.lessonName,
      required this.teacherName,
      required this.teacherSurname,
      required this.startLesson,
      required this.endLesson,
      required this.numOfLesson,
      required this.uzilis,
      required this.classN});

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
                      child: Row(
                        children: [
                          Text('$sum ',
                              textAlign: TextAlign.center,
                              style: (classN >= 5 && classN <= 9)
                                  ? TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                    )
                                  : (classN >= 1 && classN <= 4)
                                      ? TextStyle(
                                          color: Color(0xFF1E1E1E),
                                          fontSize: 16,
                                          fontFamily: 'SF Pro Display',
                                          fontWeight: FontWeight.w400,
                                        )
                                      : TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'SF Pro Display',
                                          fontWeight: FontWeight.w400,
                                        )),
                          Text('lesson',
                                  textAlign: TextAlign.center,
                                  style: (classN >= 5 && classN <= 9)
                                      ? TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'SF Pro Display',
                                          fontWeight: FontWeight.w400,
                                        )
                                      : (classN >= 1 && classN <= 4)
                                          ? TextStyle(
                                              color: Color(0xFF1E1E1E),
                                              fontSize: 16,
                                              fontFamily: 'SF Pro Display',
                                              fontWeight: FontWeight.w400,
                                            )
                                          : TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontFamily: 'SF Pro Display',
                                              fontWeight: FontWeight.w400,
                                            ))
                              .tr(),
                        ],
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('$uzilis1'),
                          Text('timeout').tr(),
                        ],
                      ),
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
                  child: Row(
                    children: [
                      Text('$sum ',
                          textAlign: TextAlign.center,
                          style: (classN >= 5 && classN <= 9)
                              ? TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                )
                              : (classN >= 1 && classN <= 4)
                                  ? TextStyle(
                                      color: Color(0xFF1E1E1E),
                                      fontSize: 16,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                    )
                                  : TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                    )),
                      Text('lesson',
                              textAlign: TextAlign.center,
                              style: (classN >= 5 && classN <= 9)
                                  ? TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w400,
                                    )
                                  : (classN >= 1 && classN <= 4)
                                      ? TextStyle(
                                          color: Color(0xFF1E1E1E),
                                          fontSize: 16,
                                          fontFamily: 'SF Pro Display',
                                          fontWeight: FontWeight.w400,
                                        )
                                      : TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'SF Pro Display',
                                          fontWeight: FontWeight.w400,
                                        ))
                          .tr(),
                    ],
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

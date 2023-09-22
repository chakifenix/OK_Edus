import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/features/notification-page/view/notification-screen.dart';
import 'package:ok_edus/model/gpage-homework-model.dart';
import 'package:ok_edus/model/main-page-model.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int classN = 0;
  var currentIndex;
  var currentTime1;
  var timeStart;
  var timeEnd;
  var myTimeMin;
  var name;
  MainPageModel? glavnyiPage;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    getStorageInfo();
  }

  void getStorageInfo() async {
    var str = await SubjectsService.getClass();
    name = await SubjectsService.getName();
    classN = int.parse(str!);
    print(classN);
    print(name);
    setState(() {});
  }

  Future<Map<String, dynamic>> fetchApi() async {
    var scopedToken = await SubjectsService.getToken();
    String lang = await SubjectsService.getLang();
    var response = await SubjectsService.fetchSubjects(
        '${lang}/main-page', '$scopedToken');
    var data = jsonDecode(response.toString());
    print(lang);
    print(data);
    if (response.statusCode == 200) {
      glavnyiPage = MainPageModel.fromJson(data);
      // Intl.defaultLocale = 'ru';
      // final dateTime = '16 августа 2023 15:34';
      // final inputFormat = DateFormat('dd MMMM y HH:mm', 'ru');
      // print(inputFormat.parse(toString()));
      return response.data;
    } else {
      throw Exception('Failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: fetchApi(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            var jsonListDiyary = snapshot.data!['diary'] as List<dynamic>;

            DateTime currenTime = DateTime.now();

            // print(jsonListDiyary[0]['predmet_name']);
            if (jsonListDiyary.length > 0) {
              for (int i = 0; i < jsonListDiyary.length; i++) {
                currentTime1 = TimeOfDay.fromDateTime(currenTime);
                timeStart = TimeOfDay.fromDateTime(
                    DateTime.parse(jsonListDiyary[i]['start_time']));
                timeEnd = TimeOfDay.fromDateTime(
                    DateTime.parse(jsonListDiyary[i]['end_time']));
                if ((currentTime1.hour > timeStart.hour ||
                        (currenTime.hour == timeStart.hour &&
                            currenTime.minute >= timeStart.minute)) &&
                    (currenTime.hour < timeEnd.hour ||
                        (currenTime.hour == timeEnd.hour &&
                            currenTime.minute <= timeEnd.minute))) {
                  currentIndex = i;
                  //print(jsonListDiyary[i]['predmet_name']);
                  break;
                } else {
                  currentIndex = null;
                }

                // print(timeStart);
                // print(currenTime.minute);
              }
              print(currentIndex);
              double _doubleYourTime =
                  timeEnd.hour.toDouble() + (timeEnd.minute.toDouble() / 60);
              double _doubleNowTime = currentTime1.hour.toDouble() +
                  (currentTime1.minute.toDouble() / 60);

              double myTime = _doubleYourTime - _doubleNowTime;
              //double _hr = myTime.truncate();
              myTimeMin = (myTime - myTime.truncate()) * 60;

              print('${myTimeMin}');
            }
            DateTime today = DateTime.now();
            String formattedDate = DateFormat('dd.MM.yyyy').format(today);
            print(formattedDate);
            //print('${today.hour}, ${today.minute}');
            var dayOfWeek = DateFormat('EEEE').format(today);
            print(dayOfWeek);
            //print(currentIndex);
            //String dateStr = '${today.day}.${today.month}.${today.year}';
            if (dayOfWeek == 'понедельник') {
              dayOfWeek = 'monday'.tr();
            } else if (dayOfWeek == 'вторник') {
              dayOfWeek = 'tuesday'.tr();
            } else if (dayOfWeek == 'среда') {
              dayOfWeek = 'wednesday'.tr();
            } else if (dayOfWeek == 'четверг') {
              dayOfWeek = 'thursday'.tr();
            } else if (dayOfWeek == 'пятница') {
              dayOfWeek = 'friday'.tr();
            } else if (dayOfWeek == 'суббота') {
              dayOfWeek = 'saturday'.tr();
            } else {
              dayOfWeek = 'sunday'.tr();
            }
            return MainPageView(dayOfWeek, jsonListDiyary);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  double iconSize = 24.0;
  final tabs = [];

  Scaffold MainPageView(String dayOfWeek, List<dynamic> jsonListDiyary) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.blue,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NotificationScreen()));
              // Действия при нажатии на кнопку
            },
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
        flexibleSpace: Container(decoration: const BoxDecoration()),
        title: Text(
          'main-page',
          style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontSize: 20,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500),
        ).tr(),
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            // height: 78,

            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 14, top: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: 60,
                      height: 60,
                      child: Image.asset('images/girl.png')),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${'welcome'.tr()} ${name}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        '${'ulgerim'.tr()} - 4,5',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: 150),
              children: [
                Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 8),
                        child: Container(
                          // color: Colors.white,
                          height: 44,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'subject_now',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: (classN >= 5 && classN <= 9)
                                    ? Colors.white
                                    : (classN >= 1 && classN <= 4)
                                        ? Color(0xFF1E1E1E)
                                        : Colors.white,
                                fontSize: 20,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ).tr(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      (currentIndex != null)
                          ? Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  LinearProgressIndicator(
                                    value: (39.999999999999964 - myTimeMin) /
                                        39.999999999999964,
                                    minHeight: 90,
                                    valueColor: AlwaysStoppedAnimation(
                                        Color(0xFFFFC107)),
                                    borderRadius: BorderRadius.circular(10),
                                    backgroundColor: Color(0x4CFFC107),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      //color: Colors.white,
                                    ),

                                    //height: 85,
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${jsonListDiyary[currentIndex]['predmet_name']}',
                                                  textAlign: TextAlign.start,
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                    'Мұғалім: ${jsonListDiyary[currentIndex]['teacher_name']} ${jsonListDiyary[currentIndex]['teacher_surname']}')
                                              ],
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Аяқталуы',
                                                textAlign: TextAlign.start,
                                              ),
                                              SizedBox(
                                                height: 12,
                                              ),
                                              Text(
                                                  '${timeEnd.hour}:${timeEnd.minute}'),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 11,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Container(
                          // color: Colors.white,
                          height: 44,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'school-activity',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: (classN >= 5 && classN <= 9)
                                    ? Colors.white
                                    : (classN >= 1 && classN <= 4)
                                        ? Color(0xFF1E1E1E)
                                        : Colors.white,
                                fontSize: 20,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ).tr(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: 290,
                          //color: Colors.white,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: glavnyiPage!.newsList.length,
                              itemBuilder: (context, index) {
                                print(glavnyiPage!.newsList[0].date);
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, top: 10, bottom: 11),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    width: 320,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            AspectRatio(
                                              aspectRatio: 2 / 1,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: Colors.white,
                                                ),
                                                child: Image.network(
                                                    glavnyiPage!.newsList[index]
                                                        .imageUrl),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              //color: Colors.white,
                                              child: Text(
                                                glavnyiPage!
                                                    .newsList[index].title,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 16,
                                                  fontFamily: 'SF Pro Display',
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  //color: Colors.white,
                                                  child: Time(
                                                      time: glavnyiPage!
                                                          .newsList[index]
                                                          .date),
                                                  //
                                                ),
                                                Container(
                                                  //color: Colors.white,
                                                  child: Text(
                                                    'staff',
                                                    style: TextStyle(
                                                      color: Color(0xFF7A7A7A),
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'SF Pro Display',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ).tr(),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              //color: Colors.white,
                                              child: Text('more').tr(),
                                            ),
                                          ]),
                                    ),
                                  ),
                                );
                              })),
                      // Container(
                      //     height: 290,
                      //     color: Colors.white,
                      //     child: ListView.builder(
                      //       scrollDirection: Axis.horizontal,
                      //       itemCount: 7,
                      //       itemBuilder: (context, index) {
                      //         return MyNews();
                      //       },
                      //     )),
                      SizedBox(
                        height: 11,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 21, right: 21),
                        child: Container(
                          //color: Colors.white,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'homework',
                              style: TextStyle(
                                color: (classN >= 5 && classN <= 9)
                                    ? Colors.white
                                    : (classN >= 1 && classN <= 4)
                                        ? Color(0xFF1E1E1E)
                                        : Colors.white,
                                fontSize: 20,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ).tr(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Container(
                          //color: Colors.white,
                          height:
                              MediaQuery.of(context).size.width / 2.6 / 1.15,
                          alignment: Alignment.centerLeft,
                          child: HomeWork()),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       setState(() {
                      //         if (context.locale.languageCode == 'en') {
                      //           context.setLocale(Locale('ru'));
                      //         } else {
                      //           context.setLocale(Locale('en'));
                      //         }
                      //       });
                      //     },
                      //     child: Text('Press'))
                    ]),
              ],
            ),
          ),
        ],
      ),
      //bottomNavigationBar: bottomNav(),
    );
  }
}

class Time extends StatelessWidget {
  var time;

  Time({required this.time});

  String? date(String inputDate) {
    final Map<String, String> monthMap = {
      'қаңтар': '01',
      'ақпан': '02',
      'наурыз': '03',
      'сәуір': '04',
      'мамыр': '05',
      'маусым': '06',
      'шілде': '07',
      'тамыз': '08',
      'қыркүйек': '09',
      'қазан': '10',
      'қараша': '11',
      'желтоқсан': '12',
    };
    final dateParts = inputDate.split(' ');
    print(dateParts);
    if (dateParts.length == 4) {
      final day = dateParts[0];
      final month = monthMap[dateParts[1].toLowerCase()] ?? '';
      print(month);
      final year = dateParts[2];
      final time = dateParts[3];

      if (day.isNotEmpty && month.isNotEmpty && year.isNotEmpty) {
        return '$day.$month.$year $time';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final List prefix = [
      "now".tr(),
      "second".tr(),
      "minute".tr(),
      "hours".tr(),
      "day-ago".tr(),
      "month-ago".tr(),
      "year-ago".tr()
    ];
    final dateTimeString = time;
    try {
      print(dateTimeString);
      final parsedDateTime = parseDateTime1(dateTimeString);
      Duration diffirance = DateTime.now().difference(parsedDateTime);
      var timeAgo;
      print(diffirance);
      if (diffirance.inDays == 0) {
        if (diffirance.inMinutes == 0) {
          if (diffirance.inSeconds < 20) {
            timeAgo = prefix[0];
          } else {
            timeAgo = "${diffirance.inSeconds} ${prefix[1]}";
          }
        } else {
          if (diffirance.inMinutes > 59) {
            timeAgo = "${(diffirance.inMinutes / 60).floor()} ${prefix[3]}";
          } else {
            timeAgo = "${diffirance.inMinutes} ${prefix[2]}";
          }
        }
      } else {
        if (diffirance.inDays > 30) {
          if (((diffirance.inDays) / 30).floor() > 12) {
            timeAgo = "${((diffirance.inDays / 30) / 12).floor()} ${prefix[6]}";
          } else {
            timeAgo = "${(diffirance.inDays / 30).floor()} ${prefix[5]}";
          }
        } else {
          timeAgo = "${diffirance.inDays} ${prefix[4]}";
        }
      }
      return Text(
        timeAgo,
        style: TextStyle(
          color: Color(0xFF7A7A7A),
          fontSize: 12,
          fontFamily: 'SF Pro Display',
          fontWeight: FontWeight.w400,
        ),
      );
    } catch (e) {
      final formatDate = date(dateTimeString);
      print(formatDate);
      final parsedDateTime = parseDateTime2(formatDate!);
      Duration diffirance = DateTime.now().difference(parsedDateTime);
      print(parsedDateTime);
      var timeAgo;
      print(diffirance);
      if (diffirance.inDays == 0) {
        if (diffirance.inMinutes == 0) {
          if (diffirance.inSeconds < 20) {
            timeAgo = prefix[0];
          } else {
            timeAgo = "${diffirance.inSeconds} ${prefix[1]}";
          }
        } else {
          if (diffirance.inMinutes > 59) {
            timeAgo = "${(diffirance.inMinutes / 60).floor()} ${prefix[3]}";
          } else {
            timeAgo = "${diffirance.inMinutes} ${prefix[2]}";
          }
        }
      } else {
        if (diffirance.inDays > 30) {
          if (((diffirance.inDays) / 30).floor() > 12) {
            timeAgo = "${((diffirance.inDays / 30) / 12).floor()} ${prefix[6]}";
          } else {
            timeAgo = "${(diffirance.inDays / 30).floor()} ${prefix[5]}";
          }
        } else {
          timeAgo = "${diffirance.inDays} ${prefix[4]}";
        }
      }
      return Text(
        timeAgo,
        style: TextStyle(
          color: Color(0xFF7A7A7A),
          fontSize: 12,
          fontFamily: 'SF Pro Display',
          fontWeight: FontWeight.w400,
        ),
      );
    }
  }

  DateTime parseDateTime1(String dateTimeString) {
    final inputFormat = DateFormat('dd MMMM y HH:mm', 'ru');
    return inputFormat.parse(dateTimeString);
  }

  DateTime parseDateTime2(String dateTimeString) {
    final inputFormat = DateFormat('dd.MM.yyyy HH:mm', 'ru');
    return inputFormat.parse(dateTimeString);
  }
}

class HomeWork extends StatelessWidget {
  List<GpageHomeworkModel> homeworkList = [];
  Future<Map<String, dynamic>> fetchApi() async {
    var scopedToken = await SubjectsService.getToken();
    String lang = await SubjectsService.getLang();
    var response = await SubjectsService.fetchSubjects(
        '${lang}/distance-schedule?page=1', '$scopedToken');
    var data = jsonDecode(response.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data['list']) {
        homeworkList.add(GpageHomeworkModel.fromJson(index));
      }
      return response.data;
    } else {
      throw Exception('Failed');
    }

    // print(response.data.toString());
    // return response.data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: fetchApi(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            //print(snapshot.data.toString());
            var jsonListHome = snapshot.data!['list'] as List<dynamic>;
            //print(jsonListHome[0]);
            return ListView.builder(
              itemCount: homeworkList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF72B1E9), Color(0xFF415BB6)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width / 2.6,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                '${homeworkList[index].predmetName}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w500,
                                  height: 1,
                                ),
                              ),
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Статус ${homeworkList[index].isAnswered == true ? 'done'.tr() : 'not-done'.tr()}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    // Text(
                                    //   '${homeworkList[index].isAnswered == true ? 'true' : 'false'}',
                                    //   style: TextStyle(
                                    //     color: Colors.white,
                                    //     fontSize: 12,
                                    //     fontFamily: 'SF Pro Display',
                                    //     fontWeight: FontWeight.w400,
                                    //   ),
                                    // )
                                  ])
                            ])),
                  ),
                );
              },
              scrollDirection: Axis.horizontal,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

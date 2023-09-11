import 'dart:convert';

import 'package:circular_bottom_navigation/tab_item.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
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
  var currentIndex;
  var currentTime1;
  var timeStart;
  var timeEnd;
  var myTimeMin;
  MainPageModel? glavnyiPage;
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();

    // _navigationController = CircularBottomNavigationController(selectedPos);
  }

  Future<Map<String, dynamic>> fetchApi() async {
    var scopedToken = await SubjectsService.getToken();
    var response =
        await SubjectsService.fetchSubjects('/main-page', '$scopedToken');
    var data = jsonDecode(response.toString());
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
            var jsonListNews = snapshot.data!['news_list'] as List<dynamic>;

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
            //print(currentIndex);
            String dateStr = '${today.day}.${today.month}.${today.year}';
            if (dayOfWeek == 'Monday') {
              dayOfWeek = 'Дүйсенбі';
            } else if (dayOfWeek == 'Tuesday') {
              dayOfWeek = 'Сейсенбі';
            } else if (dayOfWeek == 'Wednesday') {
              dayOfWeek = 'Сәрсенбі';
            } else if (dayOfWeek == 'Thursday') {
              dayOfWeek = 'Бейсенбі';
            } else if (dayOfWeek == 'Friday') {
              dayOfWeek = 'Жұма';
            } else if (dayOfWeek == 'Saturday') {
              dayOfWeek = 'Сенбі';
            } else {
              dayOfWeek = 'Жексенбі';
            }
            return MainPageView(
                formattedDate, dayOfWeek, jsonListDiyary, jsonListNews);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  int _selectedIndex = 0;
  double iconSize = 24.0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      iconSize = 36.0;
    });
  }

  final tabs = [];

  Scaffold MainPageView(String dateStr, String dayOfWeek,
      List<dynamic> jsonListDiyary, List<dynamic> jsonListNews) {
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
          'Басты Бет',
          style: TextStyle(
              color: Color(0xFF1E1E1E),
              fontSize: 20,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500),
        ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Бүгін',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w400,
                          )),
                      SizedBox(
                        height: 12,
                      ),
                      Text(
                        '$dateStr',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  Text(
                    '$dayOfWeek',
                    style: TextStyle(
                      color: Color(0xFF1E1E1E),
                      fontSize: 20,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w500,
                    ),
                  )
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
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Қазіргі сабақ',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF1E1E1E),
                                fontSize: 20,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Мектептегі шаралар',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF1E1E1E),
                                fontSize: 20,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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
                                                ),
                                                Container(
                                                  //color: Colors.white,
                                                  child: Text(
                                                    'Мектеп әкімшілігі',
                                                    style: TextStyle(
                                                      color: Color(0xFF7A7A7A),
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'SF Pro Display',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              //color: Colors.white,
                                              child: Text('Толығырақ'),
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
                              'Үй жұмысы',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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
  @override
  Widget build(BuildContext context) {
    final List prefix = [
      "just now",
      "second(s) ago",
      "minute(s) ago",
      "сағат бұрын",
      "day(s) ago",
      "month(s) ago",
      "year(s) ago"
    ];
    final dateTimeString = time;
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
  }

  DateTime parseDateTime1(String dateTimeString) {
    final inputFormat = DateFormat('dd MMMM y HH:mm', 'ru');
    return inputFormat.parse(dateTimeString);
  }
}

class HomeWork extends StatelessWidget {
  List<GpageHomeworkModel> homeworkList = [];
  Future<Map<String, dynamic>> fetchApi() async {
    var scopedToken = await SubjectsService.getToken();
    var response = await SubjectsService.fetchSubjects(
        '/distance-schedule?page=1', '$scopedToken');
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
                                      'Статус ${homeworkList[index].isAnswered == true ? 'Орындалды' : 'Орындалмады'}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      '${homeworkList[index].isAnswered == true ? 'true' : 'false'}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
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

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/model/chetvert-grades-model.dart';

class JournalPageScreen extends StatefulWidget {
  const JournalPageScreen({super.key});

  @override
  State<JournalPageScreen> createState() => _JournalPageScreenState();
}

class _JournalPageScreenState extends State<JournalPageScreen> {
  var tab = 0;
  var tap = 1;

  Future<Map<String, dynamic>> _fetchData() async {
    var scopedToken = await SubjectsService.getToken();
    final response =
        await SubjectsService.fetchSubjects('/jurnal-today', '$scopedToken');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed');
    }
  }

  Future<Map<String, dynamic>> _fetchPredmets() async {
    var scopedToken = await SubjectsService.getToken();
    final response =
        await SubjectsService.fetchSubjects('/predmets-list', '$scopedToken');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed');
    }
  }

  var selectedValue = 'Option1';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        //print(jsonJournalDiary);
        DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(color: Color(0xFF1E88E5)),
            backgroundColor: Colors.white.withOpacity(0.800000011920929),
            title: Text(
              'Журнал',
              style: TextStyle(
                color: Color(0xFF1F2024),
                fontSize: 20,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment(0.74, -0.67),
                end: Alignment(-0.74, 0.67),
                colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
              )),
              child: Padding(
                padding: const EdgeInsets.only(top: 27),
                child: Column(
                  children: [
                    Container(
                      width: 350,
                      height: 38,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white),
                      child: TabBar(
                        labelStyle: TextStyle(
                          fontSize: 12,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w400,
                        ),
                        unselectedLabelColor: Color(0xFF71727A),
                        indicator: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(16)),
                        tabs: [
                          Tab(
                            text: 'Бүгін',
                          ),
                          Tab(
                            text: 'Пәндер бойынша',
                          ),
                          Tab(
                            text: 'Тоқсандық',
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 26,
                    // ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 26),
                              child: Column(
                                children: [
                                  Container(
                                    height: 39,
                                    width: MediaQuery.of(context).size.width,
                                    //color: Colors.red,
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 25,
                                          top: 10,
                                          right: 30,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Сабақ кестесі',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'SF Pro Display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            'Баға',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'SF Pro Display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  FutureBuilder<Map<String, dynamic>>(
                                      future: _fetchData(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<Map<String, dynamic>>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          // print(snapshot.data);
                                          var jsonJournalDiary = snapshot
                                              .data!['diary'] as List<dynamic>;
                                          //print(jsonJournalDiary);
                                          return Column(
                                            children: [
                                              for (int i = 0;
                                                  i < jsonJournalDiary.length;
                                                  i++)
                                                ListOfLessonsInJournal(
                                                  predmetName:
                                                      jsonJournalDiary[i]
                                                          ['predmet_name'],
                                                  teacher_name:
                                                      jsonJournalDiary[i]
                                                          ['teacher_name'],
                                                  teacher_surname:
                                                      jsonJournalDiary[i]
                                                          ['teacher_surname'],
                                                  mark: jsonJournalDiary[i]
                                                      ['mark'],
                                                ),
                                            ],
                                          );
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }
                                      }),
                                  // for (int i = 0;
                                  //     i < jsonJournalDiary.length;
                                  //     i++)
                                  //   ListOfLessonsInJournal(
                                  //     predmetName: jsonJournalDiary[i]
                                  //         ['predmet_name'],
                                  //     teacher_name: jsonJournalDiary[i]
                                  //         ['teacher_name'],
                                  //     teacher_surname:
                                  //         jsonJournalDiary[i]
                                  //             ['teacher_surname'],
                                  //     mark: jsonJournalDiary[i]['mark'],
                                  //   ),
                                ],
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            child: FutureBuilder<Map<String, dynamic>>(
                                future: _fetchPredmets(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Map<String, dynamic>>
                                        snapshot) {
                                  if (snapshot.hasData) {
                                    //print(snapshot.data);
                                    var jsonPredmets = snapshot
                                        .data!['predmet_list'] as List<dynamic>;
                                    List<String> jsonPredmetsList = [];
                                    // for (int i = 0;
                                    //     i < jsonPredmets.length;
                                    //     i++) {
                                    //   if (!jsonPredmetsList.contains(
                                    //       jsonPredmets[i]['predmet_name'])) {
                                    //     jsonPredmetsList.add(
                                    //         jsonPredmets[i]['predmet_name']);
                                    //   }
                                    // }

                                    print(jsonPredmetsList);
                                    return JournalByPredmet(jsonPredmets);
                                  } else {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                }),
                          ),
                          ChetvertGrades()
                        ],
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}

class ChetvertGrades extends StatelessWidget {
  Future<Map<String, dynamic>> _fetchChetvertGrades() async {
    var scopedToken = await SubjectsService.getToken();
    final response =
        await SubjectsService.fetchSubjects('/chetvert-grades', '$scopedToken');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed');
    }
  }

  List<Chetvert> predmets = [];

  Future<List<Chetvert>> getChetvertData() async {
    Dio dio = Dio();
    final response = await dio.get(
      'https://mobile.mektep.edu.kz/api_ok_edus/public/api/ru/chetvert-grades',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer 1483|TyLoBW6gE53TmeuFn2yebIUgGeDcWf88cFiXrBXN',
      }),
    );
    var data = jsonDecode(response.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data['predmet_list']) {
        predmets.add(Chetvert.fromJson(index));
      }
      return predmets;
    } else {
      return predmets;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getChetvertData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(snapshot.data);
            return SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 21, left: 24, right: 100),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        // width: 50,
                        height: 60,
                        width: 100,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      for (int i = 0; i < 4; i++)
                        Row(
                          children: [
                            RotatedBox(
                              quarterTurns: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                height: 30,
                                width: 60,
                                child: Center(
                                    child: Text(
                                  '${i + 1}-тоқсан',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w400,
                                  ),
                                )),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            )
                          ],
                        ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          height: 30,
                          width: 60,
                          child: Center(
                              child: Text(
                            'Қорыты.',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w400,
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < predmets.length; i++)
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 3, left: 24, right: 100),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          // width: 50,
                          height: 52,
                          width: 100,

                          child:
                              Center(child: Text('${predmets[i].predmetName}')),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        for (int j = 0; j < 5; j++)
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.white,
                                ),
                                height: 52,
                                width: 30,
                                child: Center(
                                  child: (predmets[i].grades[j].grade == null)
                                      ? Text('')
                                      : Text('${predmets[i].grades[j].grade}'),
                                ),
                              ),
                              SizedBox(
                                width: 2,
                              )
                            ],
                          ),
                      ],
                    ),
                  ),
              ],
            ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}

class ListOfLessonsInJournal extends StatelessWidget {
  String predmetName;
  String teacher_surname;
  String teacher_name;
  var mark;

  ListOfLessonsInJournal(
      {required this.predmetName,
      required this.teacher_surname,
      required this.teacher_name,
      required this.mark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 31),
          child: Container(
            //height: 300,
            //color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    //width: 100,
                    //height: 100,
                    // color: Colors.blue,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            predmetName,
                            style: TextStyle(
                              color: Color(0xFF424242),
                              fontSize: 16,
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '${teacher_surname} ${teacher_surname}',
                            style: TextStyle(
                              color: Color(0xFF7A7A7A),
                              fontSize: 12,
                              fontFamily: 'SF Pro Display',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 29,
                ),
                Container(
                  // width: 100,
                  // height: 100,
                  width: 40,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ('$mark' == 'null') ? '' : '$mark',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF424242),
                        fontSize: 26,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class JournalByPredmet extends StatefulWidget {
  List<dynamic> b;
  JournalByPredmet(this.b);
  @override
  State<JournalByPredmet> createState() => _JournalByPredmetState(b);
}

class _JournalByPredmetState extends State<JournalByPredmet> {
  Future<Map<String, dynamic>> _fetchPredmetsPost(
      String id, String chetvert, String month) async {
    final response =
        await SubjectsService.fetchSubjectsPost(id, chetvert, month);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed');
    }
  }

  List<dynamic> a;
  _JournalByPredmetState(this.a);

  List<dynamic> monthNames = [
    {'name': 'Январь', 'value': 1},
    {'name': 'Февраль', 'value': 2},
    {'name': 'Март', 'value': 3},
    {'name': 'Апрель', 'value': 4},
    {'name': 'Май', 'value': 5},
    {'name': 'Июнь', 'value': 6},
    {'name': 'Июль', 'value': 7},
    {'name': 'Август', 'value': 8},
    {'name': 'Сентябрь', 'value': 9},
    {'name': 'Октябрь', 'value': 10},
    {'name': 'Ноябрь', 'value': 11},
    {'name': 'Декабрь', 'value': 12},
  ];
  // //List<String> monthNames = [
  //   'Январь',
  //   'Февраль',
  //   'Март',
  //   'Апрель',
  //   'Май',
  //   'Июнь',
  //   'Июль',
  //   'Август',
  //   'Сентябрь',
  //   'Октябрь',
  //   'Ноябрь',
  //   'Декабрь'
  // ];

  List<String> chetvert = [
    '1 четверть',
    '2 четверть',
    '3 четверть',
    '4 четверть'
  ];
  int selectedValue1 = 1;
  String selectedValue2 = '1 четверть';
  int selectedValue3 = 94967;

  FutureBuilder<Map<String, dynamic>> fBuilder(String a, String b, String c) {
    return FutureBuilder<Map<String, dynamic>>(
        future: _fetchPredmetsPost(a, b, c),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            var t = snapshot.data!['predmet']['predmet_name'];
            var u = '';
            var p = 0;
            var q;
            print(p);
            if (snapshot.data!['list'].length != 0) {
              u = snapshot.data!['list'][0]['name'];
              q = snapshot.data!['list'][0]['dates'];
              p = snapshot.data!['list'][0]['dates'].length;

              print(q);
            } else {
              u = monthNames[selectedValue1 - 1]['name'];
              print('null');
            }

            // var predmetLists = snapshot.data!['predmet_list'];
            // m = predmetLists;
            //print(m);
            return Column(
              children: [
                Row(
                  children: [
                    RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        width: 100,
                        height: 60,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    RotatedBox(
                      quarterTurns: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                        width: 100,
                        height: 60,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              '${t}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 4,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      // height: 689,
                      //color: Colors.red,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              height: 450,
                              child: RotatedBox(
                                  quarterTurns: 3,
                                  child: Center(child: Text('${u}'))),
                            ),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Container(
                            //height: 100,
                            //color: Colors.green,
                            child: Column(
                              children: [
                                for (int i = 0; i < p; i++)
                                  Column(
                                    children: [
                                      Container(
                                        width: 29,
                                        height: 29,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white,
                                        ),
                                        //width: 50,
                                        //height: 100,

                                        child: Center(
                                            child: Text('${q[i]['date']}')),
                                      ),
                                      SizedBox(
                                        height: 0.5,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Container(
                      width: 60,
                      height: 450,
                      //color: Colors.red,
                      child: Column(
                        children: [
                          for (int i = 0; i < p; i++)
                            Column(
                              children: [
                                Container(
                                  height: 29,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  //width: 50,
                                  //height: 100,

                                  child: Center(
                                      child: Text((q[i]['grade'] == null)
                                          ? ''
                                          : '${q[i]['grade']}')),
                                ),
                                SizedBox(
                                  height: 0.5,
                                ),
                              ],
                            ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.only(top: 17),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          child: DropdownButton<int>(
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            value: selectedValue1,
                            items: monthNames.map((item) {
                              return DropdownMenuItem<int>(
                                child: Text(item['name']),
                                value: item['value'],
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue1 = newValue!;
                                print(selectedValue1);
                              });
                            },

                            // items: [
                            //   for (int i = 0; i < 4; i++)
                            //     DropdownMenuItem(
                            //       value: monthNames[i],
                            //       child: Text('${monthNames[i]}'),
                            //     ),
                            //   // DropdownMenuItem(
                            //   //   value: 'Option 2',
                            //   //   child: Text('Option 2'),
                            //   // ),
                            //   // DropdownMenuItem(
                            //   //   value: 'Option 3',
                            //   //   child: Text('Option 3'),
                            //   // ),
                            // ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          child: DropdownButton(
                            isExpanded: true,
                            dropdownColor: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            value: selectedValue2,
                            items: chetvert.map((String chetvert) {
                              return DropdownMenuItem(
                                child: Text(chetvert),
                                value: chetvert,
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue2 = newValue!;
                              });
                            },
                            // items: const [
                            //   DropdownMenuItem(
                            //     value: 'Option1',
                            //     child: Text('Option1'),
                            //   ),
                            //   DropdownMenuItem(
                            //     value: 'Option 2',
                            //     child: Text('Option 2'),
                            //   ),
                            //   DropdownMenuItem(
                            //     value: 'Option 3',
                            //     child: Text('Option 3'),
                            //   ),
                            // ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    child: DropdownButton<int>(
                      isExpanded: true,
                      dropdownColor: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      value: selectedValue3,
                      items: a.map((item) {
                        return DropdownMenuItem<int>(
                          child: Text(item['predmet_name']),
                          value: item['id'],
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue3 = newValue!;
                          print(selectedValue3);
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              fBuilder('${selectedValue3}', '1', '${selectedValue1}')
            ],
          ),
        ),
      ),
    );
  }
}

class Journal2 extends StatefulWidget {
  @override
  State<Journal2> createState() => _Journal2State();
}

class _Journal2State extends State<Journal2> {
  var a = 0;

  @override
  Widget build(BuildContext context) {
    if (a == 0) {
      return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment(0.74, -0.67),
          end: Alignment(-0.74, 0.67),
          colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
        )),
        child: Center(
          child: ElevatedButton(
            child: Text('Login'),
            onPressed: () {
              setState(() {
                a = 1;
              });
            },
          ),
        ),
      );
    } else {
      return Container(decoration: BoxDecoration(color: Colors.red));
    }
  }
}

class Toksandik extends StatefulWidget {
  const Toksandik({super.key});

  @override
  State<Toksandik> createState() => _ToksandikState();
}

class _ToksandikState extends State<Toksandik> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
    );
  }
}

// class _DemoState extends State<Demo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("DEMO")),
//         body: Padding( // used padding just for demo purpose to separate from the appbar and the main content
//             padding: EdgeInsets.all(10),
//             child: Container(
//               alignment: Alignment.topCenter,
//               child: Container(
//                   height: 60,
//                   padding: EdgeInsets.all(3.5),
//                   width: MediaQuery.of(context).size.width * 0.9,
//                   decoration: BoxDecoration(
//                     color: Colors.blue,
//                     borderRadius: BorderRadius.all(Radius.circular(15)),
//                   ),
//                   child: Row(
//                     children: <Widget>[
//                       Expanded(
//                           child: InkWell(
//                               onTap: () {},
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.only(
//                                         bottomLeft: Radius.circular(12),
//                                         topLeft: Radius.circular(12))),
//                                 child: Text("Referrals",
//                                     style: TextStyle(
//                                       color: Colors.blue,
//                                       fontSize: 17,
//                                     )),
//                               ))),
//                       Expanded(
//                           child: InkWell(
//                               onTap: () {},
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 child: Text("Stats",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 17)),
//                               ))),
//                       Padding(
//                           padding: EdgeInsets.symmetric(vertical: 5),
//                           child: Container(color: Colors.white, width: 2)),
//                       Expanded(
//                           child: InkWell(
//                               onTap: () {},
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 child: Text("Edit Profile",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 17)),
//                               )))
//                     ],
//                   )),
//             )));
//   }
// }





import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  var tab = 0;
  var tap = 1;
  Future<Map<String, dynamic>> fetchApi() async {
    Dio dio = Dio();
    var response = await dio.get(
      'https://mobile.mektep.edu.kz/api_ok_edus/public/api/ru/jurnal-today',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer 1483|TyLoBW6gE53TmeuFn2yebIUgGeDcWf88cFiXrBXN',
      }),
    );
    if (response.statusCode == 200) {
      // Intl.defaultLocale = 'ru';
      // final dateTime = '16 августа 2023 15:34';
      // final inputFormat = DateFormat('dd MMMM y HH:mm', 'ru');
      // print(inputFormat.parse(toString()));

      return response.data;
    } else {
      throw Exception('Failed');
    }

    // print(response.data.toString());
    // return response.data;
  }

  var selectedValue = 'Option1';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: fetchApi(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            var jsonJournalDiary = snapshot.data!['diary'] as List<dynamic>;
            //print(jsonJournalDiary);
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                  appBar: AppBar(title: Text('Journal')),
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
                                  color: Colors.red),
                              child: TabBar(
                                indicator: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(16)),
                                tabs: [
                                  Tab(
                                    text: 'data1',
                                  ),
                                  Tab(
                                    text: 'data1',
                                  ),
                                  Tab(
                                    text: 'data1',
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.red,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25,
                                                  top: 10,
                                                  right: 30,
                                                  bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Сабақ кестесі',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'SF Pro Display',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    'Баға',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'SF Pro Display',
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                          for (int i = 0;
                                              i < jsonJournalDiary.length;
                                              i++)
                                            ListOfLessonsInJournal(
                                              predmetName: jsonJournalDiary[i]
                                                  ['predmet_name'],
                                              teacher_name: jsonJournalDiary[i]
                                                  ['teacher_name'],
                                              teacher_surname:
                                                  jsonJournalDiary[i]
                                                      ['teacher_surname'],
                                              mark: jsonJournalDiary[i]['mark'],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SingleChildScrollView(
                                      child: JournalByPredmet()),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ))),
            );
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
  const JournalByPredmet({super.key});

  @override
  State<JournalByPredmet> createState() => _JournalByPredmetState();
}

class _JournalByPredmetState extends State<JournalByPredmet> {
  String selectedValue = 'Option1';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.only(top: 17),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          child: DropdownButton(
                            isExpanded: true,
                            dropdownColor: Colors.red,
                            borderRadius: BorderRadius.circular(16),
                            value: selectedValue,
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: 'Option1',
                                child: Text('Option1'),
                              ),
                              DropdownMenuItem(
                                value: 'Option 2',
                                child: Text('Option 2'),
                              ),
                              DropdownMenuItem(
                                value: 'Option 3',
                                child: Text('Option 3'),
                              ),
                            ],
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
                        color: Colors.red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          child: DropdownButton(
                            isExpanded: true,
                            dropdownColor: Colors.red,
                            borderRadius: BorderRadius.circular(16),
                            value: selectedValue,
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: 'Option1',
                                child: Text('Option1'),
                              ),
                              DropdownMenuItem(
                                value: 'Option 2',
                                child: Text('Option 2'),
                              ),
                              DropdownMenuItem(
                                value: 'Option 3',
                                child: Text('Option 3'),
                              ),
                            ],
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
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    child: DropdownButton(
                      isExpanded: true,
                      dropdownColor: Colors.red,
                      borderRadius: BorderRadius.circular(16),
                      value: selectedValue,
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'Option1',
                          child: Text('Option1'),
                        ),
                        DropdownMenuItem(
                          value: 'Option 2',
                          child: Text('Option 2'),
                        ),
                        DropdownMenuItem(
                          value: 'Option 3',
                          child: Text('Option 3'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Container(
                color: Colors.green,
                child: Column(children: [
                  Container(
                    color: Colors.white,
                    child: Row(children: [
                      RotatedBox(
                        quarterTurns: 3,
                        child: Container(
                          width: 100,
                          height: 60,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      RotatedBox(
                        quarterTurns: 3,
                        child: Container(
                          width: 100,
                          height: 60,
                          color: Colors.black,
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Алгебра және анализ бастамалары',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    color: Colors.black,
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 689,
                          color: Colors.white,
                        ),
                        Column(
                          children: [
                            Container(
                              width: 50,
                              height: 100,
                              color: Colors.green,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ]),
              )
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









import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  var tab = 0;
  var tap = 1;
  Future<Map<String, dynamic>> fetchApi() async {
    Dio dio = Dio();
    var response = await dio.get(
      'https://mobile.mektep.edu.kz/api_ok_edus/public/api/ru/jurnal-today',
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer 1483|TyLoBW6gE53TmeuFn2yebIUgGeDcWf88cFiXrBXN',
      }),
    );
    if (response.statusCode == 200) {
      // Intl.defaultLocale = 'ru';
      // final dateTime = '16 августа 2023 15:34';
      // final inputFormat = DateFormat('dd MMMM y HH:mm', 'ru');
      // print(inputFormat.parse(toString()));

      return response.data;
    } else {
      throw Exception('Failed');
    }

    // print(response.data.toString());
    // return response.data;
  }

  var selectedValue = 'Option1';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
        future: fetchApi(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.hasData) {
            var jsonJournalDiary = snapshot.data!['diary'] as List<dynamic>;
            //print(jsonJournalDiary);
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                  appBar: AppBar(title: Text('Journal')),
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
                                  color: Colors.red),
                              child: TabBar(
                                indicator: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(16)),
                                tabs: [
                                  Tab(
                                    text: 'data1',
                                  ),
                                  Tab(
                                    text: 'data1',
                                  ),
                                  Tab(
                                    text: 'data1',
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            color: Colors.red,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 25,
                                                  top: 10,
                                                  right: 30,
                                                  bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Сабақ кестесі',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'SF Pro Display',
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                  Text(
                                                    'Баға',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      fontFamily:
                                                          'SF Pro Display',
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                          for (int i = 0;
                                              i < jsonJournalDiary.length;
                                              i++)
                                            ListOfLessonsInJournal(
                                              predmetName: jsonJournalDiary[i]
                                                  ['predmet_name'],
                                              teacher_name: jsonJournalDiary[i]
                                                  ['teacher_name'],
                                              teacher_surname:
                                                  jsonJournalDiary[i]
                                                      ['teacher_surname'],
                                              mark: jsonJournalDiary[i]['mark'],
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  JournalByPredmet(),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    color: Colors.blue,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ))),
            );
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
  const JournalByPredmet({super.key});

  @override
  State<JournalByPredmet> createState() => _JournalByPredmetState();
}

class _JournalByPredmetState extends State<JournalByPredmet> {
  String selectedValue = 'Option1';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.only(top: 17),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          child: DropdownButton(
                            isExpanded: true,
                            dropdownColor: Colors.red,
                            borderRadius: BorderRadius.circular(16),
                            value: selectedValue,
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: 'Option1',
                                child: Text('Option1'),
                              ),
                              DropdownMenuItem(
                                value: 'Option 2',
                                child: Text('Option 2'),
                              ),
                              DropdownMenuItem(
                                value: 'Option 3',
                                child: Text('Option 3'),
                              ),
                            ],
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
                        color: Colors.red,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          child: DropdownButton(
                            isExpanded: true,
                            dropdownColor: Colors.red,
                            borderRadius: BorderRadius.circular(16),
                            value: selectedValue,
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                            items: const [
                              DropdownMenuItem(
                                value: 'Option1',
                                child: Text('Option1'),
                              ),
                              DropdownMenuItem(
                                value: 'Option 2',
                                child: Text('Option 2'),
                              ),
                              DropdownMenuItem(
                                value: 'Option 3',
                                child: Text('Option 3'),
                              ),
                            ],
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
                  color: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    child: DropdownButton(
                      isExpanded: true,
                      dropdownColor: Colors.red,
                      borderRadius: BorderRadius.circular(16),
                      value: selectedValue,
                      onChanged: (newValue) {
                        setState(() {
                          selectedValue = newValue!;
                        });
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'Option1',
                          child: Text('Option1'),
                        ),
                        DropdownMenuItem(
                          value: 'Option 2',
                          child: Text('Option 2'),
                        ),
                        DropdownMenuItem(
                          value: 'Option 3',
                          child: Text('Option 3'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              Container(
                color: Colors.green,
                height: 400,
                child: Column(children: [
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: Row(children: [
                        Expanded(
                          child: Container(
                            color: Colors.red,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            color: Colors.black,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.deepPurple,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.grey,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    color: Colors.deepPurple,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ]),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: 200,
                      color: Colors.red,
                    ),
                  )
                ]),
              )
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



class DioHelper {
  static late Dio dio;
  static init() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: 20 * 1000,
      receiveTimeout: 20 * 1000,
      receiveDataWhenStatusError: true,
    );
    dio = Dio(options);
  }

  static Future<List<dynamic>> getData(
      {required Map<String, dynamic> query}) async {
    try {
      Response response =
          await dio.get('v2/top-headlines', queryParameters: query);
      return response.data['articles'];
    } catch (e) {
      print(e.toString());
      return [];
    }
  }
}



 // late ProfileModel _profileModel;

  // Future<void> _fetchProfileData() async {
  //   final repoProfile = RepoProfile();
  //   //final FlutterSecureStorage secureStorage = FlutterSecureStorage();
  //   //await secureStorage.read(key: 'access_token') ?? 'null';

  //   try {
  //     final result = await repoProfile.getProfile();
  //     if (result.errorMessage != null) {
  //       setState(() {
  //         // _isLoading = false;
  //       });
  //     } else {
  //       setState(() {
  //         _profileModel = result.profileData!;
  //         // _isLoading = false;
  //       });
  //     }
  //   } catch (error) {
  //     setState(() {
  //       // _isLoading = false;
  //     });
  //   }
  // }

  // Future<void> getP() async {
  //   final repoProfile = RepoProfile();
  // }
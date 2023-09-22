import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/model/classmates-model.dart';
import 'package:ok_edus/model/teacher-model.dart';

import '../../../gradiend.dart';

class BirlestikScreen extends StatefulWidget {
  const BirlestikScreen({super.key});

  @override
  State<BirlestikScreen> createState() => _BirlestikScreenState();
}

class _BirlestikScreenState extends State<BirlestikScreen> {
  int classN = 0;
  @override
  void initState() {
    super.initState();
    getClass();
  }

  void getClass() async {
    var str = await SubjectsService.getClass();
    classN = int.parse(str!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return
        //print(jsonJournalDiary);
        DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
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
              decoration: (classN >= 5 && classN <= 9)
                  ? MyTheme.teenColor()
                  : (classN >= 1 && classN <= 4)
                      ? MyTheme.kidsColor()
                      : MyTheme.adultColor(),
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
                            gradient: ((classN >= 5 && classN <= 9)
                                ? LinearGradient(
                                    begin: Alignment(0.74, -0.67),
                                    end: Alignment(-0.74, 0.67),
                                    colors: [
                                      Color(0xFF60B0F5),
                                      Color(0xFF1572C3)
                                    ],
                                  )
                                : (classN >= 1 && classN <= 4)
                                    ? LinearGradient(
                                        begin: Alignment(0.74, -0.67),
                                        end: Alignment(-0.74, 0.67),
                                        colors: [
                                          Color(0xFFFFC107),
                                          Color(0xFFFFC107)
                                        ],
                                      )
                                    : LinearGradient(
                                        begin: Alignment(0.74, -0.67),
                                        end: Alignment(-0.74, 0.67),
                                        colors: [
                                          Color(0xFFFFC107),
                                          Color(0xFFFFC107)
                                        ],
                                      )),
                            borderRadius: BorderRadius.circular(16)),
                        tabs: [
                          Tab(
                            text: 'class'.tr(),
                          ),
                          Tab(
                            text: 'teachers'.tr(),
                          ),
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 26,
                    // ),
                    Expanded(
                      child: TabBarView(
                        children: [Class(), TeacherList()],
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}

class Class extends StatelessWidget {
  List<Classmates> classmates = [];

  Future<List<Classmates>> getClassmates() async {
    var scopedToken = await SubjectsService.getToken();
    String lang = await SubjectsService.getLang();
    final response = await SubjectsService.fetchSubjects(
        '${lang}/classmates-list', '$scopedToken');
    var data = jsonDecode(response.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data['classmates_list']) {
        classmates.add(Classmates.fromJson(index));
      }
      return classmates;
    } else {
      return classmates;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 19),
      child: FutureBuilder(
          future: getClassmates(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(classmates.length);
              return ListView.builder(
                  itemCount: classmates.length,
                  itemBuilder: (BuildContext context, int index) => Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 5, left: 20, right: 20),
                        //color: Colors.red,
                        child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Image.asset('images/boy.png'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        '${classmates[index].surname} ${classmates[index].name} ${classmates[index].lastname}',
                                        style: TextStyle(
                                          color: Color(0xFF1F2024),
                                          fontSize: 14,
                                          fontFamily: 'Inter',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class TeacherList extends StatelessWidget {
  List<TeacherModel> teacherList = [];

  Future<List<TeacherModel>> getTeacherList() async {
    var scopedToken = await SubjectsService.getToken();
    String lang = await SubjectsService.getLang();
    final response = await SubjectsService.fetchSubjects(
        '${lang}/teachers-list', '$scopedToken');
    var data = jsonDecode(response.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data['teachers_list']) {
        teacherList.add(TeacherModel.fromJson(index));
      }
      return teacherList;
    } else {
      return teacherList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 19),
      child: FutureBuilder(
          future: getTeacherList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(teacherList.length);
              return ListView.builder(
                  itemCount: teacherList.length,
                  itemBuilder: (BuildContext context, int index) => Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(top: 5, left: 20, right: 20),
                        //color: Colors.red,
                        child: Card(
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Image.asset('images/teacher.png'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${teacherList[index].surname} ${teacherList[index].name}',
                                            style: TextStyle(
                                              color: Color(0xFF1F2024),
                                              fontSize: 14,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            '${teacherList[index].predmetName}',
                                            style: TextStyle(
                                              color: Color(0xFF1F2024),
                                              fontSize: 12,
                                              fontFamily: 'Inter',
                                              fontWeight: FontWeight.w400,
                                              height: 0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ));
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

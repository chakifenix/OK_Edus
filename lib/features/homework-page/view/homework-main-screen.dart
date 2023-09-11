import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/features/homework-send-page/view/homework-send-screen.dart';
import 'package:ok_edus/model/home-work-main-model.dart';

class HomeWorkMainScreen extends StatelessWidget {
  HomeWorkMainScreen({super.key});

  List<HomeWorkModel> homeWorkModel = [];

  Future<List<HomeWorkModel>> getHomeWork() async {
    var scopedToken = await SubjectsService.getToken();
    final response = await SubjectsService.fetchSubjects(
        '/distance-schedule', '$scopedToken');
    var data = jsonDecode(response.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data['list']) {
        homeWorkModel.add(HomeWorkModel.fromJson(index));
      }
      return homeWorkModel;
    } else {
      return homeWorkModel;
    }
  }

  String convertDateFormat(
      String originalFormat, String targetFormat, String dateStr) {
    DateTime originalDate = DateFormat(originalFormat).parse(dateStr);
    String formattedDate = DateFormat(targetFormat).format(originalDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment(0.74, -0.67),
        end: Alignment(-0.74, 0.67),
        colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
      )),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: BackButton(
              color: Color(0xFF1E88E5),
            ),
            elevation: 0,
            title: Text(
              'Үй жұмысы',
              style: TextStyle(
                color: Color(0xFF424242),
                fontSize: 20,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
              ),
            ),
            backgroundColor: Colors.white,
          ),
          body: FutureBuilder(
              future: getHomeWork(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var a = homeWorkModel.length;

                  return GridView.count(
                    //primary: false,
                    padding:
                        const EdgeInsets.only(left: 37, top: 28, right: 30),
                    crossAxisSpacing: 17,
                    mainAxisSpacing: 15,
                    crossAxisCount: 2,
                    children: <Widget>[
                      for (int i = 0; i < a; i++)
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeWorkSendScreen(
                                        '${homeWorkModel[i].id}')));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue),
                            padding: const EdgeInsets.only(
                                left: 12, top: 15, right: 0, bottom: 12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${homeWorkModel[i].predmetName}",
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
                                    Row(
                                      children: [
                                        Text(
                                          "Статус: ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12,
                                            fontFamily: 'SF Pro Display',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${homeWorkModel[i].isAnswered == true ? 'Орындалды' : 'Орындалмады'}",
                                            style: TextStyle(
                                              color: Color(0xFFD9D9D9),
                                              fontSize: 12,
                                              fontFamily: 'SF Pro Display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      'Дедлайн: ${convertDateFormat('yyyy-MM-dd', 'dd.MM.yyyy', '${homeWorkModel[i].date}')}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }
}

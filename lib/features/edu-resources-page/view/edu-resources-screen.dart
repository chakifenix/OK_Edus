import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/features/video-lessons-list/view/video-lessons-list-screen.dart';
import 'package:ok_edus/model/res-model.dart';
import 'package:url_launcher/url_launcher.dart';

class EduResourcesScreen extends StatefulWidget {
  const EduResourcesScreen({super.key});

  @override
  State<EduResourcesScreen> createState() => _EduResourcesScreenState();
}

class _EduResourcesScreenState extends State<EduResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Color(0xFF1E88E5)),
        backgroundColor: Colors.white,
        title: Text(
          'Оқу материалдары',
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
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          margin: EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 43),
          child: ListView(children: [
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey)),
                //color: Colors.red,
              ),
              margin: EdgeInsets.only(
                left: 15,
                right: 15,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18, bottom: 24),
                    child: Text(
                      'Видеосабақтар',
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 20,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w500,
                        height: 0.90,
                        letterSpacing: 0.20,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => VideoLessonsListScreen())),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [Color(0xFF72B1E9), Color(0xFF415BB6)],
                          )),
                          child: Image.asset('images/math.png'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Пәндік видеосабақтар',
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 18,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                'Ресурстар',
                style: TextStyle(
                  color: Color(0xFF1E1E1E),
                  fontSize: 20,
                  fontFamily: 'SF Pro Display',
                  fontWeight: FontWeight.w500,
                  height: 0.90,
                  letterSpacing: 0.20,
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Resources()
          ]),
        ),
      ),
    );
  }
}

class Resources extends StatelessWidget {
  List<ResModel> resources = [];

  Future<List<ResModel>> getRes() async {
    var scopedToken = await SubjectsService.getToken();
    final response = await SubjectsService.fetchSubjects(
        '/education-recources', '$scopedToken');
    var data = jsonDecode(response.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data['items']) {
        resources.add(ResModel.fromJson(index));
      }
      return resources;
    } else {
      return resources;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getRes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print(resources.length);
            return Column(
              children: [
                for (int i = 0; i < resources.length; i++)
                  GestureDetector(
                    onTap: () async {
                      final url = '${resources[i].url}';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border:
                              Border(bottom: BorderSide(color: Colors.grey))),
                      // color: Colors.red,
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(7.78),
                                child: Image(
                                  image: NetworkImage(resources[i].logo),
                                  width: 70,
                                  height: 70,
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${resources[i].name}',
                                      style: TextStyle(
                                        color: Color(0xFF1E1E1E),
                                        fontSize: 18,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      '${resources[i].type}',
                                      style: TextStyle(
                                        color: Color(0xFF7A7A7A),
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      '${resources[i].description}',
                                      style: TextStyle(
                                        color: Color(0xFF7A7A7A),
                                        fontSize: 12,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ]),
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
        });
  }
}

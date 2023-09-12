import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/features/video-lesson-page/view/video-lesson-screen.dart';
import 'package:ok_edus/model/video-model.dart';

class VideoLessonsListScreen extends StatefulWidget {
  @override
  State<VideoLessonsListScreen> createState() => _VideoLessonsListScreenState();
}

class _VideoLessonsListScreenState extends State<VideoLessonsListScreen> {
  List<VidModel> videoLesson = [];

  Future<List<VidModel>> getVid() async {
    var scopedToken = await SubjectsService.getToken();
    final response =
        await SubjectsService.fetchSubjects('/video-lessons', '$scopedToken');
    var data = jsonDecode(response.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data['lessons_list']) {
        videoLesson.add(VidModel.fromJson(index));
      }
      return videoLesson;
    } else {
      return videoLesson;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment(0.74, -0.67),
        end: Alignment(-0.74, 0.67),
        colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: BackButton(color: Color(0xFF1E88E5)),
          backgroundColor: Colors.white,
          title: Text(
            'Видео',
            style: TextStyle(
              color: Color(0xFF1F2024),
              fontSize: 20,
              fontFamily: 'SF Pro Display',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        body: FutureBuilder(
            future: getVid(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(videoLesson.length);
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 43),
                  child: ListView(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 14, top: 10),
                      child: Text(
                        'Видеолар',
                        style: TextStyle(
                          color: Color(0xFF1E1E1E),
                          fontSize: 16,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        for (int i = 0; i < videoLesson.length; i++)
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VideoLessonScreen(
                                          '${videoLesson[i].url}',
                                          '${videoLesson[i].title}',
                                          'data')));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 14, top: 16),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 50,
                                      color: Colors.red,
                                      child: Image.network(
                                          '${videoLesson[i].thumbnails.medium.url}'),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${videoLesson[i].title}',
                                            style: TextStyle(
                                              color: Color(0xFF1E1E1E),
                                              fontSize: 18,
                                              fontFamily: 'SF Pro Display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'data',
                                            style: TextStyle(
                                              color: Color(0xFF7A7A7A),
                                              fontSize: 12,
                                              fontFamily: 'SF Pro Display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ]),
                            ),
                          ),
                      ],
                    )
                  ]),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}

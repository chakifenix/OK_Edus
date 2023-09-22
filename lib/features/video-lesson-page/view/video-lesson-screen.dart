import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../core/api/Networking.dart';
import '../../../gradiend.dart';

class VideoLessonScreen extends StatefulWidget {
  String url1;
  String topic1;
  String des1;
  VideoLessonScreen(this.url1, this.topic1, this.des1);
  @override
  State<VideoLessonScreen> createState() =>
      _VideoLessonScreenState(url1, topic1, des1);
}

class _VideoLessonScreenState extends State<VideoLessonScreen> {
  late YoutubePlayerController _controller;
  String url2;
  String topic;
  String des;
  _VideoLessonScreenState(this.url2, this.topic, this.des);
  int classN = 0;

  void getClass() async {
    var str = await SubjectsService.getClass();
    classN = int.parse(str!);
    setState(() {});
  }

  bool _fullScreen = false;

  @override
  void initState() {
    getClass();
    // TODO: implement initState
    super.initState();
    final url = url2;

    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(url)!,
        flags: YoutubePlayerFlags(
            autoPlay: false, enableCaption: false, isLive: false))
      ..addListener(listener);
  }

  void listener() {
    setState(() {
      _fullScreen = _controller.value.isFullScreen;
    });
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _fullScreen
            ? null
            : AppBar(
                leading: BackButton(color: Color(0xFF1E88E5)),
                backgroundColor: Colors.white,
                title: Text(
                  '${topic}',
                  style: TextStyle(
                    color: Color(0xFF1F2024),
                    fontSize: 20,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
        body: YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
            ),
            builder: (context, player) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: (classN >= 5 && classN <= 9)
                    ? MyTheme.teenColor()
                    : (classN >= 1 && classN <= 4)
                        ? MyTheme.kidsColor()
                        : MyTheme.adultColor(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 43),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 10,
                          left: 10,
                          right: 10,
                        ),
                        child: player,
                      ),
                      SizedBox(
                        height: 19,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Сабақ тақырыбы:'.tr(),
                                style: TextStyle(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 16,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                '${topic}',
                                style: TextStyle(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 12,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ]),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Қосымша ақпарат'.tr(),
                                style: TextStyle(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 16,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                '${des}',
                                style: TextStyle(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 12,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ]),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}

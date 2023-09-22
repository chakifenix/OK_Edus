import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/model/info-model.dart';
import 'package:share/share.dart';

import '../../../gradiend.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  List<InfoModel> infoList = [];
  int classN = 0;
  void getClass() async {
    var str = await SubjectsService.getClass();
    classN = int.parse(str!);
    setState(() {});
  }

  Future<List<InfoModel>> getVid() async {
    var scopedToken = await SubjectsService.getToken();
    String lang = await SubjectsService.getLang();
    final response = await SubjectsService.fetchSubjects(
        '${lang}/school-info', '$scopedToken');
    var data = jsonDecode(response.toString());
    try {
      if (response.statusCode == 200) {
        infoList.add(InfoModel.fromJson(data));

        return infoList;
      } else {
        return infoList;
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClass();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: (classN >= 5 && classN <= 9)
          ? MyTheme.teenColor()
          : (classN >= 1 && classN <= 4)
              ? MyTheme.kidsColor()
              : MyTheme.adultColor(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: BackButton(color: Color(0xFF1E88E5)),
          backgroundColor: Colors.white,
          title: Text(
            'Инфо',
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
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 24, bottom: 43),
                  child: ListView(children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 14, top: 16, right: 14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('images/school.png'),
                              SizedBox(
                                height: 10,
                              ),
                              Text('Мектептің толық атауы'),
                              Text(
                                '${infoList[0].mektepName}',
                                style: TextStyle(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 18,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text('Мектептің мекенжайы'),
                              Text(
                                '${infoList[0].mektepAddress}',
                                style: TextStyle(
                                  color: Color(0xFF1E1E1E),
                                  fontSize: 18,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 18,
                              ),
                              Text('Картада көрсетілген'),
                              Image.asset('images/schoolMap.png'),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: 110,
                                child: ElevatedButton(
                                    onPressed: () {
                                      Share.share('https://go.2gis.com/cfxy0',
                                          subject: 'Look what I made!');
                                    },
                                    child: Row(
                                      children: [
                                        Icon(Icons.ios_share),
                                        Text('Бөлісу')
                                      ],
                                    )),
                              )
                            ],
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

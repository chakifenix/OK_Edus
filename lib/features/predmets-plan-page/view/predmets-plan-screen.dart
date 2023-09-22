import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ok_edus/model/predmet-plan-model.dart';

import '../../../core/api/Networking.dart';
import '../../../gradiend.dart';

class PredmetsPlanScreen extends StatefulWidget {
  String predmetName;
  int id;
  int sagatInt;
  String name;
  String surName;
  PredmetsPlanScreen(
      {super.key,
      required this.predmetName,
      required this.id,
      required this.sagatInt,
      required this.name,
      required this.surName});

  @override
  State<PredmetsPlanScreen> createState() => _PredmetsPlanScreenState();
}

class _PredmetsPlanScreenState extends State<PredmetsPlanScreen> {
  int classN = 0;
  List<PredmedPlanModel> predmetPlan = [];
  Future<void> getClass() async {
    var str = await SubjectsService.getClass();
    classN = int.parse(str!);
    setState(() {});
  }

  Future<List<PredmedPlanModel>> fetchPredmetPlan() async {
    var scopedToken = await SubjectsService.getToken();
    String lang = await SubjectsService.getLang();

    final response = await SubjectsService.fetchSubjects(
        '${lang}/predmet-plan/${widget.id}', '$scopedToken');
    var data = jsonDecode(response.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data['list']) {
        predmetPlan.add(PredmedPlanModel.fromJson(index));
      }
      return predmetPlan;
    } else {
      return predmetPlan;
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
    predmetPlan = [];
    return Container(
      decoration: (classN >= 5 && classN <= 9)
          ? MyTheme.teenColor()
          : (classN >= 1 && classN <= 4)
              ? MyTheme.kidsColor()
              : MyTheme.adultColor(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(
              '${widget.predmetName}',
              style: TextStyle(
                color: Color(0xFF1F2024),
                fontSize: 20,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
            backgroundColor: Colors.white,
            leading: BackButton(color: Colors.blue),
          ),
          body: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                margin: EdgeInsets.only(left: 20, right: 20, top: 14),
                padding: EdgeInsets.only(left: 12, top: 16, bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'kolemi'.tr()}: ${widget.sagatInt} ${'hour'.tr()}',
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 16,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    Text(
                      '${'teacher'.tr()}: ${widget.surName} ${widget.name}',
                      style: TextStyle(
                        color: Color(0xFF1E1E1E),
                        fontSize: 16,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
              ),
              FutureBuilder(
                  future: fetchPredmetPlan(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          for (int i = 0; i < predmetPlan.length; i++)
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              margin:
                                  EdgeInsets.only(left: 20, right: 20, top: 14),
                              padding: EdgeInsets.only(
                                  left: 29, top: 16, bottom: 16, right: 10),
                              child: Row(
                                children: [
                                  Text(
                                    '${i + 1}',
                                    style: TextStyle(
                                      color: Color(0xFF424242),
                                      fontSize: 24,
                                      fontFamily: 'SF Pro Display',
                                      fontWeight: FontWeight.w700,
                                      height: 0,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 28,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'taqyryby'.tr(),
                                          style: TextStyle(
                                            color: Color(0xFF424242),
                                            fontSize: 14,
                                            fontFamily: 'SF Pro Display',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                        Text(
                                          '${predmetPlan[i].title}',
                                          style: TextStyle(
                                            color: Color(0xFF424242),
                                            fontSize: 16,
                                            fontFamily: 'SF Pro Display',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 11,
                                        ),
                                        Text(
                                          'hour'.tr(),
                                          style: TextStyle(
                                            color: Color(0xFF424242),
                                            fontSize: 14,
                                            fontFamily: 'SF Pro Display',
                                            fontWeight: FontWeight.w400,
                                            height: 0,
                                          ),
                                        ),
                                        Text(
                                          '${predmetPlan[0].sagat}',
                                          style: TextStyle(
                                            color: Color(0xFF424242),
                                            fontSize: 16,
                                            fontFamily: 'SF Pro Display',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  })
            ],
          )),
    );
  }
}

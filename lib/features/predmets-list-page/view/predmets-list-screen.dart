import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/features/predmets-plan-page/view/predmets-plan-screen.dart';
import 'package:ok_edus/model/predmet-list-model.dart';

import '../../../gradiend.dart';

class PredmetListsScreen extends StatefulWidget {
  const PredmetListsScreen({super.key});

  @override
  State<PredmetListsScreen> createState() => _PredmetListsScreenState();
}

class _PredmetListsScreenState extends State<PredmetListsScreen> {
  List<PredmetListModel> predmets = [];
  List<PredmetListModel> result = [];
  List wrong = [];
  int classN = 0;
  TextEditingController controller = TextEditingController();
  Future<List<PredmetListModel>> fetchApi() async {
    var scopedToken = await SubjectsService.getToken();
    String lang = await SubjectsService.getLang();
    final response = await SubjectsService.fetchSubjects(
        '${lang}/predmets-list', '$scopedToken');
    var data = jsonDecode(response.toString());
    if (response.statusCode == 200) {
      setState(() {
        for (Map<String, dynamic> index in data['predmet_list']) {
          predmets.add(PredmetListModel.fromJson(index));
        }
      });
      return predmets;
    } else {
      return predmets;
    }
  }

  void getClass() async {
    var str = await SubjectsService.getClass();
    classN = int.parse(str!);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchApi();
    getClass();
  }

  updateTextField(String text) async {
    result.clear();
    wrong.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    predmets.forEach((element) {
      if (element.predmetName.toLowerCase().contains(text)) {
        result.add(element);
      } else {
        wrong.add(element);
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (classN >= 5 && classN <= 9)
          ? MyTheme.teenColor()
          : (classN >= 1 && classN <= 4)
              ? MyTheme.kidsColor()
              : MyTheme.adultColor(),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: BackButton(color: Colors.blue),
            backgroundColor: Colors.white,
            title: Text(
              'Пәндер',
              style: TextStyle(
                color: Color(0xFF1F2024),
                fontSize: 20,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
                height: 0,
              ),
            ),
          ),
          body: (predmets.length != 0)
              ? Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 25, left: 20, right: 20),
                      child: TextField(
                        controller: controller,
                        onChanged: (value) => updateTextField(value),
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide.none),
                            hintText: 'Поиск',
                            prefixIcon: Icon(Icons.search),
                            prefixIconColor: Colors.grey),
                      ),
                    ),
                    Expanded(
                        child: (result.length == 0 && wrong.length == 0)
                            ? ListView.builder(
                                itemCount: predmets.length,
                                itemBuilder: (context, index) {
                                  print(predmets[1].id);
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      top: 13,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.red),
                                      //height: 100,

                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      PredmetsPlanScreen(
                                                        predmetName:
                                                            predmets[index]
                                                                .predmetName,
                                                        id: predmets[index].id,
                                                        sagatInt:
                                                            predmets[index]
                                                                .sagat,
                                                        name: predmets[index]
                                                            .teacherName,
                                                        surName: predmets[index]
                                                            .teacherSurname,
                                                      )));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, top: 15, bottom: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 136),
                                                child: Text(
                                                  '${predmets[index].predmetName}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 5,
                                                ),
                                                child: Text(
                                                  '${'kolemi'.tr()}: ${predmets[index].sagat} сағат',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  '${'teacher'.tr()}: ${predmets[index].teacherSurname} ${predmets[index].teacherName}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : ListView.builder(
                                itemCount: result.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PredmetsPlanScreen(
                                                    predmetName: predmets[index]
                                                        .predmetName,
                                                    id: predmets[index].id,
                                                    sagatInt:
                                                        predmets[index].sagat,
                                                    name: predmets[index]
                                                        .teacherName,
                                                    surName: predmets[index]
                                                        .teacherSurname,
                                                  )));
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 13,
                                      ),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.red),
                                        //height: 100,

                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 12, top: 15, bottom: 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 136),
                                                child: Text(
                                                  '${result[index].predmetName}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 5,
                                                ),
                                                child: Text(
                                                  'Көлемі: ${result[index].sagat} сағат',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5),
                                                child: Text(
                                                  'Мұғалім: ${result[index].teacherSurname} ${result[index].teacherName}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }))
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                )),
    );
  }
}

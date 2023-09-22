import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/model/home-work-model.dart';

import '../../../gradiend.dart';

class HomeWorkSendScreen extends StatefulWidget {
  String idM;
  HomeWorkSendScreen(this.idM);
  @override
  State<HomeWorkSendScreen> createState() => _HomeWorkSendScreenState(idM);
}

class _HomeWorkSendScreenState extends State<HomeWorkSendScreen> {
  String id;
  _HomeWorkSendScreenState(this.id);
  FocusNode _focusNode = FocusNode();
  List work = [];
  FilePickerResult? result;
  String? _fileName;
  File? image;
  String? imageName;
  String textController = '';
  int classN = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClass();
  }

  void pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      setState(() {
        final imageTemporary = File(image.path);
        imageName = imageTemporary!.path.split('/').last;
      });

      print(imageName);
    } catch (e) {
      print('Failed to pick Image:${e}');
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  void _requestFocus() {
    FocusScope.of(context).requestFocus(_focusNode);
  }

  void _onTapOutsideTextField() {
    // Снимите фокус с TextField
    _focusNode.unfocus();
  }

  Future<List<dynamic>> getHomeWorkPage() async {
    var scopedToken = await SubjectsService.getToken();
    String lang = await SubjectsService.getLang();
    final response = await SubjectsService.fetchSubjects(
        '${lang}/distance-material/${id}', '$scopedToken');
    var data = jsonDecode(response.toString());
    if (response.statusCode == 200) {
      if (data.containsKey('headers')) {
        print(true);
      } else {
        work.add(HomeWorkPageModel.fromJson(response.data));
      }

      print(work);
      return work;
    } else {
      return work;
    }
  }

  void getClass() async {
    var str = await SubjectsService.getClass();
    classN = int.parse(str!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapOutsideTextField,
      child: Container(
        decoration: (classN >= 5 && classN <= 9)
            ? MyTheme.teenColor()
            : (classN >= 1 && classN <= 4)
                ? MyTheme.kidsColor()
                : MyTheme.adultColor(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: BackButton(color: Colors.black),
            title: Text(
              'homework',
              style: TextStyle(
                color: Color(0xFF424242),
                fontSize: 20,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
              ),
            ).tr(),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          body: FutureBuilder(
              future: getHomeWorkPage(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return (work.length != 0)
                      ? Column(
                          children: [
                            Container(
                              // height: 78,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(30),
                                      bottomRight: Radius.circular(30)),
                                  color: Colors.white),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, bottom: 14, top: 14),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(
                                        child: Text(
                                      '${work[0].predmetName}',
                                      style: TextStyle(
                                        color: Color(0xFF1E1E1E),
                                        fontSize: 19,
                                        fontFamily: 'SF Pro Display',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )),
                                  )),
                            ),
                            SizedBox(
                              height: 18,
                            ),
                            Expanded(
                              child: ListView(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            right: 20,
                                            top: 14,
                                            bottom: 17),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                (work[0].isAnswered == true)
                                                    ? Container(
                                                        padding:
                                                            EdgeInsets.all(8),
                                                        child: Text(
                                                          'Орындалды',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 10,
                                                            fontFamily: 'Inter',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            letterSpacing: 0.50,
                                                          ),
                                                        ),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                            color:
                                                                Colors.green),
                                                      )
                                                    : Container(
                                                        width: 1,
                                                        height: 1,
                                                      ),
                                                Container(
                                                  padding: EdgeInsets.all(8),
                                                  child: Text(
                                                    'Дедлайн: 31.07.2023',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontFamily: 'Inter',
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      letterSpacing: 0.50,
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      color: Colors.red),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 6,
                                            ),
                                            Text(
                                              'homework',
                                            ).tr(),
                                            Text(
                                              '${work[0].title}',
                                              textAlign: TextAlign.left,
                                            ),
                                            SizedBox(
                                              height: 17,
                                            ),
                                            Text('teacher').tr(),
                                            Text('${work[0].teacherFio}'),
                                            SizedBox(
                                              height: 17,
                                            ),
                                            Text('text').tr(),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            TextField(
                                              focusNode: _focusNode,
                                              onTap: _requestFocus,
                                              onChanged: (String str) {
                                                setState(() {
                                                  textController = str;
                                                  print(textController);
                                                });
                                              },
                                              keyboardType:
                                                  TextInputType.multiline,
                                              autofocus: true,
                                              maxLines: 4,
                                              decoration: InputDecoration(
                                                  hintText: 'Enter Text',
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color: Color(
                                                                  0xFFC5C6CC))),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                              width: 1,
                                                              color: Color(
                                                                  0xFFC5C6CC)))),
                                            ),
                                            SizedBox(
                                              height: 17,
                                            ),
                                            if (imageName != null)
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFD9D9D9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Container(
                                                        child: Image.asset(
                                                            'images/lucide_file.png'),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                            '${imageName}'),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ElevatedButton(
                                              onPressed: () {
                                                pickImage();
                                                print('pressed');
                                              },
                                              child: Text('import').tr(),
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          0),
                                                  side: MaterialStateProperty
                                                      .all(BorderSide(
                                                          color: Colors.grey)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white),
                                                  foregroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.grey)),
                                            ),
                                            SizedBox(height: 17),
                                            Center(
                                                child: ElevatedButton(
                                                    onPressed: () => {},
                                                    child: Text('done').tr(),
                                                    style: (textController ==
                                                                '' ||
                                                            imageName == null)
                                                        ? ButtonStyle(
                                                            minimumSize:
                                                                MaterialStateProperty
                                                                    .all(Size(
                                                                        double
                                                                            .infinity,
                                                                        40)),
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                              Color(0xFFD9D9D9),
                                                            ))
                                                        : ButtonStyle(
                                                            minimumSize:
                                                                MaterialStateProperty
                                                                    .all(Size(
                                                                        double
                                                                            .infinity,
                                                                        40)),
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                              Colors.green,
                                                            ))))
                                          ],
                                        ),
                                      )),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Center(
                          child: Text('Запретил Доступ'),
                        );
                } else {
                  return Center(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ok_edus/core/api/call.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/features/settings-page/view/settings-screen.dart';
import 'package:ok_edus/model/profile-model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<ProfileModel> profileModel = [];

  Future<List<ProfileModel>> getProfile() async {
    var scopedToken = await SubjectsService.getToken();
    final response =
        await SubjectsService.fetchSubjects('/profile', '$scopedToken');
    var data = jsonDecode(response.toString());

    if (response.statusCode == 200) {
      profileModel.add(ProfileModel.fromJson(data));

      return profileModel;
    } else {
      return profileModel;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.blue,
              ),
              onPressed: () {
                // Действия при нажатии на кнопку

                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
              },
            ),
          ],
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'Профиль',
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
          child: FutureBuilder(
              future: getProfile(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      Container(
                        //width: 100,
                        height: 150,
                        //color: Colors.red,
                        child: Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            Image.asset('images/girl.png'),
                            Positioned(
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.only(
                                    left: 18, right: 18, top: 8, bottom: 8),
                                child: Text(
                                  '${profileModel[0].name}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        '${profileModel[0].profileModelClass} сынып оқушысы',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'SF Pro Display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      StudentCard('Толық аты-жөні',
                          '${profileModel[0].surname} ${profileModel[0].name} ${profileModel[0].lastname}'),
                      SizedBox(
                        height: 7,
                      ),
                      StudentCard(
                          'Сыныбы', '${profileModel[0].profileModelClass}'),
                      SizedBox(
                        height: 7,
                      ),
                      StudentCard(
                          'Сынып жетекші', '${profileModel[0].teacherFio}'),
                      SizedBox(
                        height: 7,
                      ),
                      StudentCard('Ата-ана 1',
                          '${profileModel[0].parent1.surname} ${profileModel[0].parent1.name} ${profileModel[0].parent1.lastname}'),
                      SizedBox(
                        height: 7,
                      ),
                      StudentCard('Ата-ана 2',
                          '${profileModel[0].parent2.surname} ${profileModel[0].parent2.name} ${profileModel[0].parent2.lastname}'),
                      SizedBox(
                        height: 7,
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ));
  }
}

class StudentCard extends StatelessWidget {
  String firstTitle;
  String secondTitle;
  StudentCard(this.firstTitle, this.secondTitle);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(left: 28, right: 27),
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${firstTitle}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '${secondTitle}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ok_edus/features/birlestik-page/view/birlestik-screen.dart';
import 'package:ok_edus/features/edu-resources-page/view/edu-resources-screen.dart';
import 'package:ok_edus/features/homework-page/view/homework-main-screen.dart';
import 'package:ok_edus/features/info-page/view/info-screen.dart';
import 'package:ok_edus/features/journal-page/view/journal-page-screen.dart';
import 'package:ok_edus/features/predmets-list-page/view/predmets-list-screen.dart';
import 'package:ok_edus/features/schedule-page/view/schedule-page-screen.dart';

class SchoolScreen extends StatefulWidget {
  const SchoolScreen({super.key});

  @override
  State<SchoolScreen> createState() => _SchoolScreenState();
}

class _SchoolScreenState extends State<SchoolScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'school',
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
      backgroundColor: Colors.transparent,
      body: Container(
        child: Column(
          children: [
            Container(
              child: Center(
                  child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF03A9F4),
                        borderRadius: BorderRadius.circular(10)),
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 17,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'data',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                'data',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Center(
                                      child: Text(
                                'data',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.50,
                                ),
                              ))),
                              Expanded(
                                  child: Image.asset('images/image-17.png'))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 26, left: 24, right: 29),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SchedulePageScreen()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 65,
                                width: 65,
                                child: Center(
                                  child: SvgPicture.asset(
                                    'images/Vector1.svg',
                                    width: 35,
                                    height: 35,
                                  ),
                                ),
                              ),
                            ),
                            const Text(
                              'schedule',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ).tr()
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            JournalPageScreen()));
                              },
                              child: Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'images/Vector2.svg',
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'journal',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ).tr()
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PredmetListsScreen()));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                height: 65,
                                width: 65,
                                child: Center(
                                    child:
                                        SvgPicture.asset('images/Vector3.svg')),
                              ),
                            ),
                            const Text(
                              'predmets',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ).tr()
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeWorkMainScreen()));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child:
                                        SvgPicture.asset('images/Vector4.svg')),
                              ),
                              Container(
                                width: 65,
                                child: Text(
                                  'homework',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ).tr(),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 26, left: 24, right: 29),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BirlestikScreen()));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child:
                                        SvgPicture.asset('images/Vector5.svg')),
                              ),
                              Text(
                                'birlestik',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ).tr()
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        EduResourcesScreen()));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child:
                                        SvgPicture.asset('images/Vector6.svg')),
                              ),
                              Container(
                                width: 65,
                                child: Text(
                                  'edu-res',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'SF Pro Display',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ).tr(),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 22,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => InfoScreen()));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child:
                                        SvgPicture.asset('images/Vector7.svg')),
                              ),
                              Text(
                                'Инфо',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 26, left: 24),
                    child: Text(
                      'optional',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.w500,
                      ),
                    ).tr(),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 26, left: 24, right: 29),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: SvgPicture.asset(
                                  'images/Test.svg',
                                  width: 40,
                                  height: 40,
                                ),
                              ),
                            ),
                            Text(
                              'Тест',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SchedulePageScreen()));
                              },
                              child: Container(
                                height: 65,
                                width: 65,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'images/Videolesson.svg',
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              'videolesson',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ).tr()
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: SvgPicture.asset(
                                  'images/Quiz.svg',
                                  width: 50,
                                  height: 50,
                                ),
                              ),
                            ),
                            Text(
                              'Quiz',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 65,
                              width: 65,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: SvgPicture.asset('images/zhazba.svg')),
                            ),
                            Text(
                              'write',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w400,
                              ),
                            ).tr()
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

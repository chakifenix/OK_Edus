import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ok_edus/core/api/Networking.dart';
import 'package:ok_edus/features/main-bar-page/view/chat-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/main-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/profile-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/school-screen.dart';
import 'package:ok_edus/gradiend.dart';

class MainBarScreen extends StatefulWidget {
  const MainBarScreen({super.key});

  @override
  State<MainBarScreen> createState() => _MainBarScreenState();
}

class _MainBarScreenState extends State<MainBarScreen> {
  int _selectedIndex = 0;
  int classN = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClass();
  }

  void getClass() async {
    var str = await SubjectsService.getClass();
    classN = int.parse(str!);
    print(classN);
    setState(() {});
  }

  final tabs = [MainScreen(), SchoolScreen(), ChatScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (classN >= 5 && classN <= 9)
          ? MyTheme.teenColor()
          : (classN >= 1 && classN <= 4)
              ? MyTheme.kidsColor()
              : MyTheme.adultColor(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            tabs[_selectedIndex],
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                    child: BottomNavigationBar(
                      //backgroundColor: Colors.red,
                      currentIndex: _selectedIndex,
                      selectedItemColor: Colors.blue,
                      unselectedItemColor: Colors.grey,
                      items: [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: 'main-page'.tr(),
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset('images/r.png',
                              color: (_selectedIndex == 1)
                                  ? Colors.blue
                                  : Colors.grey),
                          label: 'school'.tr(),
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.camera),
                          label: 'Чат',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.person),
                          label: 'Профиль',
                        )
                      ],
                      onTap: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

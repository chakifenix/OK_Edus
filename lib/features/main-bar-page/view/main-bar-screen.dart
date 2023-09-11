import 'package:flutter/material.dart';
import 'package:ok_edus/features/main-bar-page/view/chat-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/main-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/profile-screen.dart';
import 'package:ok_edus/features/main-bar-page/view/school-screen.dart';

class MainBarScreen extends StatefulWidget {
  const MainBarScreen({super.key});

  @override
  State<MainBarScreen> createState() => _MainBarScreenState();
}

class _MainBarScreenState extends State<MainBarScreen> {
  int _selectedIndex = 0;

  final tabs = [MainScreen(), SchoolScreen(), ChatScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment(0.74, -0.67),
        end: Alignment(-0.74, 0.67),
        colors: [Color(0xFF8BE1DE), Color(0xFF398FA3)],
      )),
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
                          label: 'Басты Бет',
                        ),
                        BottomNavigationBarItem(
                          icon: Image.asset('images/r.png',
                              color: (_selectedIndex == 1)
                                  ? Colors.blue
                                  : Colors.grey),
                          label: 'Мектеп',
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.camera),
                          label: 'Camera',
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

import 'package:flutter/material.dart';
import 'package:ok_edus/features/login-page/view/login-page-screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool onLastPage = false;
  PageController _controller = PageController();
  String selectedValue = 'Выберите';
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
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            PageView(
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 4);
                });
              },
              controller: _controller,
              children: [
                Container(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned(
                          left: -27,
                          top: 126.39,
                          child: Align(
                            child: SizedBox(
                              width: 152.84,
                              height: 152.84,
                              child: Image.asset(
                                  'images/elements-geometric-shape-abstract-oval-sharp-xxw.png'),
                            ),
                          )),
                      Positioned(
                          left: 107.9046173096,
                          top: -50,
                          child: Align(
                            child: SizedBox(
                              width: 152.84,
                              height: 152.84,
                              child: Image.asset(
                                  'images/elements-geometric-shape-flower-1-nature-5Yb.png'),
                            ),
                          )),
                      Positioned(
                          left: 231.6908454895,
                          top: 303.9845504761,
                          child: Align(
                            child: SizedBox(
                              width: 152.84,
                              height: 152.84,
                              child: Image.asset(
                                  'images/elements-geometric-shape-star-flower-EoH.png'),
                            ),
                          )),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 76,
                            ),
                            Text(
                              'Тілді таңдаңыз',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              'Выберите язык',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'SF Pro Display',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                            Container(
                              width: 320,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: Container(
                                  child: DropdownButton<String>(
                                    underline: SizedBox(),
                                    isExpanded: true,
                                    dropdownColor: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    value: selectedValue,
                                    items: <String>[
                                      'Выберите',
                                      'Қазақша',
                                      'Русский'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: (value == 'Выберите')
                                                ? TextStyle(
                                                    color: Color(0xFF7A7A7A),
                                                    fontSize: 17,
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontWeight: FontWeight.w400,
                                                  )
                                                : null,
                                          ));
                                    }).toList(),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _controller.nextPage(
                                            duration:
                                                Duration(milliseconds: 500),
                                            curve: Curves.easeIn);
                                        selectedValue = newValue!;
                                        print(selectedValue);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                OnBoardPages(
                  imageName: 'images/man.png',
                  title: 'Қашықтан оқу',
                  subTitle:
                      'Мектеп сабақтарының кестелері мен қашықтан оқудың жүйесін қолданыңыз',
                  controller: _controller,
                ),
                OnBoardPages(
                  imageName: 'images/man2.png',
                  title: 'Сабақ материалдары',
                  subTitle:
                      'Күнделікті сабақтардың мазмұны мен тапсырмаларын біліп, танысып отырыңыз',
                  controller: _controller,
                ),
                OnBoardPages(
                  imageName: 'images/man3.png',
                  title: 'Үй тапсырмалары',
                  subTitle:
                      'Үй тапсырмаларын орындаңыз және осы қосымша арқылы мұғалімдерге жолдаңыз',
                  controller: _controller,
                ),
                OnBoardPages(
                  imageName: 'images/man4.png',
                  title: 'Стриминг-сабақтар',
                  subTitle:
                      'Видео сабақтарға қатысыңы, мұғалімдердің қашықтан оқытуын онлайн тыңдаңыз',
                  controller: _controller,
                ),
              ],
            ),
            Container(
                alignment: Alignment(0, 0.5),
                child: SmoothPageIndicator(controller: _controller, count: 5)),
            onLastPage
                ? Container(
                    alignment: Alignment(0, 0.75),
                    child: ElevatedButton(
                      child: Container(
                          width: (280 / MediaQuery.of(context).size.width) *
                              MediaQuery.of(context).size.width,
                          child: Text(
                            'Келесі',
                            textAlign: TextAlign.center,
                          )),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPageScreen()));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        Color(0xFFFFC107),
                      )),
                    ),
                  )
                : Container(
                    alignment: Alignment(0, 0.75),
                    child: ElevatedButton(
                      child: Container(
                          width: (280 / MediaQuery.of(context).size.width) *
                              MediaQuery.of(context).size.width,
                          child: Text(
                            'Келесі',
                            textAlign: TextAlign.center,
                          )),
                      onPressed: () {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        Color(0xFFFFC107),
                      )),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class OnBoardPages extends StatelessWidget {
  OnBoardPages({
    super.key,
    required this.imageName,
    required this.title,
    required this.subTitle,
    required PageController controller,
  }) : _controller = controller;
  String imageName;
  String title;
  String subTitle;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 80,
              right: 44,
              child: GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(3);
                  },
                  child: Text(
                    'Өткізу',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w400,
                    ),
                  ))),
          Positioned(
              left: -27,
              top: 126.39,
              child: Align(
                child: SizedBox(
                  width: 152.84,
                  height: 152.84,
                  child: Image.asset(
                      'images/elements-geometric-shape-abstract-oval-sharp-xxw.png'),
                ),
              )),
          Positioned(
              left: 107.9046173096,
              top: -50,
              child: Align(
                child: SizedBox(
                  width: 152.84,
                  height: 152.84,
                  child: Image.asset(
                      'images/elements-geometric-shape-flower-1-nature-5Yb.png'),
                ),
              )),
          Positioned(
              left: 231.6908454895,
              top: 303.9845504761,
              child: Align(
                child: SizedBox(
                  width: 152.84,
                  height: 152.84,
                  child: Image.asset(
                      'images/elements-geometric-shape-star-flower-EoH.png'),
                ),
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: SizedBox(
                    child: Image.asset(imageName),
                  ),
                ),
                SizedBox(
                  height: 76,
                ),
                Text(
                  '$title',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontFamily: 'SF Pro Display',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.only(left: 49, right: 49),
                    child: Text(
                      subTitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

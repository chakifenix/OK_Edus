import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ok_edus/features/login-page/view/login-page-screen.dart';
import 'package:ok_edus/gradiend.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool onLastPage = false;
  bool onFirstPage = true;
  PageController _controller = PageController();
  String selectedValue = 'Выберите';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    langState();
  }

  void langState() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('myLang', 'ru');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: MyTheme.teenColor(),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            PageView(
              onPageChanged: (index) {
                setState(() {
                  onLastPage = (index == 4);
                  onFirstPage = (index == 0);
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
                              child: SvgPicture.asset(
                                  'images/Elements-geometric-shape-abstract-oval-sharp.svg'),
                            ),
                          )),
                      Positioned(
                          left: 107.9046173096,
                          top: -50,
                          child: Align(
                            child: SizedBox(
                              width: 152.84,
                              height: 152.84,
                              child: SvgPicture.asset(
                                  'images/Elements-geometric-shape-flower-1-nature.svg'),
                            ),
                          )),
                      Positioned(
                          left: 231.6908454895,
                          top: 303.9845504761,
                          child: Align(
                            child: SizedBox(
                              width: 152.84,
                              height: 152.84,
                              child: SvgPicture.asset(
                                  'images/Elements-geometric-shape-star-flower.svg'),
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
                                    onChanged: (newValue) async {
                                      SharedPreferences preferences =
                                          await SharedPreferences.getInstance();
                                      (newValue == 'Выберите')
                                          ? null
                                          : (newValue == 'Қазақша')
                                              ? setState(() async {
                                                  await preferences.setString(
                                                      'myLang', 'kk');
                                                  _controller.nextPage(
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.easeIn);
                                                  selectedValue = newValue!;
                                                  print(selectedValue);
                                                  context
                                                      .setLocale(Locale('en'));
                                                })
                                              : setState(() async {
                                                  await preferences.setString(
                                                      'myLang', 'ru');
                                                  _controller.nextPage(
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve: Curves.easeIn);
                                                  selectedValue = newValue!;
                                                  print(selectedValue);
                                                  context
                                                      .setLocale(Locale('ru'));
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
                  title: 'onboard1-title',
                  subTitle: 'onboard1-subtitle',
                  controller: _controller,
                ),
                OnBoardPages(
                  imageName: 'images/man2.png',
                  title: 'onboard2-title',
                  subTitle: 'onboard2-subtitle',
                  controller: _controller,
                ),
                OnBoardPages(
                  imageName: 'images/man3.png',
                  title: 'onboard3-title',
                  subTitle: 'onboard3-subtitle',
                  controller: _controller,
                ),
                OnBoardPages(
                  imageName: 'images/man4.png',
                  title: 'onboard4-title',
                  subTitle: 'onboard4-subtitle',
                  controller: _controller,
                ),
              ],
            ),
            Container(
                alignment: Alignment(0, 0.5),
                child: SmoothPageIndicator(controller: _controller, count: 5)),
            (onLastPage)
                ? Container(
                    alignment: Alignment(0, 0.75),
                    child: ElevatedButton(
                      child: Container(
                          width: (280 / MediaQuery.of(context).size.width) *
                              MediaQuery.of(context).size.width,
                          child: Text(
                            'next'.tr(),
                            textAlign: TextAlign.center,
                          )),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (context) => LoginPageScreen()),
                            (route) => false);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                        Color(0xFFFFC107),
                      )),
                    ),
                  )
                : (onFirstPage)
                    ? Container()
                    : Container(
                        alignment: Alignment(0, 0.75),
                        child: ElevatedButton(
                          child: Container(
                              width: (280 / MediaQuery.of(context).size.width) *
                                  MediaQuery.of(context).size.width,
                              child: Text(
                                'next',
                                textAlign: TextAlign.center,
                              ).tr()),
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
  final String imageName;
  final String title;
  final String subTitle;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
              top: 80,
              right: 30,
              child: GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(3);
                  },
                  child: Text(
                    'skip'.tr(),
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
                  child: SvgPicture.asset(
                      'images/Elements-geometric-shape-abstract-oval-sharp.svg'),
                ),
              )),
          Positioned(
              left: 107.9046173096,
              top: -50,
              child: Align(
                child: SizedBox(
                  width: 152.84,
                  height: 152.84,
                  child: SvgPicture.asset(
                      'images/Elements-geometric-shape-flower-1-nature.svg'),
                ),
              )),
          Positioned(
              left: 231.6908454895,
              top: 303.9845504761,
              child: Align(
                child: SizedBox(
                  width: 152.84,
                  height: 152.84,
                  child: SvgPicture.asset(
                      'images/Elements-geometric-shape-star-flower.svg'),
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
                ).tr(),
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
                    ).tr(),
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

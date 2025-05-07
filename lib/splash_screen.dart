import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isPressed = false;

  final TextStyle montserratTitleStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontWeight: FontWeight.w400,
    fontSize: 13.5,
    height: 1.0,
    letterSpacing: 0.0,
    color: const ui.Color.fromARGB(255, 255, 255, 255),
    shadows: [
      Shadow(
        offset: const Offset(0, 2),
        blurRadius: 2,
        color: Colors.black.withOpacity(0.3),
      ),
    ],
  );

  final List<String> _titles = [
    'Погрузитесь в мир приключений с DiWo!',
    'Объединяйтесь с друзьями и почувствуйте себя охотниками за сокровищами !',
    'Найдите свой первый клад !',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment(0, -0.4),
            image: AssetImage('assets/images/logoK.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(height: 540),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                    vertical: MediaQuery.of(context).size.height * 0.05,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _titles.length,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 28),
                        width: 12,
                        height: 12,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF11A8FD),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: _currentPage == index
                                      ? [Color(0xFF4166FE), Color(0xFF4166FE)]
                                      : [
                                          Colors.transparent,
                                          Colors.transparent
                                        ],
                                ),
                                boxShadow: _currentPage == index
                                    ? [
                                        BoxShadow(
                                          color: Color(0xFF4166FE)
                                              .withOpacity(0.8),
                                          spreadRadius: 0,
                                          blurRadius: 8,
                                          offset: const Offset(0, 0),
                                        ),
                                        BoxShadow(
                                          color: Color(0xFF11A8FD)
                                              .withOpacity(0.6),
                                          spreadRadius: 2,
                                          blurRadius: 12,
                                          offset: const Offset(0, 0),
                                        ),
                                      ]
                                    : [],
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? Color(0xFF4166FE)
                                    : const ui.Color.fromARGB(
                                        255, 255, 255, 255),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index.round();
                      });
                    },
                    itemCount: _titles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: MediaQuery.of(context).size.height * 0.01,
                        ),
                        child: Text(
                          _titles[index],
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: montserratTitleStyle,
                        ),
                      );
                    },
                  ),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTapDown: (details) {
                    setState(() {
                      _isPressed = true;
                    });
                  },
                  onTapUp: (details) {
                    setState(() {
                      _isPressed = false;
                    });
                  },
                  onTapCancel: () {
                    setState(() {
                      _isPressed = false;
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.01,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          const Color(0xFF000000),
                          const Color(0xFF014984),
                        ],
                      ),
                      border: Border.all(color: Color(0xFF11A8FD), width: 2),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: _isPressed
                          ? null
                          : [
                              BoxShadow(
                                color: Color(0xFF11A8FD).withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 15,
                                offset: const Offset(0, 0),
                              ),
                            ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        padding: EdgeInsets.zero,
                        minimumSize: Size(
                          double.infinity,
                          50,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () {
                        if (_currentPage < _titles.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          Navigator.pushNamed(context, '/registration');
                        }
                      },
                      child: Text(
                        _currentPage == _titles.length - 1
                            ? 'Продолжить'
                            : 'Продолжить',
                        style: TextStyle(
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          height: 1.0,
                          letterSpacing: 0.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

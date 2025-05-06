import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//import 'package:yandex_maps_mapkit/yandex_maps_mapkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*
  await init.initMapkit(
    apiKey: 'YOUR_API_KEY'
  );
*/

  runApp(MaterialApp(home: ProfileScreenSer()));
}

class ProfileScreenSer extends StatefulWidget {
  const ProfileScreenSer({super.key});

  @override
  State<ProfileScreenSer> createState() => _MapScreenState();
}

class _MapScreenState extends State<ProfileScreenSer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Image.asset('assets/images/bottom_bar.png'),
        /*BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.business), label: 'Business'),
            BottomNavigationBarItem(icon: Icon(Icons.school), label: 'School'),
          ],
          currentIndex: 0,
          selectedItemColor: Colors.amber[800],
          onTap: (a) {},
        ),*/
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('AppBar with hamburger button'),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: myDrawer(),
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                // color: Colors.red,
                child: Column(children: [
                  SizedBox(height: 20),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        //shape: BoxShape.circle,
                        color: Colors.blue,
                        border: Border.all(
                          // добавление границы
                          color: Colors.white,
                          //width: 2.0,
                        ),
                        boxShadow: [
                          // добавление тени
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        // Горизонтальная линия с двумя кнопками
                        //crossAxisAlignment: ,
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                              border: Border.all(
                                // добавление границы
                                color: Colors.white,
                                width: 2.0,
                              ),
                              boxShadow: [
                                // добавление тени
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                          Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text("Джек"),
                            Row(children: [Text("a"), Text("followers"), Text("b|"), Text("Following")])
                          ]),
                        ],
                      )),
                ]))));
  }

  Widget Collection1() {
    return Container(
        //  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          //shape: BoxShape.circle,
          color: Colors.white.withOpacity(0),
          border: Border.all(
            // добавление границы
            color: Colors.green.withOpacity(1),
            //width: 2.0,
          ),
          boxShadow: [
            // добавление тени
            BoxShadow(
              color: Colors.black.withOpacity(0),
              spreadRadius: 2,
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          // Горизонтальная линия с двумя кнопками
          //crossAxisAlignment: ,
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
                border: Border.all(
                  // добавление границы
                  color: Colors.white,
                  width: 2.0,
                ),
                boxShadow: [
                  // добавление тени
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
                child: Container(
              padding: EdgeInsets.only(left: 14),
              alignment: Alignment.centerLeft,
              height: 50.0,
              //  padding:
              //      EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                //shape: BoxShape.circle,
                color: Colors.purple,
                border: Border.all(
                  // добавление границы
                  color: Colors.green,
                  //width: 2.0,
                ),
                boxShadow: [
                  // добавление тени
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Text("Джек"),
            ))
          ],
        ));
  }

  Widget myDrawer() {
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Center(
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              padding: EdgeInsets.only(left: 16, right: 22),
              decoration: BoxDecoration(color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5)),
              child: Column(
                children: [
                  const SizedBox(height: 64.59),
                  Container(
                    padding: EdgeInsets.only(top: 8.0),
                    width: double.infinity,
                    child: Row(
                      children: [
                        // without gradient
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0, right: 31.0),
                          child: Container(
                            child: CircleAvatar(
                              radius: 36, // Image radius 36 diameeter 72
                              // here local image assets/images/avatar.png
                              backgroundImage: const AssetImage('images/avatar.png'),
                            ),
                          ),
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5.43),
                            Text(
                              'Logist_8888',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 11),
                            Row(
                              children: [
                                // here image from assets/images/coin.png
                                Image.asset('images/coin.png', width: 21, height: 21),
                                const SizedBox(width: 5.19),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 3.0),
                                  child: Text(
                                    '5 060',
                                    style: TextStyle(
                                      // Roboto
                                      fontSize: 13.37,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Container(
                              width: 128,
                              height: 7.06,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                                child: LinearProgressIndicator(
                                  value: 0.7,
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff209FFF)),
                                  backgroundColor: Color(0xff282C30),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 45.97),
                  DrawerButton(buttonText: 'Коллекции пазлов'),
                  const SizedBox(height: 28.61),
                  DrawerButton(buttonText: 'Коллекции DiWo'),
                  const SizedBox(height: 28.61),
                  DrawerButton(buttonText: 'Рейтинг DiWo'),
                  const SizedBox(height: 28.61),
                  DrawerButton(buttonText: 'Настройки'),
                  Container(
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('images/chest_bg.png', width: 220.3, height: 220.3), // 120-108
                        Image.asset('images/chest.png', width: 65.15, height: 59.45), // 108.98+11.32=120.3
                        Padding(
                          padding: EdgeInsets.only(top: 140.0),
                          child: Text(
                            '5:50',
                            style: TextStyle(
                              // Urbanist
                              fontSize: 16.98,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // CircleAvatar(
                        //   radius: 52, // Image diameeter 108.98 radius 54.49
                        //   // radius: 24.49, // Image diameeter 108.98 radius 54.49
                        //   // here local image assets/images/avatar.png
                        //   backgroundImage: const AssetImage('images/chest.png'),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    super.key,
    required this.buttonText,
  });

  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) {},
            onTapUp: (details) {},
            onTapCancel: () {},
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              // margin: EdgeInsets.only(
              //   // bottom: MediaQuery.of(context).size.height * 0.01,
              //   left: 10,
              //   right: 10,
              // ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    const Color(0xFF000000),
                    const Color(0xFF014984),
                  ],
                ),
                border: Border.all(color: Color(0xFF11A8FD), width: 4),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
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
                    250,
                    50,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  buttonText,
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
        ],
      ),
    );
  }
}

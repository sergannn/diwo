//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/map_screen_ser.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
//import 'package:flutter_application_1/widgets/animated_widgets.dart';
//import 'package:google_fonts/google_fonts.dart';

//import 'package:yandex_maps_mapkit/yandex_maps_mapkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
/*
  await init.initMapkit(
    apiKey: 'YOUR_API_KEY'
  );
*/

  runApp(MaterialApp(home: SettingsScreenSer()));
}

class SettingsScreenSer extends StatefulWidget {
  const SettingsScreenSer({super.key});

  @override
  State<SettingsScreenSer> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreenSer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Image.asset(
          'assets/images/bottom_bar.png',
        ), //, fit: BoxFit.cover),
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
          backgroundColor: Colors.white,
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
        drawer: myDrawer(context),
        backgroundColor: Colors.black,
        body: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Первый элемент
                          Text("<"),
                          SizedBox(width: 8, height: 52),

                          // Второй элемент
                          Text("Настройки"),

                          // Гибкое пространство между вторым и третьим элементом
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 20),
                      AnimatedContainer(
                          duration: Duration(seconds: 1),
                          width: MediaQuery.of(context).size.width,
                          // height: 85,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 2, 14, 24),
                            borderRadius: BorderRadius.circular(32),
                            border:
                                Border.all(color: Color(0xFF11A8FD), width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF11A8FD).withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                              spacing: 10,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                var the_title;
                                if (index == 0) {
                                  the_title = "a";
                                } else if (index == 1) {
                                  the_title = "b";
                                } else if (index == 2) {
                                  the_title = "c";
                                } else {
                                  the_title = "другое";
                                }
                                return Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    height: 60,
                                    decoration: BoxDecoration(
                                      color: Colors.blue.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(32),
                                      /*   border: Border.all(
                                          color: Color(0xFF11A8FD), width: 2),*/
                                    ),
                                    child: Row(
                                        spacing: 10,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  'https://placehold.co/80x80')),
                                          Text(the_title),
                                          Spacer(),
                                          Text('>')
                                        ]));
                              })))
                    ])))));
  }
}

//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/bottom_bar.dart';
//import 'package:flutter_application_1/profile_screen_ser.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
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

// список иконок
final List<IconData> icons = [
  Icons.info_outline, // FAQ
  Icons.support_agent, // Поддержка
  Icons.policy, // Политика конф
  Icons.logout, // Выход из профиля
  Icons.delete_forever, // Удалить аккаунт
  Icons.settings, // Пустая строка
];

class SettingsScreenSer extends StatefulWidget {
  const SettingsScreenSer({super.key});

  @override
  State<SettingsScreenSer> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreenSer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: bottomBar(context),
        drawer: myDrawer(context),
        backgroundColor: Color(0xFF020E18), //тут другой цвет фона
        body: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: Container(
                padding: EdgeInsets.only(
                    top: 30),
                child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Container(
                        child: Column(children: [
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                          child: Container(
                            height: 64,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Первый элемент
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);/* pushNamed(
                                        context, '/profileScreenSer');*/
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFF162E3F),
                                    radius: 26,
                                    child: Icon(Icons.arrow_back_ios_new,
                                        color: Color(0xFF209FFF)),
                                  ),
                                ),
                                SizedBox(width: 17, height: 52),
                                // Второй элемент
                                SizedBox(width: 6),
                                Text(
                                  "Настройки",
                                  style: GoogleFonts.montserrat(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600, // Semibold
                                    color: Colors.white,
                                  ),
                                ),
                                // Гибкое пространство между вторым и третьм элементом
                                Spacer(),
                                // Третий элемент (прижат вправо)
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          }),
                      SizedBox(height: 20),
                      AnimatedContainer(
                          duration: Duration(seconds: 1),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [
                                Color(0xFF000000),
                                Color.fromARGB(255, 0, 51, 92)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(34),
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
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              child: Column(
                                  spacing: 10,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(5, (index) {
                                    // Изменено с 6 на 5
                                    var the_title;
                                    if (index == 0) {
                                      the_title = "FAQ";
                                    } else if (index == 1) {
                                      the_title = "Поддержка";
                                    } else if (index == 2) {
                                      the_title = "Политика конф";
                                    } else if (index == 3) {
                                      the_title = "Выход из профиля";
                                    } else if (index == 4) {
                                      the_title = "Удалить аккаунт";
                                    }

                                    return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 20),
                                        height: 60,
                                        decoration: BoxDecoration(
                                          color: Colors.blue.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(32),
                                        ),
                                        child: Row(
                                            spacing: 10,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              // Круг с иконкой и свечением
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Color(0xFF162E3F),
                                                  borderRadius:
                                                      BorderRadius.circular(32),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xFF209FFF)
                                                          .withOpacity(0.5),
                                                      spreadRadius: 3,
                                                      blurRadius: 10,
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Icon(
                                                    icons[index],
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(width: 1),
                                              Text(
                                                the_title,
                                                style: GoogleFonts.montserrat(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Spacer(),

                                              GestureDetector(
                                                onTap: () {},
                                                child: Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Color(0xFF209FFF)),
                                              ),
                                            ]));
                                  }))))
                    ]))))));
  }
}

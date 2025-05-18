//import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/game_screens/profile/profile_screen.dart';
import 'package:flutter_application_1/screens/game_screens/profile/widgets/sliders_screenAlpha.dart';

import 'package:flutter_application_1/screens/main_widgets/bottom_bar.dart';
import 'package:flutter_application_1/screens/main_widgets/drawer.dart';
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

  runApp(MaterialApp(home: CollectionsDiwoScreen()));
}

class CollectionsDiwoScreen extends StatefulWidget {
  const CollectionsDiwoScreen({super.key});

  @override
  State<CollectionsDiwoScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<CollectionsDiwoScreen> {
  // Список для хранения состояний раскрытия
  List<bool> _isSliderExpanded = List<bool>.filled(2, false);
  List<String> _titles = ['Император', 'Нептун']; // Список названий
  List<String> _collectionInfo = [
    'Император',
    'Нептун'
  ]; // Список названий в нижней строке

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: bottomBar(context),
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
        /*   appBar: AppBar(
          backgroundColor: Color(0xFF020E18),
          title: const Text(''),
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
        ),*/
        backgroundColor: Color(0xFF020E18),
        body: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: Container(
              padding: EdgeInsets.only(top: 30),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(children: [
                  // Верхняя строка с заголовком
                  SizedBox(height: 10),
                  Container(
                    height: 64,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Первый элемент // Кнопка назад
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                                context); //pushNamed(context, '/profileScreenSer');
                          },
                          child: CircleAvatar(
                            backgroundColor: Color(0xFF162E3F),
                            radius: 26,
                            child: Icon(Icons.arrow_back_ios_new,
                                color: Color(0xFF209FFF)),
                          ),
                        ),
                        SizedBox(width: 17, height: 52),
                        // Второй элемент // Заголовок
                        SizedBox(width: 6),
                        Text(
                          "Коллекции DiWo Арт",
                          style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w600, // Semibold
                            color: Colors.white,
                          ),
                        ),
                        // Гибкое пространство между вторым и третьм элементом
                        Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Контейнер с рамкой и свечением
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
                      border: Border.all(color: Color(0xFF11A8FD), width: 3.2),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF11A8FD).withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Container(
                      //    color:Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.02,
                      ),
                      child: Column(
                        children: [
                          // Создаем список строк с помощью map
                          ...List.generate(12, (index) {
                            var so = math.Random().nextInt(2);

                            return Column(
                              children: [
                                _CollectionRow(
                                  isExpanded: _isSliderExpanded[so],
                                  onToggle: () {
                                    setState(() {
                                      _isSliderExpanded[so] =
                                          !_isSliderExpanded[so];
                                    });
                                  },
                                  title: _titles[so],
                                  collectionInfo: _collectionInfo[so],
                                ),
                                SizedBox(height: 20), // Отступ между строками
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            )));
  }
}

class _CollectionRow extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final String title; // Добавляем параметр для названия
  final String collectionInfo; //параметр для названия в нижней строке

  const _CollectionRow({
    required this.isExpanded,
    required this.onToggle,
    required this.title,
    required this.collectionInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          // width: 500,
          height: 53,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(23)),
            color: isExpanded
                ? Color(0x26F5C53F)
                : Color.fromARGB(227, 1, 59,
                    92), // Изменяем цвет при  раскрытии/закрыти списка
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05),
          child: Row(
            spacing: 10,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/slider3.png'),
              ),
              _CollectionRowIndicators(title: title),
              Spacer(),
              CircleAvatar(
                radius: 12,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.currency_ruble,
                  size: 16,
                ),
              ),
              Container(
                child: Text(
                  "9 000",
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              ArrowSliderToggle(
                isExpanded: isExpanded,
                onToggle: onToggle,
              ),
            ],
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isExpanded ? 400 : 0,
          child: isExpanded ? const SliderScreen() : null,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isExpanded ? 100 : 0,
          child: isExpanded
              ? Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Row(
                    spacing: 10,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Stack(children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color.fromRGBO(15, 34, 56, 1),
                          backgroundImage:
                              AssetImage('assets/images/logoK.png'),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 10,
                            child: Center(
                              child: Icon(
                                size: 10,
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                            backgroundImage:
                                AssetImage('assets/images/Star1.png'),
                          ),
                        ),
                      ]),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "DiWo Art",
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            collectionInfo,
                            style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      ObmenButton()
                    ],
                  ),
                )
              : null,
        ),
      ],
    );
  }
}

//тут добавлен класс для анимации стрелки
class ArrowSliderToggle extends StatefulWidget {
  final bool isExpanded;
  final VoidCallback onToggle;

  const ArrowSliderToggle({
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  State<ArrowSliderToggle> createState() => _ArrowSliderToggleState();
}

class _ArrowSliderToggleState extends State<ArrowSliderToggle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onToggle();
        });
      },
      child: Transform.rotate(
        angle: widget.isExpanded
            ? math.pi / 2
            : 0, //это надо чтобы поворот был не крутящийся а простой с фиксированным углом под двумя положениями
        child: Container(
          width: 30,
          height: 48,
          child: Icon(Icons.arrow_forward_ios, color: Color(0xFF209FFF)),
        ),
      ),
    );
  }
}

// Класс для индикаторов строки
class _CollectionRowIndicators extends StatelessWidget {
  final String title;
  const _CollectionRowIndicators({
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text(
            title, // Используем параметр title
            style: GoogleFonts.montserrat(
              fontSize: 15,
              fontWeight: FontWeight.w600, // Semibold
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 5),
        Container(
            child: Text(
          "5 DiWo Art",
          textAlign: TextAlign.right,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w500, // Semibold
            color: Colors.white,
          ),
        ))

        //width: 10, height: 10, color: Colors.blue),
      ],
    );
  }
}

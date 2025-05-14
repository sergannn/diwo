//import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter_application_1/profile_screen_ser.dart';
import 'package:flutter_application_1/utils/faker.dart';
import 'package:flutter_application_1/widgets/bottom_bar.dart';
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

  runApp(MaterialApp(home: RatingScreenSer()));
}

class RatingScreenSer extends StatefulWidget {
  const RatingScreenSer({super.key});

  @override
  State<RatingScreenSer> createState() => _ProfileScreenState();
}

final Map<int, Color> ratingColors = {
  //это я добавила, чтобы гибко настраивать цвета для фона самих строк с прозрачностями
  1: Color.fromRGBO(0xFF, 0xD3, 0x44, 0.38),
  2: Color.fromRGBO(0xB4, 0xB4, 0xB4, 0.38),
  3: Color.fromRGBO(0x8D, 0x52, 0x29, 0.56),
};

class _ProfileScreenState extends State<RatingScreenSer> {
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
                    top: 30, bottom: kBottomNavigationBarHeight * 2),
                child: SingleChildScrollView(
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 20),
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
                                        Navigator.pushNamed(
                                            context, '/profileScreenSer');//возврат на профиль добавила надо поменять 
                                      },
                                      child: CircleAvatar(
                                        backgroundColor: Color(0xFF162E3F),
                                        radius: 26,
                                        child: Icon(Icons.arrow_forward_ios,
                                            color: Color(0xFF209FFF)),
                                      ),
                                    ),
                                    SizedBox(width: 17, height: 52),
                                    // Второй элемент
                                    SizedBox(width: 6),
                                    Text(
                                      "Рейтинг DiWo",
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
                              // height: 85,
                              decoration: BoxDecoration(
                                // тут градиент для фона внутренней рамки
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF000000),
                                    Color.fromARGB(255, 0, 51, 92)
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(34),
                                border: Border.all(
                                    color: Color(0xFF11A8FD), width: 3.2),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF11A8FD).withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                              child: Container(
                                  //тут добавлен контейнер для отступов по краям с адаптивными паддингами
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.02),
                                  child: Column(
                                      spacing: 10,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: List.generate(40, (index) {
                                        var position = index +
                                            1; //это я добавила, чтобы отсчет начинался не с 0, а с 1
                                        var the_color =
                                            ratingColors[position] ??
                                                Colors.blue.withOpacity(0.2);

                                        return Container(
                                          // тут цвета теней/свечений для первых трех строк (под индексами), последний без - это все начиная с 4 строки
                                          height: 53,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(23.5)),
                                            color: the_color,
                                            border: position == 1
                                                ? Border.all(
                                                    color: Color.fromRGBO(
                                                        0xD5, 0xAC, 0x37, 1.0),
                                                    width: 2.0,
                                                  )
                                                : null,
                                            boxShadow: position == 1
                                                ? [
                                                    BoxShadow(
                                                      color: Color(0xFFFFD344)
                                                          .withOpacity(0.3),
                                                      spreadRadius: 8,
                                                      blurRadius: 8,
                                                      offset: Offset(0, 0),
                                                    ),
                                                  ]
                                                : position == 2
                                                    ? [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              0xA6,
                                                              0xA6,
                                                              0xA6,
                                                              0.3),
                                                          spreadRadius: 8,
                                                          blurRadius: 8,
                                                          offset: Offset(0, 0),
                                                        ),
                                                      ]
                                                    : position == 3
                                                        ? [
                                                            BoxShadow(),
                                                          ]
                                                        : [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.2),
                                                              spreadRadius: 2,
                                                              blurRadius: 4,
                                                            ),
                                                          ],
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02, // тут уменьшила паддинг, чтобы кружочки были ближе к левому краю ка в фигме
                                          ),
                                          child: Row(
                                            spacing: 10,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor:
                                                        position <= 3
                                                            ? the_color
                                                            : Color.fromRGBO(
                                                                1, 27, 42, 1),
                                                    child: Text(
                                                        position.toString(),
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                    radius: 20,
                                                  ),
                                                  // тут цвета обводки для кружочков (также для каждого индекса свой где первые три)
                                                  Container(
                                                    width: 40,
                                                    height: 40,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: position <= 3
                                                          ? Border.all(
                                                              color: position ==
                                                                      1
                                                                  ? Color
                                                                      .fromRGBO(
                                                                          0xD5,
                                                                          0xAC,
                                                                          0x37,
                                                                          1.0)
                                                                  : position ==
                                                                          2
                                                                      ? Color.fromRGBO(
                                                                          0xA6,
                                                                          0xA6,
                                                                          0xA6,
                                                                          1.0)
                                                                      : Color.fromRGBO(
                                                                          0xC4,
                                                                          0x7D,
                                                                          0x40,
                                                                          1.0),
                                                              width: 2.0,
                                                            )
                                                          : Border.all(
                                                              color: Color(
                                                                  0xFF11A8FD), // Синяя обводка для 4+ строк
                                                            ),
                                                      boxShadow: position <=
                                                                  3 &&
                                                              position > 1
                                                          ? [
                                                              BoxShadow(
                                                                color: position ==
                                                                        2
                                                                    ? Color.fromRGBO(
                                                                        0xA6,
                                                                        0xA6,
                                                                        0xA6,
                                                                        0.3)
                                                                    : Color.fromRGBO(
                                                                        0xC4,
                                                                        0x7D,
                                                                        0x40,
                                                                        0.3),
                                                                spreadRadius: 8,
                                                                blurRadius: 8,
                                                                offset: Offset(
                                                                    0, 0),
                                                              ),
                                                            ]
                                                          : [],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              _RatingRowIndicators(),
                                              Spacer(),
                                              Stack(
                                                children: [
                                                  //тут добавила контейнер с тенью-свечением под сундучком
                                                  Container(
                                                    width: 24,
                                                    height: 24,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color(
                                                                  0xFF11A8FD)
                                                              .withOpacity(0.3),
                                                          spreadRadius: 8,
                                                          blurRadius: 12,
                                                          offset: Offset(0, 0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  CircleAvatar(
                                                    radius: 16,
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    child: Image.asset(
                                                        'assets/images/chest.png'),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                child: Text(
                                                  "900",
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      }))))
                        ]))))));
  }
}

class _RatingRowIndicators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text(generateRandomNickname(),
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.03,
                fontWeight: FontWeight.w700,
              )),
        ),

        //width: 10, height: 10, color: Colors.blue),
      ],
    );
  }
}

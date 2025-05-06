import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/sliders_screenAlpha.dart';
import 'package:flutter_application_1/sliders_screenBeta.dart';
import 'package:flutter_application_1/widgets/animated_widgets.dart';
import 'package:flutter_application_1/widgets/drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'widgets/drawer.dart' as myDrawer;
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
          backgroundColor: Colors.black,
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
        ),
        drawer: myDrawer.myDrawer(),
        backgroundColor: Colors.black,
        body: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Первый элемент
                        CircleAvatar(
                            backgroundColor: Color.fromRGBO(15, 34, 56, 1),
                            child: Icon(Icons.arrow_back_ios),
                            radius: 32),
                        SizedBox(width: 8, height: 52),

                        // Второй элемент
                        Text("Профиль"),

                        // Гибкое пространство между вторым и третьим элементом
                        Spacer(),

                        // Третий элемент (прижат вправо)
                        CircleAvatar(
                            child: Image.asset(
                              'assets/images/location.png',
                              width: 30,
                            ),
                            radius: 32), // Image radius 36 diameeter 72
                      ],
                    ),
                    SizedBox(height: 20),
                    _ProfileCard(),
                    SizedBox(height: 10),
                    LinearChart(),
                    SizedBox(height: 20),
                    /* Container(
                      //   width: 128,
                      height: 7.06,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        child: LinearProgressIndicator(
                          value: 0.7,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xff209FFF)),
                          backgroundColor: Color(0xff282C30),
                        ),
                      ),
                    ),*/
                    SizedBox(height: 20),
                    _StatsRow(),
                    SizedBox(height: 20),
                    //  _CoinsRow(),
                    SizedBox(height: 20),
                    _LargeProfileAvatar(),
                    SizedBox(height: 20),
                    Text(
                      "Моя коллекция",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    SizedBox(height: 20),
                    _CollectionRow(),
                    SliderScreen(),
                    _BottomRow()
                  ],
                ),
              ),
            )));
  }
}

// Отдельные виджеты:

class _BottomRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        // width: 500,
        height: 100,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05),
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Stack(children: [
              CircleAvatar(
                  radius: 30, // Общий размер круга
                  backgroundColor: Color.fromRGBO(15, 34, 56, 1),
                  //  foregroundImage: AssetImage('images/iconunderphone1.png'),
                  backgroundImage: AssetImage('assets/images/logoK.png')),
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
                      )),
                      backgroundImage: AssetImage('assets/images/Star1.png'))),
            ]),
            _BottomRowIndicators(),

            Spacer(),
            ObmenButton()
            // myDrawer.DrawerButton(buttonText: "обмен"),
          ],
        ));
  }
}

Widget ObmenButton() {
  return AnimatedContainer(
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
    child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.zero,
          minimumSize: Size(
            150,
            50,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        onPressed: () {},
        child: Text(
          'Oбмен',
          style: TextStyle(
            fontFamily: 'Lato',
            fontWeight: FontWeight.w500,
            fontSize: 16,
            height: 1.0,
            letterSpacing: 0.0,
            color: Colors.white,
          ),
        ),
      )
    ]),
  );
}

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Colors.black,
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          _ProfileAvatar(size: 125),
          SizedBox(width: 10),
          _ProfileInfo(),
        ],
      ),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  final double size;

  const _ProfileAvatar({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: CircleAvatar(
        radius: 32, // Image radius 36 diameeter 72
        // here local image assets/images/avatar.png
        backgroundImage: const AssetImage('assets/images/avatar.png'),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
        border: Border.all(color: Colors.white, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      // Можно добавить изображение вместо цвета
    );
  }
}

class _ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Джек!"),
        SizedBox(height: 5),
        _FollowersInfo(),
        SizedBox(height: 10),
        _FriendAvatars(),
      ],
    );
  }
}

class _FollowersInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [Text("a"), Text("followers"), Text("b|"), Text("Following")],
    );
  }
}

class _FriendAvatars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20, // Общий размер круга
          backgroundColor: Color.fromRGBO(15, 34, 56, 1),
          //  foregroundImage: AssetImage('images/iconunderphone1.png'),
          child: ClipOval(
            child: SizedBox(
              width: 15, // Ширина изображения (вдвое меньше общего диаметра)
              height: 15,
              child: Image.asset(
                'assets/images/iconunderphone1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        CircleAvatar(
          radius: 20, // Общий размер круга
          backgroundColor: Color.fromRGBO(15, 34, 56, 1),
          //  foregroundImage: AssetImage('images/iconunderphone1.png'),
          child: ClipOval(
            child: SizedBox(
              width: 15, // Ширина изображения (вдвое меньше общего диаметра)
              height: 15,
              child: Image.asset(
                color: Colors.blue,
                'assets/images/iconunderphone2.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        SizedBox(width: 5),
        CircleAvatar(
          radius: 20, // Общий размер круга
          backgroundColor: Color.fromRGBO(15, 34, 56, 1),
          //  foregroundImage: AssetImage('images/iconunderphone1.png'),
          child: ClipOval(
            child: SizedBox(
              width: 15, // Ширина изображения (вдвое меньше общего диаметра)
              height: 15,
              child: Image.asset(
                color: Colors.blue,
                'assets/images/iconunderphone3.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _StatCardLeft(width: 167),
        _StatCardRight(width: 143),
      ],
    );
  }
}

class _StatCardLeft extends StatelessWidget {
  final double width;

  const _StatCardLeft({required this.width});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: width,
      height: 85,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 2, 14, 24),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Color(0xFF11A8FD), width: 2),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF11A8FD).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StatIndicatorsLeft(), //пазл и +4
          SizedBox(height: 10),
          _StatMainIndicatorLeft(), //текст под
        ],
      ),
    );
  }
}

class _StatCardRight extends StatelessWidget {
  final double width;

  const _StatCardRight({required this.width});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      width: width,
      height: 85,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 2, 14, 24),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Color(0xFF11A8FD), width: 2),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF11A8FD).withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _StatIndicatorsRight(), //coin и ...
          SizedBox(height: 10),
          _StatMainIndicatorRight(), //текст под
        ],
      ),
    );
  }
}

class _StatIndicatorsLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 20),
        Image.asset(
          'assets/images/puzzle.png',
          width: 30,
        ),
        SizedBox(width: 10),
        Text("+4")
//        Container(width: 10, height: 10, color: Colors.blue),
      ],
    );
  }
}

class _StatIndicatorsRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 20),
        Image.asset(
          'assets/images/coin_mid.png',
          width: 30,
        ),
        SizedBox(width: 10),
        Text("+600")
//        Container(width: 10, height: 10, color: Colors.blue),
      ],
    );
  }
}

class _StatMainIndicatorLeft extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Пазлов до следующего \n уровня",
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}

class _StatMainIndicatorRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Монет в час",
          style: TextStyle(fontSize: 10),
        )
      ],
    );
  }
}
/*
class _CoinsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Image.asset('assets/images/coin_mid.png'),
        _CoinsIndicators(),
        Spacer(),
        Container(child: Text("5000")),
      ],
    );
  }
}*/

class _CollectionRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 500,
      height: 100,

      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Color.fromRGBO(1, 59, 92, 1),
        //border: Border.all(color: Colors.blue),
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
                radius: 30,
                backgroundImage: AssetImage('assets/images/slider2.png')),
            _CollectionRowIndicators(),
            Spacer(),
            CircleAvatar(
                backgroundColor: Colors.blue,
                child: Icon(Icons.currency_ruble)),
            Container(
                child: Text(
              "10 000",
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.w700,
              ),
            )),
            CircleAvatar(
                backgroundColor: Color.fromRGBO(1, 59, 92, 1),
                radius: 20,
                // backgroundColor: Colors.blue,
                child: Center(
                    child: Image.asset(
                  width: 15,
                  'assets/images/arrowRight.png',
                ))),
          ]),
    );
  }
}

class _CollectionRowIndicators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text("Император",
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.03,
                fontWeight: FontWeight.w700,
              )),
        ),
        SizedBox(height: 5),
        Container(
            child: Text("5 DiWo Art",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                )))

        //width: 10, height: 10, color: Colors.blue),
      ],
    );
  }
}

class _BottomRowIndicators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            child: Text("DiWo Art",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontWeight: FontWeight.w700,
                ))),
        SizedBox(height: 5),
        Container(
            child: Text("Император",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontWeight: FontWeight.w700,
                ))),
        //width: 10, height: 10, color: Colors.blue),
      ],
    );
  }
}

class _LargeProfileAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/chest_bg.png',
            width: 220.3, height: 220.3), // 120-108
        Image.asset('assets/images/chest.png',
            width: 65.15, height: 59.45), // 108.98+11.32=120.3
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
      ],
    ));
  }
}

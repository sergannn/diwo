import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/bottom_bar.dart';
import 'package:flutter_application_1/widgets/sliders_screenAlpha.dart';
import 'package:flutter_application_1/utils/auth/auth.dart';
import 'package:flutter_application_1/widgets/animated_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import '/widgets/drawer.dart' as myDrawer;
import 'package:percent_indicator/percent_indicator.dart';

import '/widgets/coins_timer.dart';
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
  int _balance = 5060;
  @override
  Widget build(BuildContext context) {
//    _balance = 10;
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: bottomBar(context),

        /*  appBar: AppBar(
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
        drawer: myDrawer.myDrawer(context),
        backgroundColor: Color(0xFF020E18),
        body: DefaultTextStyle(
            style: TextStyle(color: Colors.white),
            child: Container(
                padding: EdgeInsets.only(
                    top: 30), //bottom: kBottomNavigationBarHeight * 2),
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 64,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Первый элемент
                              GestureDetector(
                                  child: CircleAvatar(
                                    backgroundColor: Color(0xFF162E3F),
                                    radius:
                                        26, // размер 52 делится на 2 для радиуса
                                    child: Icon(Icons.arrow_back_ios_new,
                                        color: Color(0xFF209FFF)),
                                  ),
                                  onTap: () {
                                    // closeDrawer();
                                    Navigator.pop(context);
                                  }),
                              SizedBox(width: 17, height: 52),
                              // Второй элемент
                              SizedBox(width: 6),
                              Text(
                                "Профиль",
                                style: GoogleFonts.montserrat(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600, // Semibold
                                  color: Colors.white,
                                ),
                              ),
                              // Гибкое пространство между вторым и третьм элементом
                              Spacer(),
                              // Третий элемент (прижат вправо)
                              GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Color(0xFF209FFF),
                                        width: 1.4,
                                      ),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF209FFF)
                                              .withOpacity(0.5),
                                          spreadRadius: 8,
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xFF162E3F),
                                      radius: 26,
                                      child: ClipOval(
                                        child: SizedBox(
                                          width: 30,
                                          height: 40,
                                          child: Image.asset(
                                            'assets/images/location.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pop(context);
                                    //       Navigator.pushReplacementNamed(
                                    //            context, '/MapBoxExample');
//   openDrawer();
                                  }),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        _ProfileCardK(),
                        SizedBox(height: 2),
                        LinearChartK(),
                        SizedBox(height: 20),
                        // SizedBox(height: 20),
                        _StatsRowDeepSeek(),
                        SizedBox(height: 40),
                        /*  Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  colors: [
                                    Colors.red,
                                    Colors.blue.withOpacity(0.5)
                                  ]),
                              shape: BoxShape.circle),
                          child: Center(
                              child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: Colors.green),
                            child: Center(
                              child: Text(
                                "230 Cal",
                                style:
                                    TextStyle(fontSize: 10, color: Colors.blue),
                              ),
                            ),
                          )),
                        ),
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                // progress:
                                value: 40, // 30%
                                strokeWidth: 3,
                                backgroundColor: Colors.grey.withOpacity(0.2),
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.red),
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                ),
                                child: Center(
                                  child: Text(
                                    "230 Cal",
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.blue),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),*/
                        // _PotentialCoinsIndicator(),
                        /*  CircularPercentIndicator(
                          radius: 60.0,
                          lineWidth: 5.0,
                          percent: 0.5,
                          center: new Text("100%"),
                          progressColor: Colors.green,
                        ),*/

                        LargeProfileAvatar(
                          balance: _balance,
                        ),
                        SizedBox(height: 40),
                        Text(
                          "Моя коллекция",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        SizedBox(height: 40),
                        _CollectionRow(),
                        SliderScreen(),
                        _BottomRow()
                      ],
                    ),
                  ),
                ))));
  }
}

class _PotentialCoinsIndicator extends StatefulWidget {
  @override
  _PotentialCoinsIndicatorState createState() =>
      _PotentialCoinsIndicatorState();
}

class _PotentialCoinsIndicatorState extends State<_PotentialCoinsIndicator> {
  Timer? _timer;
  Duration _duration = Duration(minutes: 5, seconds: 59); // Initial 5:50
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_isRunning) return;

      setState(() {
        if (_duration.inSeconds > 0) {
          _duration = _duration - Duration(seconds: 1);
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _toggleTimer() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  double _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return duration.inSeconds as double;
    //return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Convert 6 hours to seconds (max duration)
    final maxDurationInSeconds = 60; // * 60 * 60; // 6 hours = 21600 seconds

    // Calculate percentage (0.0 to 1.0)
    var percent = _duration.inSeconds / maxDurationInSeconds;
    print(percent);
    // Ensure percentage stays within bounds
    final clampedPercent = percent.clamp(0.0, 1.0);

    return GestureDetector(
        child: CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 5.0,
          percent: clampedPercent,
          center: Text("${(clampedPercent * 100).toStringAsFixed(1)}%"),
          progressColor: Colors.blue,
        ),
        onTap: () {
          setState(() {
            _duration = Duration(minutes: 5, seconds: 59); // Initial 5:50
            percent = 0;
          });
        });
  }
}

class _ProfileCardK extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        color: Color(0xFF020E18),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF020E18),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          _ProfileAvatarK(size: 80),
          SizedBox(width: 30),
          _ProfileInfoK(),
        ],
      ),
    );
  }
}
// Отдельные виджеты:

class _ProfileAvatarK extends StatelessWidget {
  final double size;

  const _ProfileAvatarK({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Color(0xFF209FFF).withOpacity(0.5),
            spreadRadius: 8,
            blurRadius: 14,
          ),
        ],
      ),
      child: CircleAvatar(
        backgroundColor: Colors.blue,
        radius: 32,
        backgroundImage: const AssetImage('assets/images/avatar.png'),
      ),
    );
  }
}

class _ProfileInfoK extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        StorageService.getUsername(),
        StorageService.getPhone(),
      ]),
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator
        }

        final username = snapshot.data?[0] ?? "Logist_8888"; // Default value
        final phone = snapshot.data?[1] ?? ""; // Will be used in _FollowersInfo

        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              username,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5),
            _FollowersInfo(phone: phone),
            SizedBox(height: 10),
            _FriendAvatarsK(),
          ],
        );
      },
    );
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

/*
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
        _FriendAvatarsK(),
      ],
    );
  }
}*/
class _FollowersInfo extends StatelessWidget {
  final String phone;

  const _FollowersInfo({required this.phone});

  @override
  Widget build(BuildContext context) {
    // Format phone number if needed
    String formattedPhone = phone.isNotEmpty
        ? phone.replaceAllMapped(RegExp(r'(\d{1})(\d{3})(\d{3})(\d{2})(\d{2})'),
            (Match m) => '${m[1]} (${m[2]}) ${m[3]} ${m[4]} ${m[5]}')
        : "Phone not available";

    return Row(
      children: [
        Text(
          formattedPhone,
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }
}

class _FriendAvatarsK extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 57,
          height: 45,
          decoration: BoxDecoration(
            color: Color(0xFF0F2238),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: SizedBox(
                width: 22, // ширина
                height: 20, // размер по высоте
                child: Image.asset(
                  'assets/images/iconunderphone1.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 57,
          height: 45,
          decoration: BoxDecoration(
            color: Color(0xFF0F2238),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: ClipRRect(
              child: SizedBox(
                height: 20, // размер по высоте
                child: Image.asset(
                  'assets/images/iconunderphone2.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 57,
          height: 45,
          decoration: BoxDecoration(
            color: Color(0xFF0F2238),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Center(
            child: ClipRRect(
              child: SizedBox(
                height: 22, // размер по высоте
                child: Image.asset(
                  'assets/images/iconunderphone3.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _StatsRowDeepSeek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Take full available width
      padding: EdgeInsets.symmetric(horizontal: 20), // Match parent padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distribute space
        children: [
          _StatCardLeft(width: 167),
          _StatCardRight(width: 143),
        ],
      ),
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
          'assets/images/coin.png',
          width: 20,
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
          style: TextStyle(
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500,
              fontSize: 11,
              color: Colors.white.withOpacity(0.5)),
        )
      ],
    );
  }
}

class _StatMainIndicatorRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(width: 21),
        Text("Монет в час",
            style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
                fontSize: 11,
                color: Colors.white.withOpacity(0.5)))
      ],
    );
  }
}

class _CollectionRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 500,
      height: 53,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(23)),
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
                radius: 20,
                backgroundImage: AssetImage('assets/images/slider3.png')),
            _CollectionRowIndicators(),
            Spacer(),
            CircleAvatar(
                radius: 12,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.currency_ruble,
                  size: 16,
                )),
            Container(
                child: Text(
              "9 000",
              style: GoogleFonts.montserrat(
                fontSize: 16,
                fontWeight: FontWeight.w600, // Semibold
                color: Colors.white,
              ),
            )),
            Container(
                width: 10,
                height: 18,
                child: Image.asset('assets/images/arrowRight.png'))
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

/*

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

class _CollectionRowS extends StatelessWidget {
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
class _LargeProfileAvatarOld extends StatefulWidget {
  @override
  _LargeProfileAvatarOldState createState() => _LargeProfileAvatarOldState();
}

class _LargeProfileAvatarOldState extends State<_LargeProfileAvatarOld> {
  Timer? _timer;
  Duration _duration = Duration(minutes: 5, seconds: 50); // Initial 5:50
  bool _isRunning = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (!_isRunning) return;

      setState(() {
        if (_duration.inSeconds > 0) {
          _duration = _duration - Duration(seconds: 1);
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  void _toggleTimer() {
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleTimer,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 5.0,
              percent: _duration.inSeconds.toDouble() / 100, //.clamp(0.0, 1.0),
              center: Text("${(_duration * 100).toString()}%"),
              progressColor: Colors.red,
            ),
            Image.asset(
              'assets/images/chest_bg.png',
              width: 220.3,
              height: 220.3,
            ),
            Image.asset(
              'assets/images/chest.png',
              width: 65.15,
              height: 59.45,
            ),
            Padding(
              padding: EdgeInsets.only(top: 140.0),
              child: Text(
                _formatDuration(_duration),
                style: TextStyle(
                  fontSize: 16.98,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/

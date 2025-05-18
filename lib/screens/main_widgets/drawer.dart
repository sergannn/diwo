import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/timer/timer.dart';
import 'package:provider/provider.dart';

Widget myDrawer(context) {
  return Drawer(
    backgroundColor: Colors.transparent,
    child: Center(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
          child: Container(
            padding: EdgeInsets.only(left: 16, right: 22),
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5)),
            child: Column(
              children: [
                const SizedBox(height: 64.59),
                GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/profileScreenSer');
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 8.0),
                      width: double.infinity,
                      child: Row(
                        children: [
                          // without gradient
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 5.0, right: 31.0),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    const Color(0xFF000000),
                                    const Color(0xFF014984),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(45),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF11A8FD).withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 15,
                                    offset: const Offset(0, 0),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 36, // Image radius 36 diameeter 72
                                // here local image assets/images/avatar.png
                                backgroundImage: const AssetImage(
                                    'assets/images/avatar.png'),
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
                                  Image.asset('assets/images/coin.png',
                                      width: 21, height: 21),
                                  const SizedBox(width: 5.19),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3.0),
                                    child: Consumer<CountdownTimer>(
                                      builder: (context, timer, child) {
                                        return Text(timer.balance.toString(),
                                            style: TextStyle(
                                              // Roboto
                                              fontSize: 13.37,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ));
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.0),
                              Container(
                                width: 128,
                                height: 7.06,
                                child: const ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                  child: LinearProgressIndicator(
                                    value: 0.7,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xff209FFF)),
                                    backgroundColor: Color(0xff282C30),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 45.97),
                const DrawerButton(
                  buttonText: 'Коллекции пазлов',
                  image: 'assets/images/collectionpuzzles.png',
                  routeName: '/collectionsP',
                ),
                SizedBox(height: 28.61),
                const DrawerButton(
                  buttonText: 'Коллекции DiWo',
                  image: 'assets/images/collectionsdiwo.png',
                  routeName: '/collectionsD',
                ),
                SizedBox(height: 28.61),
                const DrawerButton(
                  buttonText: 'Рейтинг DiWo',
                  image: 'assets/images/rating.png',
                  routeName: '/rating',
                ),
                SizedBox(height: 28.61),
                const DrawerButton(
                  buttonText: 'Настройки',
                  image: 'assets/images/settings.png',
                  routeName: '/settings',
                ),
                /*   Consumer<CountdownTimer>(
                  builder: (context, timer, child) {
                    return Column(
                      children: [
                        Text('${timer.remainingSeconds} сек',style:TextStyle(color:Colors.white)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: timer.isRunning
                                  ? timer.stopTimer
                                  : timer.startTimer,
                              icon: Icon(timer.isRunning
                                  ? Icons.pause
                                  : Icons.play_arrow),
                            ),
                            IconButton(
                              onPressed: timer.resetTimer,
                              icon: const Icon(Icons.replay),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),*/
                Consumer<CountdownTimer>(builder: (context, timer, child) {
                  return GestureDetector(
                      onTap: () {
                        final collected = timer.collectCoins();
                        if (collected > 0) {
                          timer.addToBalance(collected);
                        }
                      },
                      child: Container(
                          width: double.infinity,
                          child: Stack(alignment: Alignment.center, children: [
                            Image.asset('assets/images/chest_bg.png',
                                width: 220.3, height: 220.3), // 120-108
                            Image.asset('assets/images/box.png',
                                width: 65.15,
                                height: 59.45), // 108.98+11.32=120.3

                            Padding(
                              padding: EdgeInsets.only(top: 150.0),
                              child: Text(timer.formattedDuration,
                                  style: TextStyle(
                                    // Urbanist
                                    fontSize: 16.98,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  )),
                            )
                          ])));
                }),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class DrawerButton extends StatelessWidget {
  const DrawerButton({
    super.key,
    required this.buttonText,
    this.image = '',
    required this.routeName, // Новый параметр для хранения имени маршрута
  });

  final String buttonText;
  final String image;
  final String routeName;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) {
              //  onPressed: () {
              Navigator.pushNamed(context, routeName);
              //  },
            },
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
                border: Border(
                  top: BorderSide(
                      color: Color(0xFF11A8FD),
                      width: 2), // Толстая верхняя граница
                  bottom: BorderSide(
                      color: Color(0xFF11A8FD),
                      width: 2), // Толстая нижняя граница
                  left: BorderSide(
                      color: Color(0xFF11A8FD),
                      width: 4), // Тонкая левая граница
                  right: BorderSide(
                      color: Color(0xFF11A8FD),
                      width: 4), // Тонкая правая граница
                ),
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF11A8FD).withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 10,
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                SizedBox(width: 5),
                image == ''
                    ? Container()
                    : Container(
                        decoration: BoxDecoration(
                            // color: Colors.grey,
                            border: Border.all(
                                color: Colors.brown.withOpacity(0.2), width: 4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(45))),
                        child: CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 30, // Adjust size
                          //backgroundColor: Colors.red,
//                            .transparent, // Or your desired background color
                          child: Container(
                            decoration: BoxDecoration(
                              //   color: Colors.red,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.blue,
                                    blurRadius: 12,
                                    spreadRadius: 8.5)
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(45)),
                            ),
                            // This ensures the image is centered
                            child: Image.asset(
                              image,
                              width:
                                  15, // Adjust image size (smaller than CircleAvatar)
                              height: 15,
                            ),
                          ),
                        )),
                SizedBox(width: 15),
              Text(
                    buttonText,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 1.0,
                      letterSpacing: 0.0,
                      color: Colors.white,
                    ),
                  
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

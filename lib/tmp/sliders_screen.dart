import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/drawer.dart';

//import 'package:yandex_maps_mapkit/yandex_maps_mapkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: SliderScreen()));
}

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Image.asset('assets/images/bottom_bar.png'),
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
      drawer: myDrawer(context),
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 5),
          child: Column(
            children: [
              Container(
                height: 500,
                width: double.infinity,
                child: Stack(
                  children: [
                    Transform.translate(
                        offset: Offset(50, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Card(
                            image: Image.asset(
                              'assets/images/slider1.png',
                              width: 135.98,
                              height: 170.0,
                              fit: BoxFit.cover,
                            ),
                            price: '2 000',
                            profit: '60',
                            backgroundColor: Color(0xFF13222B).withOpacity(0),
                            heightBetween: 10.25,
                            boxShadows: [
                              BoxShadow(
                                color: Color(0xFF262E32).withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 14.52,
                                offset: const Offset(-5, -5),
                              ),
                              BoxShadow(
                                color: Color(0xBF101012).withOpacity(0.5),
                                spreadRadius: 8,
                                blurRadius: 19.36,
                                offset: const Offset(3.87, 3.87),
                              ),
                            ],
                          ),
                        )),
                    Transform.translate(
                        offset: Offset(-50, 0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Card(
                            image: Image.asset(
                              'assets/images/slider3.png',
                              width: 135.98,
                              height: 170.0,
                              fit: BoxFit.cover,
                            ),
                            price: '2 000',
                            profit: '60',
                            backgroundColor: Color(0xFF13222B),
                            heightBetween: 10.25,
                            boxShadows: [
                              BoxShadow(
                                color: Color(0xFF262E32).withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 14.52,
                                offset: const Offset(-5, -5),
                              ),
                              BoxShadow(
                                color: Color(0xBF101012).withOpacity(0.5),
                                spreadRadius: 8,
                                blurRadius: 19.36,
                                offset: const Offset(3.87, 3.87),
                              ),
                            ],
                          ),
                        )),
                    Transform.scale(
                      scale: 1.2,
                      child: Align(
                        alignment: Alignment.center,
                        child: Card(
                          image: Image.asset(
                            'assets/images/slider2.png',
                            width: 135.98,
                            height: 170.0,
                            fit: BoxFit.cover,
                          ),
                          price: '2 000',
                          profit: '60',
                          backgroundColor: Color(0xFF020E19),
                          heightBetween: 18,
                          boxShadows: [
                            BoxShadow(
                              color: Color(0xFF209FFF).withOpacity(0.5),
                              spreadRadius: 8,
                              blurRadius: 40,
                              offset: const Offset(3, 3),
                            ),
                            BoxShadow(
                              color: Color(0xFF262E32).withOpacity(0.5),
                              spreadRadius: 0,
                              blurRadius: 14.52,
                              offset: const Offset(-2.9, -2.9),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
/*
  Widget myDrawer() {
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
                  Container(
                    padding: EdgeInsets.only(top: 8.0),
                    width: double.infinity,
                    child: Row(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 5.0, right: 31.0),
                          child: Container(
                            child: CircleAvatar(
                              radius: 36,
                              backgroundImage:
                                  const AssetImage('assets/images/avatar.png'),
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
                                Image.asset('assets/images/coin.png',
                                    width: 21, height: 21),
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
                        Image.asset('assets/images/chest_bg.png',
                            width: 220.3, height: 220.3),
                        Image.asset('assets/images/chest.png',
                            width: 65.15, height: 59.45),
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }*/
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.image,
    required this.price,
    required this.profit,
    required this.backgroundColor,
    required this.boxShadows,
    required this.heightBetween,
  });

  final Widget image;
  final String price;
  final String profit;
  final Color backgroundColor;
  final List<BoxShadow> boxShadows;
  final double heightBetween;

  @override
  Widget build(BuildContext context) {
    return HighlitedFrame(
      width: 161.98,
      height: 288.0,
      border: Border.all(
        color: Color(0xFF424750),
        width: 0.5,
      ),
      backgroundColor: backgroundColor,
      boxShadows: boxShadows,
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              image,
              SizedBox(
                height: heightBetween,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                  color: Color(0xFF1A2A34),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 11, horizontal: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(),
                          ),
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Color(0xFF209FFF),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 2),
                              child: Text(
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF1A2A34),
                                  ),
                                  '₽'),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                              style: TextStyle(
                                // Inter
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              price),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            style: TextStyle(
                              // Montserrat
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1BEFFE),
                            ),
                            'Монет в час',
                          ),
                          SizedBox(width: 5),
                          Image.asset('assets/images/coin_mid.png',
                              width: 20, height: 20),
                          Text(
                            style: TextStyle(
                              // Roboto
                              fontSize: 13.07,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            '+',
                          ),
                          Text(
                            style: TextStyle(
                              // Roboto
                              fontSize: 13.07,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                            profit,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HighlitedFrame extends StatelessWidget {
  HighlitedFrame({
    super.key,
    required this.width,
    required this.height,
    required this.border,
    required this.child,
    required this.backgroundColor,
    required this.boxShadows,
  });

  final double width;
  final double height;
  final Border border;
  final Color backgroundColor;
  final List<BoxShadow> boxShadows;

  var child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
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
              decoration: BoxDecoration(
                color: this.backgroundColor,
                border: this.border,
                borderRadius: BorderRadius.circular(26),
                boxShadow: this.boxShadows,
              ),
              child: this.child,
            ),
          ),
        ],
      ),
    );
  }
}

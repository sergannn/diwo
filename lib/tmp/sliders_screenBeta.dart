/*import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:overlapped_carousel/overlapped_carousel.dart';

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
  int _currentIndex = 1; // Start with the center item selected
  final List<String> imgList = ['peter_1.png', 'peter_1.png', 'peter_1.png'];
// Generate card widgets for the carousel
  List<Widget> get _cardWidgets => imgList
      .map(
        (item) => Container(
          width: 329.1,
          height: 276.0,
          child: Column(
            children: [
              Card(
                image: Image.asset('images/peter_1.png', width: 135.98, height: 170.0),
                price: '2 000',
                profit: '60',
              ),
            ],
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: min(screenWidth / 3.3 * (16 / 9), screenHeight * 0.9),
              child: OverlappedCarousel(
                widgets: _cardWidgets,
                currentIndex: _currentIndex,
                onClicked: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                // Make adjacent cards darker/more transparent
                obscure: 0,
                // Control the skew angle for 3D effect
                skewAngle: 0.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Your card widget slightly modified to fit the carousel styling
class CardWidget extends StatelessWidget {
  final Image image;
  final String price;
  final String profit;

  const CardWidget({
    Key? key,
    required this.image,
    required this.price,
    required this.profit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 161.98,
      height: 288.0,
      decoration: BoxDecoration(
        color: const Color(0xFF020E19),
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF209FFF).withOpacity(0.5),
            spreadRadius: 8,
            blurRadius: 59.9,
            offset: const Offset(3, 3),
          ),
          BoxShadow(
            color: Color(0xFF262E32).withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 14.52,
            offset: const Offset(-2.9, -2.9),
          ),
        ],
        border: Border.all(color: Color(0xFF424750), width: 0.5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              image,
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xFF1A2A34),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(child: Container()),
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: Color(0xFF209FFF),
                            child: Text(
                              '₽',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A2A34),
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            price,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Монет в час',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF1BEFFE),
                            ),
                          ),
                          SizedBox(width: 5),
                          Image.asset('images/coin_mid.png', width: 20, height: 20),
                          Text(
                            '+',
                            style: TextStyle(
                              fontSize: 13.07,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            profit,
                            style: TextStyle(
                              fontSize: 13.07,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
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

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.image,
    required this.price,
    required this.profit,
  });

  final Image image;
  final String price;
  final String profit;

  @override
  Widget build(BuildContext context) {
    return HighlitedFrame(
      width: 161.98,
      height: 288.0,
      border: Border.all(color: Color(0xFF424750), width: 0.5),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(25.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              image,
              const SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Color(0xFF1A2A34),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 11, horizontal: 14),
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
                            child: Text(
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A2A34),
                                ),
                                '₽'),
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
                          Image.asset('images/coin_mid.png', width: 20, height: 20),
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
// Keep HighlitedFrame and DrawerButton classes from original code

class HighlitedFrame extends StatelessWidget {
  HighlitedFrame({
    super.key,
    required this.width,
    required this.height,
    required this.border,
    required this.child,
  });

  final double width;
  final double height;
  final Border border;

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
                color: Color(0xFF020E19),
                border: this.border,
                borderRadius: BorderRadius.circular(26),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF209FFF).withOpacity(0.5),
                    spreadRadius: 8,
                    blurRadius: 59.9,
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
              child: this.child,
            ),
          ),
        ],
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
*/

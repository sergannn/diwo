import 'dart:ui';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

//import 'package:yandex_maps_mapkit/yandex_maps_mapkit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(home: SliderScreen()));
}

final List<String> imgList = ['1', '2', '3', '4'];

final List<Widget> imageSliders = imgList
    .map(
      (item) => Container(
        width: 329.1,
        height: 300.0,
        child: Column(
          children: [
            Card(
              image: Image.asset(
                'assets/images/slider1.png',
                width: 135.98,
              ),
              price: 'Beta test', //изменила вместо "2 000"
              profit: '100', //изменила вместо 60
            ),
          ],
        ),
      ),
    )
    .toList();

class SliderScreen extends StatefulWidget {
  const SliderScreen({super.key});

  @override
  State<SliderScreen> createState() => _SliderScreenState();
}

class _SliderScreenState extends State<SliderScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SizedBox(height: 120),
        Container(
          height: 400,
          width: double.infinity,
          child: CarouselSlider(
            options: CarouselOptions(
              aspectRatio: 9 / 16,
              viewportFraction: 0.5,
              enableInfiniteScroll: true,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              enlargeFactor: 0.3,
              autoPlay: false,
            ),
            items: imageSliders,
          ),
        ),
      ],
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
                                fontSize: 14,
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
                              fontWeight: FontWeight.w500, //изменила с 400
                              color: Color(0xFF1BEFFE),
                            ),
                            'Монет в час',
                          ),
                          SizedBox(width: 3), //изменила с 5
                          Image.asset('assets/images/coin_mid.png',
                              width: 20, height: 20),
                          Text(
                            style: TextStyle(
                              // Roboto
                              fontSize: 12,
                              fontWeight: FontWeight.w500, //изменила с 400
                              color: Colors.white,
                            ),
                            '+',
                          ),
                          Text(
                            style: TextStyle(
                              // Roboto
                              fontSize: 12, //изменила с 13.07
                              fontWeight: FontWeight.w700, //изменила с 400
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
/*
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

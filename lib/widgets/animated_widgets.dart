import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

const List latestWorkoutJson = [
  {
    "img": "assets/images/1.png",
    "title": "Fullbody Workout",
    "description": "Пазлы 5/10",
    "progressBar": 0.3
  }
];

class LinearChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 55,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          latestWorkoutJson[0]['title'],
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(children: [
                          Text(
                            "Пазлы",
                          ),
                          SizedBox(width: 10),
                          Text(
                            "5/10",
                          )
                        ]),
                        /*  Text(
                          latestWorkoutJson[0]['description'],
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white.withOpacity(0.5)),
                        )*/
                      ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // График (занимает 60% ширины)
                      Container(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blueGrey,
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  (latestWorkoutJson[0]['progressBar']),
                              height: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                // Color(0xff282C30),
                                gradient: LinearGradient(
                                    colors: [Colors.blue, Colors.white]),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "50%",
                      )
                      // Текст "hello" справа от графика
                    ],
                  ),
                ],
              ),
            ),
          ), /*
          SizedBox(
            width: 15,
          ),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle, border: Border.all(color: Colors.red)),
            child: Center(
              child: Icon(Icons.arrow_forward_ios, size: 11, color: Colors.red),
            ),
          ),*/
        ],
      ),
    );
  }
}

class AnimatedTitle extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;

  const AnimatedTitle({
    super.key,
    required this.text,
    required this.color,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect rect) {
        return LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            color.withOpacity(0.8),
            color,
            color.withOpacity(0.8),
          ],
        ).createShader(rect);
      },
      child: Text(
        text,
        style: GoogleFonts.roboto(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class AnimatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  const AnimatedButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue,
              Colors.blueAccent,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: child,
        ),
      ),
    );
  }
}

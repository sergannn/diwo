import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/splash_screen.dart';


class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
    // Устанавливаем таймер на 3 секунды
    Timer(const Duration(seconds: 3), () {
      // Переходим на следующий экран
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         color: Color(0xFF020E18), // Прямое использование цвета
        child: Center(
          child: Image.asset(
            'assets/images/1.png',
            width: MediaQuery.of(context).size.width * 0.8, // 40% ширины экрана
            height: MediaQuery.of(context).size.width * 0.8, // Сохраняем квадратную форму
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
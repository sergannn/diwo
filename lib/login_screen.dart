import 'package:flutter/material.dart';
import 'package:flutter_application_1/profile_screen.dart';
import 'package:flutter_application_1/utils/auth/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  int _passwordLength = 0;
  var _passwordOk = 0;
  String username = '';
  String phone = '';

  String password = '';
  String password2 = '';
  bool secondTime = false;
  String mode = '';
  @override
  Widget build(BuildContext context) {
    print("mode is $mode");
    // final username = ModalRoute.of(context)?.settings.arguments as String?;
    final String receivedData =
        ModalRoute.of(context)?.settings.arguments as String;
    print(receivedData);
    username = receivedData.split('/')[0];
    phone = receivedData.split('/')[1];
    mode = receivedData.split('/')[2];
    print("mode is $mode");
    print('second time is $secondTime');
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 14, 24),
      body: SafeArea(
        child: Column(
          children: [
            // Аватар
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.blue.shade200,
                    width: 2,
                  ),
                ),
                child: Icon(
                  Icons.person,
                  color: Colors.blue.shade200,
                  size: 60,
                ),
              ),
            ),

            // Имя
            Text(
              username ?? "Неизвестный",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Пароль
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'Пароль',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    mode == 'register'
                        ? 'Задайте пароль для входа'
                        : 'Введите пароль для входа',
                    style: GoogleFonts.montserrat(
                      color: Color(0xFF7C7C7C),
                      fontSize: 14,
                    ),
                  ),

                  // Кружочки для пароля
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(4, (index) {
                        bool isFilled;
                        if (!secondTime) {
                          isFilled = password.length >
                              index; // Проверяем, заполнен ли кружочек
                        } else {
                          isFilled = password2.length > index;
                        }
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isFilled ? Color(0xFF018CFF) : Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: isFilled
                                    ? Color.fromARGB(255, 111, 190, 255)
                                        .withOpacity(
                                            0.5) // Голубое свечение для заполненных кружочков
                                    : Colors.white.withOpacity(
                                        0.5), // Белое свечение для пустых кружочков
                                blurRadius: 24, // Радиус размытия
                                spreadRadius: 10, // Радиус распространения
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  if (_passwordOk < 0)
                    Text(
                      'Попробуйте заново',
                      style: GoogleFonts.montserrat(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    ),
                  // Забыли пароль
                  if (secondTime)
                    Text(
                      'Введите второй раз',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF7C7C7C),
                        fontSize: 14,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Забыли пароль',
                      style: GoogleFonts.montserrat(
                        color: Color(0xFF7C7C7C),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Кнопки ввода пароля
                  Column(
                    children: [
                      _buildNumberRow('789'),
                      _buildNumberRow('456'),
                      _buildNumberRow('123'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(

                                  //   margin: const EdgeInsets.symmetric(
                                  //       horizontal: 6, vertical: 4),
                                  width: 89, // Устанавливаем ширину кнопки
                                  height: 62, // Устанавливаем высоту кнопки
                                  child: Center(
                                      child: Text(
                                    'Выйти',
                                    style: GoogleFonts.montserrat(
                                      color: Color(0xFF7D7D7D), // Цвет текста
                                      fontSize: 14, // Размер шрифта
                                    ),
                                  )))),
                          Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: 6, vertical: 4),
                            width: 89, // Устанавливаем ширину кнопки
                            height: 62, // Устанавливаем высоту кнопки
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(
                                      0xFF020518), // Цвет верхнего левого угла
                                  Color(
                                      0xFF061C27), // Цвет нижнего правого угла
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(32),
                              border: Border.all(
                                color: Color.fromARGB(
                                    99, 185, 185, 185), // Цвет обводки
                                width: 0.5,
                              ),
                            ),
                            child: Center(
                                child: TextButton(
                              onPressed: () {
                                numberClicked(0);
                              },
                              child: Text(
                                '0',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: 22,
                                ),
                              ),
                            )),
                          ),
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  password = '';
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: const Color.fromARGB(0, 66, 66, 66),
                                ),
                                child: const Icon(
                                  Icons
                                      .arrow_left, // Здесь заменяем на стрелку назад
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row _buildNumberRow(String numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: numbers.split('').map((number) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          width: 89, // Устанавливаем ширину кнопки
          height: 62, // Устанавливаем высоту кнопки
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF020518), // Цвет верхнего левого угла
                Color(0xFF061C27), // Цвет нижнего правого угла
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: Color.fromARGB(99, 185, 185, 185), // Цвет обводки
              width: 0.5,
            ),
          ),
          child: TextButton(
            onPressed: () async {
              await numberClicked(number);
            },
            child: Text(
              number,
              style: GoogleFonts.roboto(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  numberClicked(number) async {
    if (!secondTime) {
      // первый раз
      if (password.length < 4) {
        print("p1<4");
        password += number;
        print(password);
        print(password.length);

        setState(() {});
      }
      if (password.length == 4) {
        print("second");
        print(password);
        print("end");
        if (mode == 'login') {
          context.loaderOverlay.show();
          Map<String, dynamic> authRes =
              await AuthRepository().login(email: phone, password: password);
          context.loaderOverlay.hide();
          print(authRes);
          if (authRes['error'] != null) {
            //Unauthorized
            setState(() {
              mode = 'login';
              secondTime = false;
              _passwordOk = -1;
              password = '';
              password2 = '';
            });
          } else {
            Navigator.pushNamed(context, '/MapBoxExample');
          }
        }
        if (mode == 'register') {
          setState(() {
            secondTime = true;
          });
        }
      }
    } else {
      //второй раз
      if (password2.length < 4) {
        print("p2<4");
        password2 += number;
        print(password2);
        print(password2.length);
        setState(() {});
      }

      if (password2.length == 4) {
        print(password2);
        if (password == password2) {
          print("da, 2");
          print(username);
          print(phone);
          //           if (mode == 'register' && password.length == 4) {
          context.loaderOverlay.show();
          await AuthRepository().changePassword(username, password);
          context.loaderOverlay.hide();
          //  }
          //        AuthRepository().
          Navigator.pushNamed(context, '/MapBoxExample');
        } else {
          setState(() {
            secondTime = false;
            _passwordOk = -1;
            password = '';
            password2 = '';
            print(password);
          });
        }
      }
    }
  }
}

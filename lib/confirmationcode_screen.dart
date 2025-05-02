import 'package:flutter/services.dart'
    show
        FilteringTextInputFormatter,
        LengthLimitingTextInputFormatter,
        TextInputFormatter;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/auth/auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'animated_widgets.dart';
import 'dart:async'; // Пакет для работы с таймером

class ConfirmationCodeScreen extends StatefulWidget {
  const ConfirmationCodeScreen({super.key});

  @override
  State<ConfirmationCodeScreen> createState() => _ConfirmationCodeScreenState();
}

class _ConfirmationCodeScreenState extends State<ConfirmationCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _nicknameController = TextEditingController();

  bool _isPhoneValid = false;
  bool _isTimerActive = false;
  int _countdown = 30; // Начальное значение таймера
  bool codeOkey = false;
  bool codeFilled = false;
  Timer? _timer;
  late List<String> parts;
  @override
  void initState() {
    super.initState();
    //_startTimer(); // Запускаем таймер сразу при инициализации экрана
    /* _phoneController.addListener(() {
      setState(() {
        _isPhoneValid = _validatePhoneNumber(_phoneController.text);
      });
    });*/
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nicknameController.dispose();
    _timer?.cancel(); // Отменяем таймер, если он активен
    super.dispose();
  }

  bool _validatePhoneNumber(String value) {
    String pattern = r'^\+?7\d{10}';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  void _startTimer() {
    setState(() {
      _isTimerActive = true;
      _countdown = 30;
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        print('tik');
        /*setState(() {
          _countdown--;
        });*/
      } else {
        timer.cancel();
        /*setState(() {
          _isTimerActive = false;
        });*/
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final String receivedData =
        ModalRoute.of(context)?.settings.arguments as String;
    parts = receivedData.split('/');
    print(parts[0]);
    print(parts[1]);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 14, 24),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 600,
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Регистрация',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Image.asset('assets/images/border.png'),
                SizedBox(height: 4),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'Код подтверждения',
                            style: GoogleFonts.montserrat(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Пожалуйста, введите код из смс.',
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(211, 202, 202, 202),
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          'Отправили его вам на номер ' + (parts[0]),
                          style: GoogleFonts.montserrat(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(211, 202, 202, 202),
                          ),
                        ),
                        SizedBox(height: 50),

                        // Контейнер с вводом кода
                        _buildCodeInputContainer(),
                        SizedBox(height: 60),

                        // Таймер и кнопка "Отправить повторно"
                        _buildResendSection(),
                        if (codeFilled == true && codeOkey == false)
                          Center(
                              child: Text(
                            'Не верный пароль',
                            style: GoogleFonts.montserrat(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                          )),
                        // Эту кнопку потом отсюда надо убрать, пока тут чтобы перейти дальше
                        SizedBox(height: 100),
                        _buildButtonSection(parts[1]),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCodeInputContainer() {
    final List<TextEditingController> _controllers =
        List.generate(4, (_) => TextEditingController());
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (index) {
        return Container(
          width: 64,
          height: 42,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 2, 14, 24),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Color(0xFF11A8FD), width: 2),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF11A8FD).withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 10,
              ),
            ],
          ),
          child: Center(
              child: TextField(
            controller: _controllers[index],
            onChanged: index == 3
                ? (val) {
                    if (val.length == 1) {
                      codeFilled = true;
                      final values = _controllers
                          .map((controller) => controller.text)
                          .join('');
                      print('Combined values: $values');
                      print("is it " + parts[2] + "?");
                      if (values == parts[2]) {
                        codeOkey = true;

                        Navigator.pushNamed(context, '/login',
                            arguments: parts[0] + '/' + parts[1] + '/register');
                      } else {
                        setState(() {
                          codeOkey = false;
                          print("setting statee");
                        });
                      }

                      //      FocusScope.of(context).nextFocus();
                    }
                  }
                : (val) {
                    if (val.length == 1) {
                      FocusScope.of(context).nextFocus();
                    }
                  }, // Add this line
            style: TextStyle(color: Colors.white),
            textAlignVertical: TextAlignVertical.center,
            // expands: true,
            textAlign: TextAlign.center,
            // maxLength: null,
            keyboardType: TextInputType.number,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1),
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              //  fillColor: Colors.red,
              contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 0),
              counterText: '',
              border: InputBorder.none,
            ),
          )),
        );
      }),
    );
  }

  Widget _buildResendSection() {
    return Center(
      child: _isTimerActive
          ? Text(
              'Повторная отправка кода через $_countdown секунд',
              style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color.fromARGB(
                    204, 202, 202, 202), // Цвет с прозрачностью 80
              ),
            )
          : GestureDetector(
              onTap: () {
                _startTimer(); // Начинаем таймер при повторной отправке
                // Здесь можно добавить логику для повторной отправки кода
              },
              child: Text(
                'Отправить повторно',
                style: GoogleFonts.montserrat(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF11A8FD), // Цвет ссылки
                ),
              ),
            ),
    );
  }

  // Эту кнопку потом отсюда надо убрать, пока тут чтобы перейти дальше
  Widget _buildButtonSection(username) {
    return Column(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.black,
                Color(0xFF014984),
              ],
            ),
            border: Border.all(color: Color(0xFF11A8FD), width: 2),
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF11A8FD).withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 15,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              minimumSize: Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/login', arguments: username);
            },
            child: Text(
              'Продолжить',
              style: GoogleFonts.lato(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

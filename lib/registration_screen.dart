import 'dart:math';

import 'package:flutter/services.dart'
    show
        FilteringTextInputFormatter,
        LengthLimitingTextInputFormatter,
        TextInputFormatter;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'animated_widgets.dart';
import 'utils/auth/auth.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  bool _isPhoneValid = false;
  bool _isPhoneFilled = false;
  bool _isNickFilled = false;
  bool _isUserAvailable = false;
  bool _isNickAvailable = false;
  bool found = false;
  String lookingFor = '';
  // Добавляем контроллер для никнейма
  final _nicknameController = TextEditingController();
  final FocusNode _textFieldFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // Определяем размеры экрана
    _phoneController.addListener(() {
      setState(() {
        _isPhoneValid = true; // _validatePhoneNumber(_phoneController.text);
      });
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  bool _validatePhoneNumber(String value) {
    String pattern = r'^\+?7\d{10}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    print("look for" + lookingFor.toString());
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
                // Заголовок "Вход/Регистрация"
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Вход/Регистрация',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Добавляем изображение
                Image.asset('assets/images/border.png'),
                SizedBox(height: 4), // Отступ после изображения

                // Контейнер с градиентным фоном и светящейся рамкой
                Container(
                  margin: EdgeInsets.only(left: screenWidth * 0.08),
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 2, 14, 24),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        bottomLeft: Radius.circular(25)),
                    border: Border.all(color: Color.fromARGB(0, 13, 158, 255)),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF0DA0FF).withOpacity(0.6),
                        spreadRadius: 10,
                        blurRadius: 25,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Секция телефона
                      _buildPhoneSection(),

                      SizedBox(height: 20),

                      // Секция никнейма
                      _buildNicknameSection(),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                // Текст "Войти с помощью"
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Войти с помощью',
                        style: GoogleFonts.montserrat(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0DA0FF),
                        ),
                      ),
                      SizedBox(width: 20),
                      Image.asset('assets/images/icon_tg.png', width: 52),
                    ],
                  ),
                ),
                SizedBox(height: 80),
                // Кнопки входа и регистрации
                _buildButtonsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Поле телефона
        TextFormField(
          onTapUpOutside: (l) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          maxLength: 10,
          onChanged: (value) async {
            if (value.length == 10) {
              _isPhoneFilled = true;
              print('+7' + value);
              context.loaderOverlay.show();
              // Проверяем только если имя достаточно длинное
              Map<String, dynamic> res =
                  await AuthRepository().checkUsernameAvailability(value);
              var isAvailable = res['name'];

              setState(() {
                if (isAvailable != false) {
                  lookingFor = isAvailable;
                } else {
                  lookingFor = '';
                }
                _isUserAvailable = res['available'];
              });
              context.loaderOverlay.hide();
            } else {
              _isPhoneFilled = false;
            }
          },
          controller: _phoneController,
          style: GoogleFonts.inter(
            fontSize: 16,
            color: Colors.white.withOpacity(_isPhoneValid ? 1 : 0.6),
          ),
          decoration: InputDecoration(
            //   prefixStyle: TextStyle(color: Colors.white),
            prefixText: '+7',
            hintText: ' 000 000 00 01',
            hintStyle: GoogleFonts.inter(
              fontSize: 16,
              color: Colors.grey.shade400,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorStyle: TextStyle(color: Colors.red),
            errorText: _phoneController.text.isNotEmpty && !_isPhoneValid
                ? 'Введите корректный номер телефона'
                : null,
          ),
          keyboardType: TextInputType.phone,
          inputFormatters: [
            MaskTextInputFormatter(
                //mask: '##########',
                //filter: {"#": RegExp(r'[0-9]')},
                //    type: MaskAutoCompletionType.lazy),
                //  FilteringTextInputFormatter.digitsOnly,
                //    LengthLimitingTextInputFormatter(11),
                //    PhoneFormatter(),
                )
          ],
        ),

        // Разделительная линия
        Container(
          height: 2,
          margin: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF209FFF),
                Color(0xFF0077CD),
              ],
            ),
          ),
        ),

        // Подсказка
        Text(
          'Введите номер телефона',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(219, 202, 202, 202),
          ),
        ),
        _isPhoneFilled == true && found == false
            ? Text(_isUserAvailable ? "Телефон свободен" : "Телефон занят",
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: _isUserAvailable
                        ? Colors.green
                        : Colors.red //fromARGB(219, 202, 202, 202),
                    ))
            : Container()
      ],
    );
  }

  Widget _buildNicknameSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Поле ввода никнейма
        TextFormField(
          onTapUpOutside: (l) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onChanged: (value) async {
            if (value.length < 12) {
              _isNickFilled = true;

              context.loaderOverlay.show();
              // Проверяем только если имя достаточно длинное
              bool isAvailable =
                  await AuthRepository().checkNickAvailability(value);

              if (!isAvailable && lookingFor == value) {
                // Create a FocusNode

// Close the keyboard when needed
                FocusManager.instance.primaryFocus?.unfocus();
                //_textFieldFocusNode.unfocus();
                found = true;
              } else {
                found = false;
              }
              setState(() {
                _isNickAvailable = isAvailable;
              });
              context.loaderOverlay.hide();
            } /*else {
              _isPhoneFilled = false;
            }*/
          },
          controller: _nicknameController,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            color: Colors.white.withOpacity(0.6),
          ),
          decoration: InputDecoration(
            hintText: 'Никнейм',
            hintStyle: GoogleFonts.montserrat(
              fontSize: 16,
              color: Colors.grey.shade400,
            ),
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),

        // Разделительная линия
        Container(
          height: 2,
          margin: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFF209FFF),
                Color(0xFF0077CD),
              ],
            ),
          ),
        ),
        // Заголовок "Никнейм"
        Text(
          'Введите никнейм',
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Color.fromARGB(219, 202, 202, 202),
          ),
        ),
        // Подсказка о длине
        Text(
          '*Не более 12 символов',
          style: GoogleFonts.montserrat(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Color(0xFF209FFF),
          ),
        ),
        _isNickFilled == true && found == false
            ? Text(
                _isNickAvailable ? "Имя свободно" : "Имя занято",
                style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: _isNickAvailable
                        ? Colors.green
                        : Colors.red //fromARGB(219, 202, 202, 202),
                    ),
              )
            : Container(),
        if (found == true)
          Text(
            "Мы вас узнали!",
            style: GoogleFonts.montserrat(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.green //fromARGB(219, 202, 202, 202),
                ),
          )
      ],
    );
  }

  Widget _buildButtonsSection() {
    return Column(
      children: [
        // Кнопка входа
        if (!_isNickAvailable &&
            !_isUserAvailable &&
            _isNickFilled &&
            _isPhoneFilled &&
            found == true)
          authButton(context, _phoneController),
        SizedBox(height: 20),
        if (_isNickAvailable &&
            _isUserAvailable &&
            _isNickFilled &&
            _isPhoneFilled)
          registerButton(_phoneController, _nicknameController),

        // Кнопка регистрации
      ],
    );
  }

  Widget authButton(context, _phoneController) {
    return AnimatedContainer(
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
          Navigator.pushNamed(context, '/login',
              arguments: _nicknameController.text +
                  '/' +
                  _phoneController.text +
                  '/login');
        },
        child: Text(
          'Войти',
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget registerButton(_phoneController, _nicknameController) {
    return AnimatedContainer(
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
        onPressed: () async {
          context.loaderOverlay.show();
          print(_nicknameController.text);
          print("it was nickname");
          final Random _random = Random();
          var _randomNumber = 1000 + _random.nextInt(9000);
          String nick = await AuthRepository().sendTgCode(
              _phoneController.text, _nicknameController.text, _randomNumber);
          context.loaderOverlay.hide();

          var regRes = await AuthRepository().register(
              email: _phoneController.text,
              password: "12345",
              username: _nicknameController.text);

          if (!regRes) {
            context.loaderOverlay.hide();
            setState(() {
              _isUserAvailable = false;
              _isNickAvailable = false;
            });
            return;
          } else {
            Navigator.pushNamed(context, '/confirmationcode',
                arguments: _phoneController.text +
                    '/' +
                    _nicknameController.text +
                    "/" +
                    _randomNumber.toString());
          }
        },
        child: Text(
          'Зарегистрироваться',
          style: GoogleFonts.lato(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class PhoneFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text;

    // Если текст начинается с '+', сохраняем его
    if (newText.isNotEmpty &&
        newText[0] == '+' &&
        !oldValue.text.startsWith('+')) {
      newText = '+${newText.substring(1)}';
    }

    // Удаляем все символы кроме цифр и '+'
    newText = newText.replaceAll(RegExp(r'[^\d\+]'), '');

    // Ограничиваем длину до 11 символов (включая '+')
    if (newText.length == 11) {
//      checkUsernameAvailability(newText);
    }
    if (newText.length > 11) {
      newText = newText.substring(0, 11);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

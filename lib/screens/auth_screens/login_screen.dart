import 'package:flutter/material.dart';
//import 'package:flutter_application_1/tmp/profile_screen.dart';
import 'package:flutter_application_1/utils/auth/auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Состояние
  String username = '';
  String phone = '';
  String password = '';
  String confirmPassword = '';
  String mode = ''; // 'login' или 'register'
  bool isConfirmingPassword = false;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    //  _initializeData();
  }

  void _initializeData() {}

  @override
  Widget build(BuildContext context) {
    final String receivedData =
        ModalRoute.of(context)?.settings.arguments as String;
    final parts = receivedData.split('/');
    phone = parts[0];
    username = parts[1];
    mode = parts[2];
    print(mode);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 14, 24),
      body: SafeArea(
        child: Column(
          children: [
            // Аватар и имя пользователя
            _buildUserProfile(),

            // Поле ввода пароля
            _buildPasswordInputSection(),

            // Кнопки цифр
            _buildNumberPad(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserProfile() {
    return Column(
      children: [
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
        Text(
          username,
          style: GoogleFonts.montserrat(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordInputSection() {
    return Padding(
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
            _getPasswordHintText(),
            style: GoogleFonts.montserrat(
              color: const Color(0xFF7C7C7C),
              fontSize: 14,
            ),
          ),

          // Индикаторы ввода пароля
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) {
                final currentPassword =
                    isConfirmingPassword ? confirmPassword : password;
                final isFilled = currentPassword.length > index;

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isFilled ? const Color(0xFF018CFF) : Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: isFilled
                            ? const Color.fromARGB(255, 111, 190, 255)
                                .withOpacity(0.5)
                            : Colors.white.withOpacity(0.5),
                        blurRadius: 24,
                        spreadRadius: 10,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),

          // Сообщения об ошибке или подсказки
          if (hasError)
            Text(
              'Попробуйте заново',
              style: GoogleFonts.montserrat(
                color: Colors.red,
                fontSize: 14,
              ),
            ),

          if (isConfirmingPassword)
            Text(
              'Введите второй раз',
              style: GoogleFonts.montserrat(
                color: const Color(0xFF7C7C7C),
                fontSize: 14,
              ),
            ),

          if (mode == 'login')
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                'Забыли пароль',
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF7C7C7C),
                  fontSize: 14,
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getPasswordHintText() {
    if (mode == 'register') {
      return isConfirmingPassword
          ? 'Подтвердите ваш пароль'
          : 'Задайте пароль для входа';
    } else {
      return 'Введите пароль для входа';
    }
  }

  Widget _buildNumberPad() {
    return Column(
      children: [
        _buildNumberRow('789'),
        _buildNumberRow('456'),
        _buildNumberRow('123'),
        _buildBottomRow(),
      ],
    );
  }

  Widget _buildNumberRow(String numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: numbers.split('').map((number) {
        return _buildNumberButton(number);
      }).toList(),
    );
  }

  Widget _buildNumberButton(String number) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      width: 89,
      height: 62,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF020518),
            Color(0xFF061C27),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color.fromARGB(99, 185, 185, 185),
          width: 0.5,
        ),
      ),
      child: TextButton(
        onPressed: () => _handleNumberInput(number),
        child: Text(
          number,
          style: GoogleFonts.roboto(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Кнопка выхода
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 89,
            height: 62,
            child: Center(
              child: Text(
                'Выйти',
                style: GoogleFonts.montserrat(
                  color: const Color(0xFF7D7D7D),
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),

        // Кнопка 0
        _buildNumberButton('0'),

        // Кнопка удаления
        GestureDetector(
          onTap: _handleDelete,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color.fromARGB(0, 66, 66, 66),
            ),
            child: const Icon(
              Icons.arrow_left,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _handleNumberInput(String number) async {
    if (isConfirmingPassword) {
      _handleConfirmPasswordInput(number);
    } else {
      _handlePasswordInput(number);
    }
  }

  void _handlePasswordInput(String number) {
    if (password.length < 4) {
      setState(() {
        password += number;
        hasError = false;
      });
    }

    if (password.length == 4) {
      if (mode == 'login') {
        _performLogin();
      } else if (mode == 'register') {
        setState(() {
          isConfirmingPassword = true;
        });
      }
    }
  }

  void _handleConfirmPasswordInput(String number) {
    if (confirmPassword.length < 4) {
      setState(() {
        confirmPassword += number;
      });
    }

    if (confirmPassword.length == 4) {
      if (password == confirmPassword) {
        _performRegistration();
      } else {
        setState(() {
          hasError = true;
          isConfirmingPassword = false;
          password = '';
          confirmPassword = '';
        });
      }
    }
  }

  void _handleDelete() {
    setState(() {
      if (isConfirmingPassword) {
        if (confirmPassword.isNotEmpty) {
          confirmPassword =
              confirmPassword.substring(0, confirmPassword.length - 1);
        }
      } else {
        if (password.isNotEmpty) {
          password = password.substring(0, password.length - 1);
        }
      }
      hasError = false;
    });
  }

  Future<void> _performLogin() async {
    context.loaderOverlay.show();
    try {
      print(phone);
      print(password);
      print(username); //на самом деле это номер
      final authRes =
          await AuthRepository().login(email: username, password: password);
      context.loaderOverlay.hide();

      if (authRes['error'] != null) {
        setState(() {
          hasError = true;
          password = '';
        });
      } else {
        final storage = FlutterSecureStorage();
        await storage.write(key: 'pass', value: password);
        await storage.write(key: 'phone', value: phone);
        await storage.write(key: 'username', value: username);
        Navigator.pushNamed(context, '/MapBoxExample');
      }
    } catch (e) {
      context.loaderOverlay.hide();
      setState(() {
        hasError = true;
        password = '';
      });
    }
  }

  Future<void> _performRegistration() async {
    context.loaderOverlay.show();
    try {
      final regRes = await AuthRepository().register(
        email: phone,
        password: password,
        username: username,
      );

      context.loaderOverlay.hide();

      if (regRes) {
        context.loaderOverlay.show();
        final storage = FlutterSecureStorage();
        await storage.write(key: 'pass', value: password);
        await storage.write(key: 'phone', value: phone);
        await storage.write(key: 'username', value: username);
        context.loaderOverlay.hide();
        Navigator.pushNamed(context, '/MapBoxExample');
      } else {
        setState(() {
          hasError = true;
          isConfirmingPassword = false;
          password = '';
          confirmPassword = '';
        });
      }
    } catch (e) {
      context.loaderOverlay.hide();
      setState(() {
        hasError = true;
        isConfirmingPassword = false;
        password = '';
        confirmPassword = '';
      });
    }
  }
}

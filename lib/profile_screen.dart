import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter_application_1/map_screen.dart';
import 'package:flutter_application_1/map_screen_ser.dart';
import 'package:google_fonts/google_fonts.dart';

class NeonBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const NeonBackButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          size: 32,
        ),
        color: Colors.blue.shade200,
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          shadowColor: WidgetStateProperty.all(Colors.blue.shade200.withOpacity(0.5)),
          elevation: WidgetStateProperty.all(0),
        ),
      ),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Timer? _timer;
  int _coins = 0;
  final List<String> _purchasedImages = [];

  @override
  void initState() {
    super.initState();
    _startCoinCollection();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCoinCollection() {
    _timer = Timer.periodic(
      const Duration(hours: 1),
      (timer) {
        setState(() {
          _coins += 4;
        });
      },
    );
  }

  void _collectCoins() {
    setState(() {
      _timer?.cancel();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Монеты собраны!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Аватарка
              Container(
                width: 120,
                height: 120,
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
                  size: 80,
                ),
              ),

              const SizedBox(height: 16),

              // Имя и иконки
              Column(
                children: [
                  Text(
                    'Иван',
                    style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(3, (index) => const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 24,
                      ),
                    )),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Блок с таймером и монетами
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Таймер: ${_formatTime(_coins)}',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Монеты: $_coins',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade700,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: _collectCoins,
                      child: Text(
                        'Собрать монеты',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Коллекция картинок
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Коллекция картинок (${_purchasedImages.length})',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: _purchasedImages.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          _purchasedImages[index],
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Неоновая кнопка возврата
              NeonBackButton(
                onPressed: () {
                  Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const MapScreenS()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(int coins) {
    final hours = coins ~/ 4;
    final minutes = ((coins % 4) * 15).round();
    return '$hours:${minutes.toString().padLeft(2, '0')}';
  }
}

class ImageCollection {
  final String name;
  final int count;
  final int coinsPerHour;
  final String imageUrl;

  ImageCollection({
    required this.name,
    required this.count,
    required this.coinsPerHour,
    required this.imageUrl,
  });
}
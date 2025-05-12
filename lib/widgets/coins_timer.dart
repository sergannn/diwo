import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LargeProfileAvatar extends StatefulWidget {
//  final Function(int) onCollect;
  int balance;

  LargeProfileAvatar({
//    required this.onCollect,
    required this.balance,
    Key? key,
  }) : super(key: key);

  @override
  LargeProfileAvatarState createState() => LargeProfileAvatarState();
}

class LargeProfileAvatarState extends State<LargeProfileAvatar>
    with WidgetsBindingObserver {
  Timer? _timer;
  Duration _duration = Duration(hours: 6);
  double _earnedCoins = 0;
  bool _isRunning = true;
  final double _coinsPerHour = 100;
  DateTime? _lastUpdateTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadTimerState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    _saveTimerState();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _saveTimerState();
    } else if (state == AppLifecycleState.resumed) {
      _loadTimerState();
    }
  }

  Future<void> _loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTime = prefs.getInt('lastUpdateTime');
    final savedEarned = prefs.getDouble('earnedCoins');
    final savedDuration = prefs.getInt('remainingDuration');

    if (savedTime != null && savedDuration != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final elapsedSeconds = (now - savedTime) ~/ 1000;
      final remainingSeconds = savedDuration - elapsedSeconds;

      setState(() {
        if (remainingSeconds > 0) {
          _duration = Duration(seconds: remainingSeconds);
          _earnedCoins =
              (savedEarned ?? 0) + (_coinsPerHour / 3600 * elapsedSeconds);
        } else {
          _duration = Duration.zero;
          _earnedCoins = _coinsPerHour * 6;
          _isRunning = false;
        }
      });
    }

    _startTimer();
  }

  Future<void> _saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastUpdateTime', DateTime.now().millisecondsSinceEpoch);
    await prefs.setDouble('earnedCoins', _earnedCoins);
    await prefs.setInt('remainingDuration', _duration.inSeconds);
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(milliseconds: 1), (timer) {
      if (!_isRunning) return;

      setState(() {
        if (_duration.inSeconds > 0) {
          _duration = _duration - Duration(seconds: 1);
          _earnedCoins += _coinsPerHour / 3600;
          if (_earnedCoins > _coinsPerHour * 6) {
            _earnedCoins = _coinsPerHour * 6;
          }
        } else {
          _timer?.cancel();
          _isRunning = false;
          _earnedCoins = _coinsPerHour * 6;
        }
      });
    });
  }

  void _collectCoins() {
    final coinsToAdd = _earnedCoins.floor();
    if (coinsToAdd > 0) {
      onCollect(coinsToAdd);
      setState(() {
        _earnedCoins = 0;
        _duration = Duration(hours: 6);
        _isRunning = true;
      });
      _startTimer();
      _saveTimerState();
    }
  }

  void onCollect(int coins) {
    setState(() {
      widget.balance += coins;
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final progress = 1 - (_duration.inSeconds / (6 * 3600));

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/coin.png', width: 33, height: 33),
              // _CoinsIndicators(),
              _CoinsIndicators(earnedCoins: _earnedCoins),
              Spacer(),
              Text(
                widget.balance.toString(),
                style: TextStyle(
                  fontFamily: 'Urbanist',
                  fontWeight: FontWeight.w600,
                  fontSize: 44,
                  color: Color(0xFFEEC61E),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: _collectCoins,
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/chest_bg.png',
                  width: 220.3,
                  height: 220.3,
                ),
                CircularPercentIndicator(
                  radius: 60.0,
                  lineWidth: 5.0,
                  percent: progress.clamp(0.0, 1.0),
                  center: Image.asset(
                    'assets/images/chest.png',
                    width: 65.15,
                    height: 59.45,
                  ),
                  progressColor: Color(0xFFEEC61E),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 140.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatDuration(_duration),
                        style: TextStyle(
                          fontSize: 16.98,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CoinsIndicators extends StatelessWidget {
  final double earnedCoins; // Добавьте это

  const _CoinsIndicators({
    required this.earnedCoins, // Добавьте это
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // Измените Text на Row
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Монеты: ",
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            Text(
              "+${earnedCoins.toStringAsFixed(0)}", // Отображаем earnedCoins
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: Color(0xFFEEC61E), // Золотой цвет для монет
              ),
            ),
          ],
        ),
        SizedBox(height: 5),
        Text(
          "${DateTime.now().day} ${_getMonthName(DateTime.now().month)} ${DateTime.now().year}",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.white.withOpacity(0.5),
          ),
        ),
      ],
    );
  }

  String _getMonthName(int month) {
    const months = [
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря'
    ];
    return months[month - 1];
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/timer/timer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

class LargeProfileAvatar extends StatefulWidget {
  const LargeProfileAvatar({
    Key? key,
  }) : super(key: key);

  @override
  LargeProfileAvatarState createState() => LargeProfileAvatarState();
}

class LargeProfileAvatarState extends State<LargeProfileAvatar>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
//    final timer = Provider.of<CountdownTimer>(context, listen: false);
//    timer.loadTimerState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final timer = Provider.of<CountdownTimer>(context, listen: false);
    if (state == AppLifecycleState.paused) {
      timer.saveTimerState();
    } else if (state == AppLifecycleState.resumed) {
//      timer.loadTimerState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final timer = Provider.of<CountdownTimer>(context);

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('assets/images/coin.png', width: 33, height: 33),
              _CoinsIndicators(earnedCoins: timer.earnedCoins),
              Spacer(),
              Text(
                Provider.of<CountdownTimer>(context).balance.toString(),
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
          onTap: () {
            final collected = timer.collectCoins();
            if (collected > 0) {
              timer.addToBalance(collected);
            }
            /*final collected = timer.collectCoins();
            if (collected > 0) {
              setState(() {
                _balance += collected; // Update local balance
              });
            }*/
          },
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
                  percent: timer.progress.clamp(0.0, 1.0),
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
                        timer.formattedDuration,
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

// _CoinsIndicators remains the same as in your original code

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
              Provider.of<CountdownTimer>(context)
                  .earnedCoins
                  .toStringAsFixed(0),
//              "+${earnedCoins.toStringAsFixed(0)}", // Отображаем earnedCoins
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

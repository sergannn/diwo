import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountdownTimer extends ChangeNotifier {
  Timer? _timer;
  int _remainingSeconds;
  final int _initialSeconds;
  bool _isRunning = false;
  double _earnedCoins = 0;
  final double _coinsPerHour = 100;
  DateTime? _lastUpdateTime;
  int _balance = 0;
  
  int get balance => _balance;
  CountdownTimer({required int initialSeconds})
      : _remainingSeconds = initialSeconds,
        _initialSeconds = initialSeconds;

  int get remainingSeconds => _remainingSeconds;
  bool get isRunning => _isRunning;
  double get earnedCoins => _earnedCoins;
  double get coinsPerHour => _coinsPerHour;

  Duration get duration => Duration(seconds: _remainingSeconds);
  double get progress => 1 - (_remainingSeconds / _initialSeconds);

  void addToBalance(int amount) {
    _balance += amount;
    notifyListeners();
  }

  String get formattedDuration {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  // Modify your loadTimerState to properly handle resuming
  Future<void> loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTime = prefs.getInt('lastUpdateTime');
    final savedEarned = prefs.getDouble('earnedCoins');
    final savedDuration = prefs.getInt('remainingDuration');

    if (savedTime != null && savedDuration != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final elapsedSeconds = (now - savedTime) ~/ 1000;
      final remainingSeconds = savedDuration - elapsedSeconds;

      if (remainingSeconds > 0) {
        _remainingSeconds = remainingSeconds;
        _earnedCoins = (savedEarned ?? 0) + (_coinsPerHour / 3600 * elapsedSeconds);
        startTimer(); // Ensure timer keeps running
      } else {
        _remainingSeconds = 0;
        _earnedCoins = _coinsPerHour * (_initialSeconds / 3600);
        _isRunning = false;
      }
      notifyListeners();
    } else {
      // First run or no saved state
      startTimer();
    }
  }

  Future<void> saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastUpdateTime', DateTime.now().millisecondsSinceEpoch);
    await prefs.setDouble('earnedCoins', _earnedCoins);
    await prefs.setInt('remainingDuration', _remainingSeconds);
  }

  void startTimer() {
    if (_isRunning) return;

    _isRunning = true;
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        _earnedCoins += _coinsPerHour / 3600;
        if (_earnedCoins > _coinsPerHour * (_initialSeconds / 3600)) {
          _earnedCoins = _coinsPerHour * (_initialSeconds / 3600);
        }
        notifyListeners();
      } else {
        stopTimer();
        _earnedCoins = _coinsPerHour * (_initialSeconds / 3600);
        notifyListeners();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    notifyListeners();
  }

  void resetTimer() {
    _timer?.cancel();
    _remainingSeconds = _initialSeconds;
    _earnedCoins = 0;
    _isRunning = false;
    notifyListeners();
  }

  int collectCoins() {
    final coinsToAdd = _earnedCoins.floor();
    if (coinsToAdd > 0) {
      _earnedCoins = 0;
    //  _remainingSeconds = _initialSeconds;
      _isRunning = true;
   //   startTimer();
   //   saveTimerState();
      notifyListeners();
    }
    else { print("empty");
    resetTimer();
    startTimer();}
    return coinsToAdd;
  }

  @override
  void dispose() {
    saveTimerState();
    _timer?.cancel();
    super.dispose();
  }
}
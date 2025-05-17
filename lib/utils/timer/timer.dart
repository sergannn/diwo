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
  DateTime? _lastStartTime;
  int _balance = 0;

  int get balance => _balance;
  
  CountdownTimer({required int initialSeconds})
      : _remainingSeconds = initialSeconds,
        _initialSeconds = initialSeconds {
    _initTimer();
  }

  Future<void> _initTimer() async {
    await _loadTimerState();
    _startBackgroundTimer();
  }

  // Добавляем метод addToBalance обратно
  void addToBalance(int amount) {
    _balance += amount;
    notifyListeners();
  }

  int get remainingSeconds => _remainingSeconds;
  bool get isRunning => _isRunning;
  double get earnedCoins => _earnedCoins;
  double get coinsPerHour => _coinsPerHour;

  Duration get duration => Duration(seconds: _remainingSeconds);
  double get progress => 1 - (_remainingSeconds / _initialSeconds);

  String get formattedDuration {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  Future<void> _loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    _balance = prefs.getInt('balance') ?? 0;
    final startTime = prefs.getInt('startTime');
    final initialDuration = prefs.getInt('initialDuration') ?? _initialSeconds;
    final savedEarned = prefs.getDouble('earnedCoins') ?? 0;

    if (startTime != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final elapsedSeconds = (now - startTime) ~/ 1000;
      _remainingSeconds = initialDuration - elapsedSeconds;
      _earnedCoins = savedEarned + (_coinsPerHour / 3600 * elapsedSeconds);

      if (_remainingSeconds <= 0) {
        _remainingSeconds = 0;
        _earnedCoins = _coinsPerHour * (_initialSeconds / 3600);
        _isRunning = false;
        await prefs.remove('startTime');
      } else {
        _isRunning = true;
        _lastStartTime = DateTime.fromMillisecondsSinceEpoch(startTime);
      }
    }
    notifyListeners();
  }

  Future<void> saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('balance', _balance);
    
    if (_isRunning && _lastStartTime != null) {
      await prefs.setInt('startTime', _lastStartTime!.millisecondsSinceEpoch);
      await prefs.setInt('initialDuration', _initialSeconds);
    } else {
      await prefs.remove('startTime');
    }
    await prefs.setDouble('earnedCoins', _earnedCoins);
  }

  void _startBackgroundTimer() {
    if (_isRunning) {
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
          _earnedCoins += _coinsPerHour / 3600;
          if (_earnedCoins > _coinsPerHour * (_initialSeconds / 3600)) {
            _earnedCoins = _coinsPerHour * (_initialSeconds / 3600);
          }
          notifyListeners();
        } else {
          _stopTimer();
          _earnedCoins = _coinsPerHour * (_initialSeconds / 3600);
          notifyListeners();
        }
      });
    }
  }

  void startTimer() {
    if (_isRunning) return;

    _lastStartTime = DateTime.now();
    _isRunning = true;
    saveTimerState();
    _startBackgroundTimer();
    notifyListeners();
  }

  void _stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    saveTimerState();
  }

  void stopTimer() {
    _stopTimer();
    notifyListeners();
  }

  void resetTimer() {
    _stopTimer();
    _remainingSeconds = _initialSeconds;
    _earnedCoins = 0;
    saveTimerState();
    notifyListeners();
  }

  int collectCoins() {
    final coinsToAdd = _earnedCoins.floor();
    addToBalance(coinsToAdd); // Используем addToBalance для добавления монет
    resetTimer();
    startTimer();
    return coinsToAdd;
  }

  @override
  void dispose() {
    saveTimerState();
    _timer?.cancel();
    super.dispose();
  }
}
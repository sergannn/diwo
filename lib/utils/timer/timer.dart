import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountdownTimer extends ChangeNotifier {
  Timer? _timer;
  int _remainingSeconds;
  final int _initialSeconds = 21600; // 6 часов в секундах
  bool _isRunning = false;
  double _earnedCoins = 0;
  final double _maxCoins = 600; // Максимум 600 монет за 6 часов
  int _balance = 0;

  int _coinProgressSeconds =
      0; // Новое поле для отслеживания прогресса до следующей монеты

  // Новый геттер для получения прогресса
  int get secondsUntilNextCoin => 36 - _coinProgressSeconds;

  CountdownTimer() : _remainingSeconds = 21600 {
    loadTimerState();
  }

  // Геттеры для доступа к данным
  int get balance => _balance;
  int get remainingSeconds => _remainingSeconds;
  bool get isRunning => _isRunning;
  double get earnedCoins => _earnedCoins;
  double get maxCoins => _maxCoins;

  int get getCoinProgress  => _coinProgressSeconds; 
  
  Duration get duration => Duration(seconds: _remainingSeconds);
  double get progress => 1 - (_remainingSeconds / _initialSeconds);

  String get formattedDuration {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$hours:$minutes:$seconds';
  }

  // Загрузка состояния таймера
  Future<void> loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTime = prefs.getInt('lastUpdateTime');
    final savedDuration = prefs.getInt('remainingDuration');

    if (savedTime != null && savedDuration != null) {
      final now = DateTime.now().millisecondsSinceEpoch;
      final elapsedSeconds = (now - savedTime) ~/ 1000;

      // Корректный расчет оставшегося времени
      _remainingSeconds = max(0, savedDuration - elapsedSeconds);

      // Расчет заработанных монет пропорционально времени
      _earnedCoins = min(
          _maxCoins, _maxCoins * (1 - (_remainingSeconds / _initialSeconds)));

      if (_remainingSeconds > 0) {
        startTimer();
      } else {
        _earnedCoins = _maxCoins;
        _isRunning = false;
      }
      notifyListeners();
    } else {
      // Первый запуск - начинаем отсчет
      startTimer();
    }
  }

  // Сохранение состояния таймера
  Future<void> saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastUpdateTime', DateTime.now().millisecondsSinceEpoch);
    await prefs.setInt('remainingDuration', _remainingSeconds);
  }

  // Запуск таймера
  void startTimer() {
    if (_isRunning || _remainingSeconds <= 0) return;

    _isRunning = true;
    _timer?.cancel(); // Отменяем предыдущий таймер, если был

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;

        _coinProgressSeconds++;

        // Когда достигаем 36 секунд - начисляем монету и сбрасываем
        if (_coinProgressSeconds >= 36) {
          _earnedCoins = min(_earnedCoins + 1, _maxCoins);
          _coinProgressSeconds = 0; // Сбрасываем счётчик
        }

        // Обновляем количество монет на основе прогресса
        if (_remainingSeconds % 36 == 0) {
          _earnedCoins += 1;
        }
        notifyListeners();
        saveTimerState(); // Периодически сохраняем состояние
      } else {
        stopTimer();
        _earnedCoins = _maxCoins;
        notifyListeners();
      }
    });
  }

  // Новый метод для получения и сброса прогресса
  


  // Остановка таймера
  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    saveTimerState();
    notifyListeners();
  }

  // Сбор монет и перезапуск таймера
  int collectCoins() {
    _coinProgressSeconds=0;
    final coinsToAdd = min(_earnedCoins, _maxCoins).floor();
    _earnedCoins = 0;
    _remainingSeconds = _initialSeconds;

    if (!_isRunning) {
      startTimer();
    } else {
      // Если таймер уже работает, просто сбрасываем время
      notifyListeners();
    }

    saveTimerState();
    return coinsToAdd;
  }

  // Добавление монет к балансу
  void addToBalance(int amount) {
    _balance += amount;
    notifyListeners();
  }

  // Очистка ресурсов
  @override
  void dispose() {
    saveTimerState();
    _timer?.cancel();
    super.dispose();
  }
}

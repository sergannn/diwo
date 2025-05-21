import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountdownTimer extends ChangeNotifier {
  // Таймер и состояние
  Timer? _timer;
  bool _isRunning = false;
  
  // Настройки времени (6 часов = 21600 секунд)
  int _remainingSeconds;
  static const int _initialSeconds = 21600;
  
  // Система монет (1 монета каждые 36 секунд, максимум 600 монет)
  double _earnedCoins = 0;
  static const double _maxCoins = 600;
  int _balance = 0;
  int _coinProgressSeconds = 0; // Прогресс до следующей монеты (0-35)

  // ========== ГЕТТЕРЫ ========== //
  
  int get balance => _balance;
  int get remainingSeconds => _remainingSeconds;
  bool get isRunning => _isRunning;
  double get earnedCoins => _earnedCoins;
  double get maxCoins => _maxCoins;
  int get getCoinProgress => _coinProgressSeconds;
  
  // Прогресс до следующей монеты (0.0 - 1.0)
  double get progressToNextCoin => _coinProgressSeconds / 36;
  
  // Общий прогресс таймера (0.0 - 1.0)
    double get progress {
  return (_initialSeconds - _remainingSeconds) / _initialSeconds;
    }
  // Форматированное время (ЧЧ:ММ:СС)
  String get formattedDuration {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_remainingSeconds ~/ 3600);
    final minutes = twoDigits((_remainingSeconds % 3600) ~/ 60);
    final seconds = twoDigits(_remainingSeconds % 60);
    return '$hours:$minutes:$seconds';
  }

  // ========== ОСНОВНЫЕ МЕТОДЫ ========== //

  CountdownTimer() : _remainingSeconds = _initialSeconds {
    loadTimerState();
  }

  // Загрузка сохраненного состояния
  Future<void> loadTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Получаем сохраненные значения
    final savedTime = prefs.getInt('lastUpdateTime');
    final savedDuration = prefs.getInt('remainingDuration');
    final savedCoins = prefs.getDouble('earnedCoins');
    final savedBalance = prefs.getInt('balance');
    final savedProgress = prefs.getInt('coinProgress');
    
    if (savedTime != null && savedDuration != null) {
      // Рассчитываем сколько времени прошло с момента последнего сохранения
      final now = DateTime.now().millisecondsSinceEpoch;
      final elapsedSeconds = (now - savedTime) ~/ 1000;
      
      // Обновляем состояние
      _remainingSeconds = max(0, savedDuration - elapsedSeconds);
      _earnedCoins = min(savedCoins ?? 0, _maxCoins);
      _balance = savedBalance ?? 0;
      _coinProgressSeconds = min(savedProgress ?? 0, 35);
      
      // Если время еще не вышло, запускаем таймер
      if (_remainingSeconds > 0) {
        _calculateProgressWhileInactive(elapsedSeconds);
        startTimer();
      } else {
        _earnedCoins = _maxCoins;
        _isRunning = false;
      }
      notifyListeners();
    } else {
      // Первый запуск - начинаем с начала
      _remainingSeconds = _initialSeconds;
      startTimer();
    }
  }

  // Расчет прогресса, пока приложение было неактивно
  void _calculateProgressWhileInactive(int elapsedSeconds) {
    // Сколько монет было заработано за время неактивности
    final additionalCoins = elapsedSeconds ~/ 36;
    _earnedCoins = min(_earnedCoins + additionalCoins, _maxCoins);
    
    // Остаток секунд для следующей монеты
    _coinProgressSeconds = elapsedSeconds % 36;
  }

  // Сохранение текущего состояния
  Future<void> saveTimerState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastUpdateTime', DateTime.now().millisecondsSinceEpoch);
    await prefs.setInt('remainingDuration', _remainingSeconds);
    await prefs.setDouble('earnedCoins', _earnedCoins);
    await prefs.setInt('balance', _balance);
    await prefs.setInt('coinProgress', _coinProgressSeconds);
  }

  // Запуск таймера
  void startTimer() {
    if (_isRunning || _remainingSeconds <= 0) return;

    _isRunning = true;
    _timer?.cancel(); // Отменяем предыдущий таймер

    // Обновляем состояние каждую секунду
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        _coinProgressSeconds++;
        
        // Каждые 36 секунд добавляем монету
        if (_coinProgressSeconds >= 36) {
          _earnedCoins += 1;
          _coinProgressSeconds = 0;
          
          // Проверяем, не достигли ли максимума
          if (_earnedCoins >= _maxCoins) {
            _earnedCoins = _maxCoins;
            stopTimer();
          }
        }
        
        notifyListeners();
        saveTimerState();
      } else {
        // Время вышло
        stopTimer();
        _earnedCoins = _maxCoins;
        notifyListeners();
      }
    });
  }

  // Остановка таймера
  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    saveTimerState();
    notifyListeners();
  }

  // Сбор накопленных монет
  int collectCoins() {
    final coinsToAdd = _earnedCoins.floor();
    
    // Сбрасываем состояние
    _earnedCoins = 0;
    _coinProgressSeconds = 0;
    _remainingSeconds = _initialSeconds;
    
    // Перезапускаем таймер
    startTimer();
    saveTimerState();
    
    return coinsToAdd;
  }

  // Добавление монет к балансу
  void addToBalance(int amount) {
    _balance += amount;
    notifyListeners();
    saveTimerState();
  }

  // Очистка ресурсов
  @override
  void dispose() {
    saveTimerState();
    _timer?.cancel();
    super.dispose();
  }
}
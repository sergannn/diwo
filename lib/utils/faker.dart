import 'dart:math';

String generateRandomNickname() {
  final random = Random();
  final adjectives = ['Red', 'Swift', 'Dark', 'Happy', 'Silent', 'Crazy'];
  final nouns = ['Wolf', 'Dragon', 'Phoenix', 'Bear', 'Eagle', 'Ninja'];

  return '${adjectives[random.nextInt(adjectives.length)]}'
      '${nouns[random.nextInt(nouns.length)]}'
      '${random.nextInt(90) + 10}'; // Adds random number (10-99)
}

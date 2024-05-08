import 'dart:math';

class RandomPassword {
  RandomPassword();

  String generatePassword(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()_+-=:?<>';
    final random = Random();
    return List.generate(length, (index) => chars[random.nextInt(chars.length)]).join();
  }
}
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class ScreenArguments {
  final String username;
  final String phone;

  ScreenArguments(this.username, this.phone);
}

class AuthRepository {
  Future<bool> register({
    required String email,
    required String password,
    required String username,
  }) async {
    final response = await http.post(
      Uri.parse("http://www.postagents.ru/api/auth/register"),
      body: {
        'name': username,
        'email': email,
        'password': password,
      },
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print(decodedResponse);
      return true;
      //  return SessionModel.fromBackendJson(decodedResponse);
    } else {
      return false;
      throw Exception('Failed to register');
    }
  }

  Future<dynamic> login({
    required String email,
    required String password,
  }) async {
    print({email, password});
    final response = await http.post(
      Uri.parse("https://postagents.ru/api/auth/login"),
      body: {
        'email': email,
        'password': password,
      },
    );
    print(response.body);
    //if (response.statusCode == 200) {
    final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
    print(decodedResponse);
    return decodedResponse;
    //return SessionModel.fromBackendJson(decodedResponse);
  }

  Future<Map<String, dynamic>> checkUsernameAvailability(
      String username) async {
    final response = await http.get(
      Uri.parse(
          "https://www.postagents.ru/api/auth/checkusername?username=$username"),
//          "http://www.postagents.com/api/auth/check-username?username=$username"),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print(decodedResponse);
      return decodedResponse;
    } else {
      throw Exception('Failed to check username availability');
    }
  }

  Future<Map<String, dynamic>> changePassword(
      String username, String pass) async {
    print(
        "https://postagents.ru/api/auth/changepassword?old_password=12345&new_password=$pass&email=$username");
    final response = await http.get(Uri.parse(
        "https://postagents.ru/api/auth/changepassword?old_password=12345&new_password=$pass&email=$username"));
//https://postagents.ru/api/auth/changepassword?old_password=1111&new_password=1111&email=9650074309

    print(response.statusCode);
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print(decodedResponse);
      return decodedResponse;
    } else {
      throw Exception('Failed to check username availability');
    }
  }

  Future<bool> checkNickAvailability(String nickname) async {
    final response = await http.get(
      Uri.parse(
          //"https://www.postagents.ru/api/auth/checknickname?nickname=sergannn
          "https://www.postagents.ru/api/auth/checknickname?nickname=$nickname"),
//          "http://www.postagents.com/api/auth/check-username?username=$username"),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      final decodedResponse = jsonDecode(response.body) as Map<String, dynamic>;
      print(decodedResponse);
      return decodedResponse['available'];
    } else {
      throw Exception('Failed to check username availability');
    }
  }

  Future<String> sendTgCode(nick, phone, msg) async {
    final username =
        (await Telegram('7503936776:AAEh-kX5zNIx1W472stNph48FqIx5Y5AHhI')
                .getMe())
            .username;

    var teledart = TeleDart(
        '7503936776:AAEh-kX5zNIx1W472stNph48FqIx5Y5AHhI', Event(username!));
    teledart.start();
    teledart.sendMessage('-4689672128', 'Код для $phone, $nick : $msg');
    teledart.stop();
    return username ?? 'no name';
  }
}

import 'dart:convert';

import 'package:front/models/user.model.dart';
import 'package:http/http.dart' as http;

class CTrackerAPI {
  Future<String> signup(User newUser) async {
    try {
      print(jsonEncode(newUser.toJson()));
      final response2 = await http.post(
          Uri.http(
            '10.0.2.2:8000',
            '/api/user/register',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'X-API-KEY':
                'gszIi5Vynxx7AWUmpkTdSn1GsPo9twakuRg1KEO0JATkVFWctpPzZscNBet4zW6'
          },
          body: jsonEncode(newUser.toJson()));

      print(response2.body);
      if (response2.statusCode >= 400) {
        return 'An error occurred during sign-up.';
      }

      return 'User successfully signed up!';
    } catch (e) {
      print(e);
      return 'An error occurred during sign-up.';
    }
  }
}

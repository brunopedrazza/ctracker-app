import 'dart:convert';
import 'package:front/models/user.model.dart';
import 'package:http/http.dart' as http;

class CTrackerAPI {
  Future<void> signup(User newUser) async {
    try {
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

      if (response2.statusCode >= 400) {
        throw new Error();
      }

      return;
    } catch (e) {
      print(e);
      throw new Error();
    }
  }

  Future<User> login(String email, String password) async {
    final partialUserData = new User(
        firstName: "",
        lastName: "",
        email: email,
        password: password,
        birthday: "");

    try {
      final response = await http.post(
          Uri.http(
            '10.0.2.2:8000',
            '/api/user/login',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'X-API-KEY':
                'gszIi5Vynxx7AWUmpkTdSn1GsPo9twakuRg1KEO0JATkVFWctpPzZscNBet4zW6'
          },
          body: jsonEncode(partialUserData.toJson()));

      if (response.statusCode >= 400) {
        throw new Error();
      }

      final userLoggedIn = User.fromJson(json.decode(response.body));

      return userLoggedIn;
    } catch (e) {
      print(e);
      throw new Error();
    }
  }
}

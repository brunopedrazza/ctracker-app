import 'dart:convert';
import 'package:front/models/place.model.dart';
import 'package:front/models/user.model.dart';
import 'package:http/http.dart' as http;

class CTrackerAPI {
  static const url = 'c0428b72f76c.ngrok.io';

  Future<void> signup(User newUser) async {
    try {
      final response2 = await http.post(
          Uri.http(
            url,
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
            url,
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

  Future<List<Place>> fetchUserPlaces(User user) async {
    try {
      final response = await http.get(
          Uri.http(
            url,
            '/api/place/user/${user.email}',
          ),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'X-API-KEY':
                'gszIi5Vynxx7AWUmpkTdSn1GsPo9twakuRg1KEO0JATkVFWctpPzZscNBet4zW6'
          });

      if (response.statusCode >= 400) {
        throw new Error();
      }

      final decodedPlaces = json.decode(response.body);
      final List<Place> allVisitedPlaces = [];
      for (int i = 0; i < decodedPlaces.length; i++) {
        allVisitedPlaces.add(Place.fromJson(decodedPlaces[i]));
      }

      return allVisitedPlaces;
    } catch (e) {
      print(e);
      throw new Error();
    }
  }
}

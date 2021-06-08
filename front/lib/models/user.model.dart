import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String birthday;

  User(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.password,
      @required this.birthday});

  // User.fromJson(Map<String, dynamic> json)
  // : name = json['n'],
  //   url = json['u'];

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'birthdate': birthday,
      'email': email,
      'password': password.toString(),
    };
  }
}

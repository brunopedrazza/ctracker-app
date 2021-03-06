import 'package:flutter/foundation.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String birthday;
  final bool notificationEnabled;

  User(
      {@required this.firstName,
      @required this.lastName,
      @required this.email,
      @required this.password,
      @required this.birthday,
      this.notificationEnabled});

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        birthday = json['birthdate'],
        email = json['email'],
        notificationEnabled = json['notification_enabled'],
        password = json['password'];

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

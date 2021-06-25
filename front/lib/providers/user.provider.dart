import 'package:flutter/cupertino.dart';
import 'package:front/models/user.model.dart';

class UserProvider extends ChangeNotifier {
  User _userLoggedIn;
  bool _isUserLoggedIn = false;

  User getUser() {
    return _userLoggedIn;
  }

  bool isLoggedIn() {
    return _isUserLoggedIn;
  }

  void setUser(User user) {
    _userLoggedIn = user;
    _isUserLoggedIn = true;
    notifyListeners();
  }

  void logOut() {
    _userLoggedIn = null;
  }
}

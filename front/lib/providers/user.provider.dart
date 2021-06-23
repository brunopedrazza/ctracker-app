import 'package:flutter/cupertino.dart';
import 'package:front/models/user.model.dart';

class UserProvider extends ChangeNotifier {
  User _userLoggedIn;

  User getUser() {
    return _userLoggedIn;
  }

  void setUser(User user) {
    _userLoggedIn = user;
    notifyListeners();
  }

  void logOut() {
    _userLoggedIn = null;
  }
}

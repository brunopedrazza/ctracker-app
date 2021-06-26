import 'package:flutter/cupertino.dart';
import 'package:front/models/user.model.dart';
import 'package:google_maps_webservice/places.dart';

class UserProvider extends ChangeNotifier {
  User _userLoggedIn;
  bool _isUserLoggedIn = false;
  List<PlacesSearchResult> _nearbyPlaces;
  User getUser() {
    return _userLoggedIn;
  }

  bool isLoggedIn() {
    return _isUserLoggedIn;
  }

  void setNearbyPlaces(List<PlacesSearchResult> nearbyPlaces) {
    _nearbyPlaces = nearbyPlaces;
    notifyListeners();
  }

  List<PlacesSearchResult> getNearbyPlaces() {
    return _nearbyPlaces;
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

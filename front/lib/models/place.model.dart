import 'package:flutter/foundation.dart';

class Place {
  final String arrivalDate;
  final String departureDate;
  final String id;
  final int numberOfNotifications;
  String vicinity;
  String name;

  Place(
      {@required this.arrivalDate,
      @required this.departureDate,
      @required this.id,
      this.numberOfNotifications,
      this.vicinity,
      this.name});

  Place.fromJson(Map<String, dynamic> json)
      : arrivalDate = json['arrival_date'],
        departureDate = json['departure_date'],
        id = json['place_id'],
        vicinity = json['vicinity'],
        name = json['name'],
        numberOfNotifications = json['number_of_notifications'];

  Map<String, dynamic> toJson() {
    return {
      'arrival_date': arrivalDate,
      'departure_date': departureDate,
      'place_id': id,
      'number_of_notifications': numberOfNotifications,
    };
  }
}

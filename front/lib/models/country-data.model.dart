import 'package:flutter/foundation.dart';

class CountryData {
  final String country;
  final int confirmed;
  final int recovered;
  final int critical;
  final int deaths;

  CountryData(
      {@required this.country,
      @required this.confirmed,
      @required this.recovered,
      @required this.critical,
      @required this.deaths});

  factory CountryData.fromJson(List<dynamic> json) {
    return CountryData(
      country: json[0]['country'],
      confirmed: json[0]['confirmed'],
      recovered: json[0]['recovered'],
      critical: json[0]['critical'],
      deaths: json[0]['deaths'],
    );
  }
}

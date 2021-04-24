import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CovidDataAPI {
  Future fetchAllData() async {}

  Future fetchDataByCountry(countryName) async {
    final response = await http.get(
        Uri.https(
            'covid-19-data.p.rapidapi.com', '/country', {'name': countryName}),
        headers: {'x-rapidapi-key': ''});

    return response;
  }
}

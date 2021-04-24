import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CovidDataAPI {
  Future fetchAllData() async {}

  Future fetchDataByCountry(countryName) async {
    final response = await http.get(
        Uri.https(
            'covid-19-data.p.rapidapi.com', '/country', {'name': countryName}),
        headers: {
          'x-rapidapi-key': '5b8957a382msh2d23f669b923e9ep150b64jsn1408a53a8c56'
        });

    return response;
  }
}

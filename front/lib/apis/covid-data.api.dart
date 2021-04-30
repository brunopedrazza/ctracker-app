import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:front/models/country-data.model.dart';
import 'package:http/http.dart' as http;

class CovidDataAPI {
  // final Map<String, String> env = DotEnv().env;

  Future<List<CountryData>> fetchDataMultipleCountries(
      List<String> countries) async {
    List<CountryData> allCountriesData = [];
    for (var countryName in countries) {
      try {
        final response = await http.get(
            Uri.https('covid-19-data.p.rapidapi.com', '/country',
                {'name': countryName}),
            headers: {
              'x-rapidapi-key': '' //@here
            });

        if (response.statusCode >= 400) {
          throw new Error();
        }

        allCountriesData.add(CountryData.fromJson(jsonDecode(response.body)));

        // Due to our API subscription beiing free, we can't make many requests
        // per section. To avoid the API blocking our requests, we wait a second
        // btween each request.
        await Future.delayed(const Duration(seconds: 1), () {});
      } catch (e) {
        return e;
      }
    }

    return allCountriesData;
  }

  Future fetchDataByCountry(countryName) async {
    final response = await http.get(
        Uri.https(
            'covid-19-data.p.rapidapi.com', '/country', {'name': countryName}),
        headers: {'x-rapidapi-key': DotEnv().env['APIKEY']});

    return response;
  }
}

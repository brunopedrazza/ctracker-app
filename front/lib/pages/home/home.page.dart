import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front/apis/covid-data.api.dart';
import 'package:front/models/country-data.model.dart';
import 'package:front/pages/home/widgets/country-card.widget.dart';
import '../../global.style.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool requestError = false;
  List<CountryData> countries = [];

  Future<CountryData> fetchdata() async {
    final response = await CovidDataAPI().fetchDataByCountry('brazil');
    final countryData = CountryData.fromJson(jsonDecode(response.body));
    return countryData;
  }

  void initState() {
    super.initState();
    try {
      CovidDataAPI().fetchDataMultipleCountries(['brazil', 'italy']).then(
          (countryListData) => setState(() {
                print(countryListData);
                this.countries = countryListData;
              }));
    } catch (e) {
      setState(() {
        requestError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CTracker'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          tooltip: 'Go Back',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: GlobalStyles.rgbColors['dark-gray'],
      ),
      body: Container(
        decoration: BoxDecoration(gradient: GlobalStyles.standardGradient),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Welcome, Gui!',
                  style: GlobalStyles.titleTextGradient,
                ),
              ),
              Text('Here are some of the latest COVID-19 statistics.'),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(20),
                child: GridView.count(
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: countries
                      .map((country) => CountryCard(
                            country: country,
                          ))
                      .toList(),
                ),
              )),
              requestError ? Text('erro HTTP') : Text('dados buscados')
            ],
          ),
        ),
      ),
    );
  }
}

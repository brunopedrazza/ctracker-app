import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front/apis/covid-data.api.dart';
import 'package:front/models/country-data.model.dart';
import 'package:front/pages/home/home.style.dart';
import 'package:front/pages/home/widgets/country-card.widget.dart';
import '../../global.style.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool requestError = false;
  bool isFetchingData = true;
  List<CountryData> countries = [];

  Future<CountryData> fetchdata() async {
    final response = await CovidDataAPI().fetchDataByCountry('brazil');
    final countryData = CountryData.fromJson(jsonDecode(response.body));
    return countryData;
  }

  void initState() {
    super.initState();

    CovidDataAPI()
        .fetchDataMultipleCountries(['brazil', 'italy', 'france'])
        .then((countryListData) => setState(() {
              this.isFetchingData = false;
              this.countries = countryListData;
            }))
        .catchError((e) => setState(() {
              isFetchingData = false;
              requestError = true;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Welcome, Gui!',
                      style: GlobalStyles.subtitleTextGradient,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                    'Here are some of the latest COVID-19 statistics. Click on the desired country to see more information.',
                    style: GlobalStyles.standardSubtextGradient),
              ),
              isFetchingData
                  ? _progressIndicator()
                  : requestError
                      ? _apiErrorMessage()
                      : Expanded(
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
              _imInfectedButton()
            ],
          ),
        ),
      ),
    );
  }
}

_apiErrorMessage() {
  return Text('errooo');
}

_imInfectedButton() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: ElevatedButton(
        onPressed: () => {},
        child: Text("I'm infected!"),
        style: HomePageStyles.infectedButton,
      ),
    ),
  );
}

_progressIndicator() {
  return Padding(
    padding: const EdgeInsets.only(top: 125),
    child: Container(
      child: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            strokeWidth: 5,
            valueColor: AlwaysStoppedAnimation<Color>(
                GlobalStyles.rgbColors['dark-gray']),
          ),
        ),
      ),
    ),
  );
}
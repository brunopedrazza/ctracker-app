import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front/apis/covid-data.api.dart';
import 'package:front/models/country-data.model.dart';
import 'package:front/models/place.model.dart';
import 'package:front/models/user.model.dart';
import 'package:front/pages/home/home.style.dart';
import 'package:front/pages/home/widgets/country-card.widget.dart';
import 'package:front/pages/home/widgets/place-card.widget.dart';
import 'package:front/providers/user.provider.dart';
import 'package:provider/provider.dart';
import 'package:front/apis/ctracker.api.dart';
import '../../global.style.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool requestError = false;
  bool isFetchingData = true;
  List<CountryData> countries = [];
  List<Place> _visitedPlaces;

  Future<CountryData> fetchdata() async {
    final response = await CovidDataAPI().fetchDataByCountry('brazil');
    final countryData = CountryData.fromJson(jsonDecode(response.body));
    return countryData;
  }

  void initState() {
    super.initState();

    // Has access to context after first build (to use context)
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final user = Provider.of<UserProvider>(context, listen: false).getUser();
      try {
        final places = await CTrackerAPI().fetchUserPlaces(user);

        setState(() {
          _visitedPlaces = places;
          isFetchingData = false;
        });
      } catch (e) {
        setState(() {
          isFetchingData = false;
          requestError = true;
        });
      }
    });
  }

  renderDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: GlobalStyles.rgbColors['light-gray'],
            title: Text(
              "You have recently notified us that you were infected. You must wait at least 30 days until you can notify again.",
              style: GlobalStyles.standardText,
            ),
            actions: [
              TextButton(
                  style: GlobalStyles.standardButton,
                  onPressed: () => {
                        Navigator.pop(context, 'OK'),
                      },
                  child: Text(
                    "OK",
                  ))
            ],
          );
        });
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
                      child: Consumer<UserProvider>(
                          builder: (context, user, child) => Text(
                              "Welcome, ${user.getUser().firstName}!",
                              style: GlobalStyles.subtitleTextGradient))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                    'Here are some of the latest places you have visited. If you had contact with any infected person., the place will be higlited in red.',
                    style: GlobalStyles.standardSubtextGradient),
              ),
              isFetchingData
                  ? _progressIndicator()
                  : requestError
                      ? _apiErrorMessage()
                      : Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                    height: 470,
                                    child: ListView.builder(
                                        itemCount: _visitedPlaces.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return PlaceCard();
                                        }))
                              ],
                            ),
                          ),
                        ),
              _imInfectedButton(context)
            ],
          ),
        ),
      ),
    );
  }

  _imInfectedButton(context) {
    return Consumer<UserProvider>(
        builder: (context, user, child) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () => {
                    if (!user.getUser().notificationEnabled)
                      {renderDialog()}
                    else
                      {Navigator.pushNamed(context, '/notify')}
                  },
                  child: Text("I'm infected!"),
                  style: HomePageStyles.infectedButton,
                ),
              ),
            ));
  }
}

_apiErrorMessage() {
  return Text('errooo');
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

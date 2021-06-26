import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front/apis/covid-data.api.dart';
import 'package:front/localization/localizations.dart';
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
              AppLocalizations.of(context).disabledNotifyMessage,
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
          tooltip: AppLocalizations.of(context).goBack,
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
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                    alignment: Alignment.topLeft,
                    child: Consumer<UserProvider>(
                        builder: (context, user, child) => Text(
                            AppLocalizations.of(context).welcomeName +
                                "${user.getUser().firstName}!",
                            style: GlobalStyles.subtitleTextGradient))),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(AppLocalizations.of(context).latestPlacesMessage,
                    style: GlobalStyles.standardSubtextGradient),
              ),
              isFetchingData
                  ? _progressIndicator()
                  : requestError
                      ? _apiErrorMessage(context)
                      : Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Container(
                            child: Column(
                              children: [
                                Container(
                                    height: 440,
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            switch (index) {
              case 0:
                break;
              case 1:
                Navigator.pushNamed(context, '/map');
                break;
            }
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: 'Estou Infectado',
              backgroundColor: Colors.red,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_business),
              label: 'Cadastrar Estabelecimento',
              backgroundColor: Colors.red,
            )
          ]),
    );
  }
}

_apiErrorMessage(BuildContext context) {
  return Text(AppLocalizations.of(context).error);
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

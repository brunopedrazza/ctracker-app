import 'package:flutter/material.dart';
import 'package:front/localization/localizations.dart';
import 'package:front/models/country-data.model.dart';
import 'package:front/models/place.model.dart';
import 'package:front/pages/home/widgets/place-card.widget.dart';
import 'package:front/providers/user.provider.dart';
import 'package:provider/provider.dart';
import 'package:front/apis/ctracker.api.dart';
import '../../global.style.dart';
import 'package:google_maps_webservice/places.dart' as GWS;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool requestError = false;
  bool isFetchingData = true;
  List<CountryData> countries = [];
  List<Place> _visitedPlaces;
  GWS.GoogleMapsPlaces placesAPI =
      GWS.GoogleMapsPlaces(apiKey: "AIzaSyBodQ0h0rcBh1l8bE3VAhwHCs1e31lPwKU");
  bool _isNotifying = false;

  void initState() {
    super.initState();

    // Has access to context after first build (to use context)
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final user = Provider.of<UserProvider>(context, listen: false).getUser();
      try {
        final response = await CTrackerAPI().fetchUserPlaces(user);
        final List<Place> places = [];
        for (int i = 0; i < response.length; i++) {
          final placeDetails =
              await placesAPI.getDetailsByPlaceId(response[i].id);
          response[i].vicinity = placeDetails.result.vicinity;
          response[i].name = placeDetails.result.name;
          places.add(response[i]);
        }

        setState(() {
          _visitedPlaces = places;
          isFetchingData = false;
        });
      } catch (e) {
        setState(() {
          isFetchingData = false;
          requestError = true;
        });
        print(e);
      }
    });
  }

  renderDialog(messageType) {
    String messageText;

    switch (messageType) {
      case 1:
        // Trying to notify whithout places.
        messageText = AppLocalizations.of(context).onePlaceNeeded;
        break;
      case 2:
        // Error while fetching places.
        messageText = AppLocalizations.of(context).placesFetchError;
        break;
      case 3:
        // Error while notifying.
        messageText = AppLocalizations.of(context).notificationError;
        break;
      case 4:
        // User already notified.
        messageText = AppLocalizations.of(context).alreadyNotified;
        break;
      case 5:
        // User already notified.
        messageText = AppLocalizations.of(context).successfullyNotified;
        break;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: GlobalStyles.rgbColors['light-gray'],
            title: Text(
              messageText,
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

  notify() async {
    final user = Provider.of<UserProvider>(context, listen: false).getUser();
    if (_visitedPlaces.length == 0) {
      renderDialog(1);
      return;
    } else if (!user.notificationEnabled) {
      renderDialog(4);
      return;
    }

    try {
      setState(() {
        _isNotifying = true;
      });
      await CTrackerAPI().notifyInfection(user, 'Tontura');
      setState(() {
        _isNotifying = false;
      });
    } catch (e) {
      print(e);
    }
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
                      : _visitedPlaces.length == 0
                          ? Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                'Nenhum estabelecimento cadastrado.',
                                style: GlobalStyles.standardSubtextGradient,
                              ),
                            )
                          : Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: ListView.builder(
                                    itemCount: _visitedPlaces.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return VisitedPlaceCard(
                                          _visitedPlaces[index]);
                                    }),
                              ),
                            ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: GlobalStyles.rgbColors['dark-gray'],
        onTap: (index) async {
          switch (index) {
            case 0:
              await notify();
              break;
            case 1:
              Navigator.pushNamed(context, '/map');
              break;
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_hospital_outlined,
              color: Colors.red,
            ),
            label: 'Estou Infectado',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_business, color: Colors.white),
            label: 'Cadastrar Estabelecimento',
          )
        ],
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
      ),
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

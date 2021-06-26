import 'package:flutter/material.dart';
import 'package:front/global.style.dart';
import 'package:front/localization/localizations.dart';
import 'package:front/providers/user.provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart' as GWS;

class RegisterPlacePage extends StatefulWidget {
  @override
  _RegisterPlacePageState createState() => _RegisterPlacePageState();
}

class _RegisterPlacePageState extends State<RegisterPlacePage> {
  GoogleMapController _mapController;
  LocationData currentLocation;
  Location location = Location();
  bool _isLoadingCurrentPosition = false;
  GWS.GoogleMapsPlaces _places =
      GWS.GoogleMapsPlaces(apiKey: "AIzaSyBodQ0h0rcBh1l8bE3VAhwHCs1e31lPwKU");
  List<GWS.PlacesSearchResult> places = [];
  Set<Marker> _markers;
  List<GWS.PlacesSearchResult> _nearbyPlaces = [];

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    final location = await getCurrentLocation();
    await getNearbyPlaces(location);
  }

  getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    try {
      serviceEnabled = await location.serviceEnabled();
      if (!serviceEnabled) {
        serviceEnabled = await location.requestService();
        if (!serviceEnabled) {
          throw Error();
        }
      }

      permissionGranted = await location.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = await location.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          throw Error();
        }
      }

      setState(() {
        _isLoadingCurrentPosition = true;
      });
      locationData = await location.getLocation();
      setState(() {
        _isLoadingCurrentPosition = false;
      });

      if (_mapController != null) {
        _mapController.animateCamera(CameraUpdate.newCameraPosition(
            new CameraPosition(
                zoom: 18,
                target:
                    LatLng(locationData.latitude, locationData.longitude))));
      }
      return locationData;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getNearbyPlaces(LocationData currentLocation) async {
    try {
      final location = GWS.Location(
          lat: currentLocation.latitude, lng: currentLocation.longitude);

      final result = await _places.searchNearbyWithRadius(location, 500);
      if (result.results.length > 0) {
        setState(() {
          _nearbyPlaces = result.results;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  getClosestPlace(LatLng latLng) async {
    final location = GWS.Location(lat: latLng.latitude, lng: latLng.longitude);
    final result = await _places.searchNearbyWithRadius(location, 100);
    print(result.results);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Place'),
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
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              children: [
                Container(
                    alignment: Alignment.topLeft,
                    child: Consumer<UserProvider>(
                        builder: (context, user, child) => Text(
                            "Registrar um novo estabelecimento",
                            style: GlobalStyles.subtitleTextGradient))),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Container(
                      alignment: Alignment.center,
                      child: Consumer<UserProvider>(
                          builder: (context, user, child) => Text(
                              "Aqui você pode cadastrar um mestabelecimento ao qual você visitou, baseado na localização selecionada no mapa. \nCaso algum outro usuário que tenha visitado esse mesmo estabelecimento nos indique que está infectado, você será notificado.",
                              style: GlobalStyles.standardSubtextGradient))),
                ),
                Container(
                  height: 300,
                  child: ListView.builder(
                      itemCount:
                          Provider.of<UserProvider>(context, listen: false)
                              .getNearbyPlaces()
                              .length,
                      itemBuilder: (context, index) => Text('aa')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _progressIndicator() {
    return Container(
      decoration: BoxDecoration(gradient: GlobalStyles.standardGradient),
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
    );
  }
}

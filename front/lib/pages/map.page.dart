import 'package:flutter/material.dart';
import 'package:front/global.style.dart';
import 'package:front/localization/localizations.dart';
import 'package:front/providers/user.provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_webservice/places.dart' as GWS;

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  GoogleMapController _mapController;
  LocationData _currentLocation;
  bool _isLoadingCurrentPosition = false;
  GWS.GoogleMapsPlaces placesAPI =
      GWS.GoogleMapsPlaces(apiKey: "AIzaSyBodQ0h0rcBh1l8bE3VAhwHCs1e31lPwKU");

  void _onMapCreated(GoogleMapController controller) async {
    _mapController = controller;
    await getCurrentLocationAndSetMap();
  }

  getCurrentLocationAndSetMap() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;
    Location location = Location();
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
        _currentLocation = locationData;
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

  Future<void> getNearbyPlaces(context) async {
    try {
      final location = GWS.Location(
          lat: _currentLocation.latitude, lng: _currentLocation.longitude);

      final result = await placesAPI.searchNearbyWithRadius(location, 500);
      Provider.of<UserProvider>(context, listen: false)
          .setNearbyPlaces(result.results);
      Navigator.pushNamed(context, '/register-place');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Nearby Places'),
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
      body: Stack(
          fit: StackFit.loose,
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              child: GoogleMap(
                  onTap: (latLng) => {getNearbyPlaces(context)},
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                      target: _currentLocation != null
                          ? LatLng(_currentLocation.latitude,
                              _currentLocation.longitude)
                          : LatLng(45.521563, -122.677433),
                      zoom: 17)),
            ),
            _isLoadingCurrentPosition ? _progressIndicator() : SizedBox()
          ]),
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

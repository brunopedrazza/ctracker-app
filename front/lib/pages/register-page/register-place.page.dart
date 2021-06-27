import 'package:flutter/material.dart';
import 'package:front/apis/ctracker.api.dart';
import 'package:front/global.style.dart';
import 'package:front/localization/localizations.dart';
import 'package:front/models/place.model.dart';
import 'package:front/pages/register-page/widgets/visited-place.widget.dart';
import 'package:front/providers/user.provider.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_webservice/places.dart' as GWS;

class RegisterPlacePage extends StatefulWidget {
  @override
  _RegisterPlacePageState createState() => _RegisterPlacePageState();
}

class _RegisterPlacePageState extends State<RegisterPlacePage> {
  bool _isRegistering = false;

  registerPlace(GWS.PlacesSearchResult placeData) async {
    var now = DateTime.now();
    final arrival = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: 'Horário de chegada');
    final departure = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: 'Horário de saída');

    if (arrival == null || departure == null) {
      renderDialog();
    }

    final formattedArrival =
        '${now.day}/0${now.month}/${now.year} ${arrival.hour}:${arrival.minute}';
    final formattedDeparture =
        '${now.day}/0${now.month}/${now.year} ${departure.hour}:${departure.minute}';

    final place = Place(
        arrivalDate: formattedArrival,
        departureDate: formattedDeparture,
        id: placeData.placeId);

    try {
      setState(() {
        _isRegistering = true;
      });
      await CTrackerAPI().registerUserPlace(
          place, Provider.of<UserProvider>(context, listen: false).getUser());
      setState(() {
        _isRegistering = false;
      });
      Navigator.popUntil(context, ModalRoute.withName('/login'));
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      print(e);
    }
  }

  renderDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: GlobalStyles.rgbColors['light-gray'],
            title: Text(
              'Aviso',
              style: GlobalStyles.standardText,
            ),
            content: Text(
              'Horário de chegada e saída devem ser definidos',
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
      body: Stack(
        children: [
          Container(
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
                                  style:
                                      GlobalStyles.standardSubtextGradient))),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ListView.builder(
                            itemCount: Provider.of<UserProvider>(context,
                                    listen: false)
                                .getNearbyPlaces()
                                .length,
                            itemBuilder: (context, index) => NearbyPlaceCard(
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .getNearbyPlaces()[index],
                                registerPlace)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          _isRegistering
              ? _progressIndicator()
              : SizedBox(
                  height: 0,
                )
        ],
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/global.style.dart';
import 'package:google_maps_webservice/places.dart';

// ignore: must_be_immutable
class NearbyPlaceCard extends StatelessWidget {
  PlacesSearchResult placeData;
  Function registerPlace;
  NearbyPlaceCard(this.placeData, this.registerPlace);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Color.fromRGBO(174, 174, 174, 0.7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text("${placeData.name}"),
              subtitle: Text('${placeData.vicinity}'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                TextButton(
                  child: Text(
                    'Register',
                    style: GlobalStyles.standardSubtextGradient,
                  ),
                  onPressed: () {
                    registerPlace(placeData);
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

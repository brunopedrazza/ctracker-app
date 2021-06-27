import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/global.style.dart';
import 'package:front/models/place.model.dart';

// ignore: must_be_immutable
class VisitedPlaceCard extends StatelessWidget {
  Place placeData;

  VisitedPlaceCard(this.placeData);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: placeData.numberOfNotifications > 0
            ? Color.fromRGBO(217, 113, 123, 0.7)
            : Color.fromRGBO(174, 174, 174, 0.7),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Text("${placeData.name}"),
              subtitle: Text('${placeData.vicinity}'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Text(
                        "Data de chegada: ${placeData.arrivalDate}",
                        style: GlobalStyles.standardSubtextGradient,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 8.0),
                  child: Row(
                    children: [
                      Text(
                        "Data de saida: ${placeData.departureDate}",
                        style: GlobalStyles.standardSubtextGradient,
                      ),
                    ],
                  ),
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

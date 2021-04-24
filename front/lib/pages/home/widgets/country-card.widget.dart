import 'package:flutter/material.dart';
import 'package:front/global.style.dart';
import 'package:front/models/country-data.model.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryCard extends StatelessWidget {
  final CountryData country;

  CountryCard({@required this.country});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              country.country,
              style: GoogleFonts.raleway(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                  color: GlobalStyles.rgbColors['dark-gray']),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Confirmed Cases: ${country.confirmed}',
              style: GoogleFonts.raleway(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Recovered Cases: ${country.recovered}',
              style: GoogleFonts.raleway(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Critical Cases: ${country.critical}',
              style: GoogleFonts.raleway(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              'Total Deaths: ${country.deaths}',
              style: GoogleFonts.raleway(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(70, 0, 0, 1)),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
          border: Border.fromBorderSide(
              BorderSide(color: GlobalStyles.rgbColors['dark-gray'])),
          color: GlobalStyles.rgbColors['light-gray'],
          borderRadius: BorderRadius.circular(10)),
    );
  }
}

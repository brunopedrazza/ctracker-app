import 'package:flutter/material.dart';
import 'package:front/global.style.dart';
import 'package:front/models/country-data.model.dart';
import 'package:google_fonts/google_fonts.dart';

class CountryCard extends StatefulWidget {
  final CountryData country;

  CountryCard({@required this.country});

  @override
  _CountryCardState createState() => _CountryCardState();
}

class _CountryCardState extends State<CountryCard> {
  bool shouldRenderInfo = false;

  renderInfo() {
    setState(() {
      shouldRenderInfo = !shouldRenderInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: GlobalStyles.rgbColors['dark-gray'],
          blurRadius: 10.0,
        ),
      ]),
      child: SizedBox(
        height: 100,
        child: Card(
          semanticContainer: true,
          color: GlobalStyles.rgbColors['light-gray'],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    widget.country.country,
                    style: GoogleFonts.raleway(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                        color: GlobalStyles.rgbColors['dark-gray']),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              shouldRenderInfo
                  ? Wrap(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            'Confirmed Cases: ${widget.country.confirmed}',
                            style: GoogleFonts.raleway(
                                fontSize: 12.0,
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
                            'Recovered Cases: ${widget.country.recovered}',
                            style: GoogleFonts.raleway(
                                fontSize: 12.0,
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
                            'Critical Cases: ${widget.country.critical}',
                            style: GoogleFonts.raleway(
                                fontSize: 12.0,
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
                            'Total Deaths: ${widget.country.deaths}',
                            style: GoogleFonts.raleway(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(70, 0, 0, 1)),
                          ),
                        )
                      ],
                    )
                  : SizedBox(
                      height: 0,
                    ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () => renderInfo(),
                    child: Text('Show Info'),
                    style: GlobalStyles.standardButton,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

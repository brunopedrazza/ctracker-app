import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePageStyles {
  static final infectedButton = ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(GoogleFonts.raleway(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      )),
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromRGBO(80, 0, 0, 1)),
      minimumSize:
          MaterialStateProperty.resolveWith<Size>((Set<MaterialState> states) {
        return Size(98, 40);
      }));
}

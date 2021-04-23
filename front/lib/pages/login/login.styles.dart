import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//@todo: criar arquivo de estilos central
final styles = {
  'button': ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(GoogleFonts.raleway(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      )),
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromRGBO(50, 50, 50, 0.6)),
      minimumSize:
          MaterialStateProperty.resolveWith<Size>((Set<MaterialState> states) {
        return Size(95, 40);
      })),
  'welcome-text': GoogleFonts.raleway(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w400,
  )
};

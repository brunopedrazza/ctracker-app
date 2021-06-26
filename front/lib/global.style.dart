import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GlobalStyles {
  static final rgbColors = {
    'ivory': Color.fromRGBO(100, 100, 100, 1),
    'dark-gray': Color.fromRGBO(50, 50, 50, 1),
    'light-gray': Color.fromRGBO(91, 91, 92, 1),
  };

  static final titleTextGradient = GoogleFonts.raleway(
      fontSize: 50.0,
      fontWeight: FontWeight.w400,
      foreground: Paint()
        ..shader = GlobalStyles.standardGradient
            .createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)));

  static final subtitleTextGradient = GoogleFonts.raleway(
      fontSize: 30.0,
      fontWeight: FontWeight.w600,
      foreground: Paint()
        ..shader = GlobalStyles.standardGradient
            .createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)));

  static final standardSubtextGradient = GoogleFonts.raleway(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      foreground: Paint()
        ..shader = GlobalStyles.standardGradient
            .createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)));

  static final standardText = GoogleFonts.raleway(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w400,
  );

  static final boldText = GoogleFonts.raleway(
    color: Colors.white,
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );

  static final standardButton = ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(GoogleFonts.raleway(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      )),
      backgroundColor:
          MaterialStateProperty.all<Color>(Color.fromRGBO(50, 50, 50, 0.6)),
      minimumSize:
          MaterialStateProperty.resolveWith<Size>((Set<MaterialState> states) {
        return Size(98, 40);
      }));

  static final standardGradient = LinearGradient(colors: [
    Color.fromRGBO(100, 100, 94, 0.695),
    Color.fromRGBO(73, 72, 74, 0.695),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));

  static standardTextField(helperText, error, errorText) {
    return error
        ? InputDecoration(
            errorText: errorText,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: GlobalStyles.rgbColors['dark-gray'], width: 2)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: GlobalStyles.rgbColors['ivory'], width: 2)),
            hintText: helperText)
        : InputDecoration(
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: GlobalStyles.rgbColors['dark-gray'], width: 2)),
            border: OutlineInputBorder(),
            hintText: helperText);
  }
}

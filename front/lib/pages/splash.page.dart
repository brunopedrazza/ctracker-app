import 'dart:math';
import 'package:front/global.style.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _visible = true;
  final linearGradient = LinearGradient(colors: [
    Color.fromRGBO(100, 100, 94, 0.695),
    Color.fromRGBO(73, 72, 74, 0.695),
  ], stops: [
    0.0,
    0.695
  ], transform: GradientRotation(2.13959913 * pi));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: linearGradient),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150, bottom: 150),
                child: Text(
                  'Welcome to CTracker App!',
                  style: GlobalStyles.boldText,
                ),
              ),
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: ElevatedButton(
                  onPressed: () => setState(() => {_visible = !_visible}),
                  child: Text('Login'),
                  style: GlobalStyles.standardButton,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () => setState(() => {}),
                  child: Text('Sign Up'),
                  style: GlobalStyles.standardButton,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

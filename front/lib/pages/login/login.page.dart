import 'dart:math';
import './login.styles.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                padding: const EdgeInsets.only(top: 210),
                child: Text(
                  'Welcome to CTracker App!',
                  style: styles['welcome-text'],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ElevatedButton(
                  onPressed: () => setState(() => {}),
                  child: Text('Login'),
                  style: styles['button'],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                  onPressed: () => setState(() => {}),
                  child: Text('Cadastrar'),
                  style: styles['button'],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

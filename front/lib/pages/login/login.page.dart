import 'dart:math';
import './login.styles.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  bool _isValidating = false;

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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          tooltip: 'Go Back',
          onPressed: () {
            // pop
          },
        ),
        backgroundColor: styles['appbar-background'],
      ),
      body: _isValidating
          ? Container(
              decoration: BoxDecoration(gradient: linearGradient),
              child: Center(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: CircularProgressIndicator(
                    strokeWidth: 5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(50, 50, 50, 1)),
                  ),
                ),
              ),
            )
          : Container(
              decoration: BoxDecoration(gradient: linearGradient),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Text(
                          'Welcome to CTracker App!',
                          style: styles['welcome-text'],
                        ),
                      ),
                      Wrap(
                        spacing: 10,
                        direction: Axis.vertical,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextField(
                                onChanged: (text) {
                                  setState(() {
                                    _email = text;
                                  });
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Email')),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: TextField(
                                onChanged: (text) {
                                  setState(() {
                                    _password = text;
                                  });
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Password')),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () =>
                              setState(() => {_isValidating = true}),
                          child: Text('Login'),
                          style: styles['button'],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: ElevatedButton(
                          onPressed: () => setState(() => {}),
                          child: Text('Cancel'),
                          style: styles['button'],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

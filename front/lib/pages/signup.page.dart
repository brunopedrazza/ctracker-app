import 'package:flutter/material.dart';

import '../global.style.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            tooltip: 'Go Back',
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: GlobalStyles.rgbColors['dark-gray'],
        ),
        body: Container(
          decoration: BoxDecoration(gradient: GlobalStyles.standardGradient),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 20),
                      child: Text(
                        'Sign Up to our Platform!',
                        style: GlobalStyles.titleTextGradient,
                      ),
                    ),
                    TextFormField(
                      decoration:
                          GlobalStyles.standardTextField('Type your name'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          GlobalStyles.standardTextField('Type your surname'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          GlobalStyles.standardTextField('Type your email'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          GlobalStyles.standardTextField('Type your birthday'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          GlobalStyles.standardTextField('Type your password'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: GlobalStyles.standardTextField(
                          'Re-type your password'),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: GlobalStyles.standardButton,
                            onPressed: () => {},
                            child: Text('Sign Up')),
                        ElevatedButton(
                            style: GlobalStyles.standardButton,
                            onPressed: () => Navigator.pushNamed(context, '/'),
                            child: Text('Cancel')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

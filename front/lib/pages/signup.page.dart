import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/apis/ctracker.api.dart';
import 'package:front/models/user.model.dart';
import 'package:crypto/crypto.dart';
import '../global.style.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String _userFirstName;
  String _userLastName;
  String _userEmail;
  String _userPassword;
  String _userBirthdate;

  updateUserData(String userData, String input) {
    switch (userData) {
      case 'first_name':
        setState(() {
          _userFirstName = input;
        });
        break;
      case 'last_name':
        setState(() {
          _userLastName = input;
        });
        break;
      case 'email':
        setState(() {
          _userEmail = input;
        });
        break;
      case 'birthdate':
        setState(() {
          _userBirthdate = input;
        });
        break;
      case 'password':
        setState(() {
          _userPassword = input;
        });
        break;
      default:
    }
  }

  Future signUpUser() async {
    final bytes = utf8.encode(_userPassword);
    final newUser = new User(
        firstName: _userFirstName,
        lastName: _userLastName,
        email: _userEmail,
        birthday: _userBirthdate,
        password: sha512.convert(bytes).toString());

    final signUpStatus = await CTrackerAPI().signup(newUser);
    print(newUser.password.toString().length);
  }

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
                      decoration: GlobalStyles.standardTextField(
                          'Type your first name'),
                      onChanged: ((text) =>
                          {updateUserData('first_name', text)}),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          GlobalStyles.standardTextField('Type your last name'),
                      onChanged: ((text) =>
                          {updateUserData('last_name', text)}),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration:
                            GlobalStyles.standardTextField('Type your email'),
                        onChanged: ((text) => {updateUserData('email', text)})),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        decoration: GlobalStyles.standardTextField(
                            'Type your birthday'),
                        onChanged: ((text) =>
                            {updateUserData('birthdate', text)})),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                        obscureText: true,
                        decoration: GlobalStyles.standardTextField(
                            'Type your password'),
                        onChanged: ((text) =>
                            {updateUserData('password', text)})),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            style: GlobalStyles.standardButton,
                            onPressed: () async => {signUpUser()},
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

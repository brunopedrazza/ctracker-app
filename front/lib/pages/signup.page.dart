import 'package:flutter/material.dart';
import 'package:front/localization/localizations.dart';
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
  bool _signingUp = false;
  String _dialogMessage;
  Map<String, Map<String, Object>> _invalidInputs = {
    'firstName': {'error': false, 'message': ''},
    'lastName': {'error': false, 'message': ''},
    'email': {'error': false, 'message': ''},
    'password': {'error': false, 'message': ''},
    'birthdate': {'error': false, 'message': ''}
  };

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
    if (!validInputs()) {
      return;
    }
    final bytes = utf8.encode(_userPassword);
    final newUser = new User(
        firstName: _userFirstName,
        lastName: _userLastName,
        email: _userEmail,
        birthday: _userBirthdate,
        password: sha512.convert(bytes).toString());

    try {
      setState(() {
        _signingUp = true;
      });
      await CTrackerAPI().signup(newUser);
      setState(() {
        _signingUp = false;
        _dialogMessage = AppLocalizations.of(context).registered;
      });
      renderDialog();
    } catch (e) {
      setState(() {
        _signingUp = false;
        _dialogMessage = AppLocalizations.of(context).error;
      });
      renderDialog();
    }
  }

  bool validInputs() {
    bool valid = true;
    var updatedInputStatus = {..._invalidInputs};
    if (_userBirthdate == null) {
      updatedInputStatus['birthdate']['error'] = true;
      updatedInputStatus['birthdate']['message'] =
          AppLocalizations.of(context).birthdateInputValidation;

      valid = false;
    } else {
      updatedInputStatus['birthdate']['error'] = false;
      updatedInputStatus['birthdate']['message'] = '';
    }

    if (_userEmail == null) {
      updatedInputStatus['email']['error'] = true;
      updatedInputStatus['email']['message'] =
          AppLocalizations.of(context).emailInputValidation;

      valid = false;
    } else {
      updatedInputStatus['email']['error'] = false;
      updatedInputStatus['email']['message'] = '';
    }
    if (_userFirstName == null) {
      updatedInputStatus['firstName']['error'] = true;
      updatedInputStatus['firstName']['message'] =
          AppLocalizations.of(context).nameInputValidation;

      valid = false;
    } else {
      updatedInputStatus['firstName']['error'] = false;
      updatedInputStatus['firstName']['message'] = '';
    }
    if (_userLastName == null) {
      updatedInputStatus['lastName']['error'] = true;
      updatedInputStatus['lastName']['message'] =
          AppLocalizations.of(context).surnameInputValidation;
      valid = false;
    } else {
      updatedInputStatus['lastName']['error'] = false;
      updatedInputStatus['lastName']['message'] = '';
    }
    if (_userPassword == null) {
      updatedInputStatus['password']['error'] = true;
      updatedInputStatus['password']['message'] =
          AppLocalizations.of(context).passwordInputValidation;
      valid = false;
    } else {
      updatedInputStatus['password']['error'] = false;
      updatedInputStatus['password']['message'] = '';
    }

    if (!valid) {
      setState(() {
        _invalidInputs = updatedInputStatus;
      });
    }
    return valid;
  }

  renderDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: GlobalStyles.rgbColors['light-gray'],
            title: Text(
              _dialogMessage,
              style: GlobalStyles.standardText,
            ),
            actions: [
              TextButton(
                  style: GlobalStyles.standardButton,
                  onPressed: () => {
                        Navigator.pop(context, 'OK'),
                        Navigator.pushNamed(context, '/login'),
                      },
                  child: Text(
                    "OK",
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).signUp),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_rounded),
            tooltip: AppLocalizations.of(context).goBack,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: GlobalStyles.rgbColors['dark-gray'],
        ),
        body: _signingUp
            ? _progressIndicator()
            : Container(
                decoration:
                    BoxDecoration(gradient: GlobalStyles.standardGradient),
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
                              AppLocalizations.of(context).signUpMessage,
                              style: GlobalStyles.titleTextGradient,
                            ),
                          ),
                          TextFormField(
                            decoration: GlobalStyles.standardTextField(
                                AppLocalizations.of(context).nameInput,
                                _invalidInputs['firstName']['error'],
                                _invalidInputs['firstName']['message']),
                            onChanged: ((text) =>
                                {updateUserData('first_name', text)}),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            decoration: GlobalStyles.standardTextField(
                                AppLocalizations.of(context).surnameInput,
                                _invalidInputs['lastName']['error'],
                                _invalidInputs['lastName']['message']),
                            onChanged: ((text) =>
                                {updateUserData('last_name', text)}),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              decoration: GlobalStyles.standardTextField(
                                  AppLocalizations.of(context).emailInput,
                                  _invalidInputs['email']['error'],
                                  _invalidInputs['email']['message']),
                              onChanged: ((text) =>
                                  {updateUserData('email', text)})),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              decoration: GlobalStyles.standardTextField(
                                  AppLocalizations.of(context).birthdateInput,
                                  _invalidInputs['birthdate']['error'],
                                  _invalidInputs['birthdate']['message']),
                              onChanged: ((text) =>
                                  {updateUserData('birthdate', text)})),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              obscureText: true,
                              decoration: GlobalStyles.standardTextField(
                                  AppLocalizations.of(context).passwordInput,
                                  _invalidInputs['password']['error'],
                                  _invalidInputs['password']['message']),
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
                                  child: Text(AppLocalizations.of(context).signUp)),
                              ElevatedButton(
                                  style: GlobalStyles.standardButton,
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/'),
                                  child: Text(AppLocalizations.of(context).cancel)),
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

_progressIndicator() {
  return Container(
    decoration: BoxDecoration(gradient: GlobalStyles.standardGradient),
    child: Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: CircularProgressIndicator(
          strokeWidth: 5,
          valueColor: AlwaysStoppedAnimation<Color>(
              GlobalStyles.rgbColors['dark-gray']),
        ),
      ),
    ),
  );
}

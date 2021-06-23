import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:front/apis/ctracker.api.dart';
import 'package:front/global.style.dart';
import 'package:flutter/material.dart';
import 'package:front/providers/user.provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  bool _isValidating = false;
  Map<String, Map<String, Object>> _invalidInputs = {
    'email': {'error': false, 'message': ''},
    'password': {'error': false, 'message': ''},
  };

  setEmail(text) {
    setState(() {
      _email = text;
    });
  }

  setPassword(text) {
    setState(() {
      _password = text;
    });
  }

  validInputs() {
    var updatedInputStatus = {..._invalidInputs};
    bool valid = true;
    if (_email == null) {
      updatedInputStatus['email']['error'] = true;
      updatedInputStatus['email']['message'] = 'Please check your email.';

      valid = false;
    } else {
      updatedInputStatus['email']['error'] = false;
      updatedInputStatus['email']['message'] = '';
    }

    if (_password == null) {
      updatedInputStatus['password']['error'] = true;
      updatedInputStatus['password']['message'] = 'Please check your password.';

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

  login(BuildContext context) async {
    if (!validInputs()) {
      return;
    }

    setState(() {
      _isValidating = true;
    });
    try {
      final bytes = utf8.encode(_password);
      final encryptedPassword = sha512.convert(bytes).toString();
      final user = await CTrackerAPI().login(_email, encryptedPassword);
      setState(() {
        _isValidating = false;
      });
      Provider.of<UserProvider>(context, listen: false).setUser(user);
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      setState(() {
        _isValidating = false;
      });
      renderDialog();
    }
  }

  renderDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: GlobalStyles.rgbColors['light-gray'],
            title: Text(
              "Invalid email or password. Please try again.",
              style: GlobalStyles.standardText,
            ),
            actions: [
              TextButton(
                  style: GlobalStyles.standardButton,
                  onPressed: () => {
                        Navigator.pop(context, 'OK'),
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
        title: Text('CTracker'),
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
      body: _isValidating
          ? _progressIndicator()
          : Container(
              decoration:
                  BoxDecoration(gradient: GlobalStyles.standardGradient),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: Text(
                          'Login',
                          style: GlobalStyles.titleTextGradient,
                        ),
                      ),
                      _userInputs(
                          context, setPassword, setEmail, _invalidInputs),
                      _buttons(context, login)
                    ],
                  ),
                ),
              ),
            ),
    );
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

_userInputs(context, setPassword, setEmail, _invalidInputs) {
  return Wrap(
    spacing: 10,
    direction: Axis.vertical,
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
            onChanged: (text) {
              setEmail(text);
            },
            decoration: GlobalStyles.standardTextField(
                'Email',
                _invalidInputs['email']['error'],
                _invalidInputs['email']['message'])),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
            onChanged: (text) {
              setPassword(text);
            },
            obscureText: true,
            decoration: GlobalStyles.standardTextField(
                'Password',
                _invalidInputs['password']['error'],
                _invalidInputs['password']['message'])),
      )
    ],
  );
}

_buttons(context, login) {
  return Wrap(spacing: 10, direction: Axis.vertical, children: [
    Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () => login(context),
        child: Text('Login'),
        style: GlobalStyles.standardButton,
      ),
    ),
    ElevatedButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Cancel'),
      style: GlobalStyles.standardButton,
    )
  ]);
}

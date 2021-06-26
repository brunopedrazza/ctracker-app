import 'package:front/global.style.dart';
import 'package:flutter/material.dart';
import 'package:front/localization/localizations.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  bool _isValidating = false;

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

  validateInputs() async {
    // check if email is valid
    // if (!_email.contains('@')) {
    //   // indicate error on field
    //   return;
    // }

    setState(() {
      _isValidating = true;
    });
    await Future.delayed(const Duration(seconds: 1), () {});
    // if valid, push(/home)
    //
    setState(() {
      _isValidating = false;
    });
    Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CTracker'),
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
                          AppLocalizations.of(context).login,
                          style: GlobalStyles.titleTextGradient,
                        ),
                      ),
                      _userInputs(context, setPassword, setEmail),
                      _buttons(context, validateInputs)
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

_userInputs(
  context,
  setPassword,
  setEmail,
) {
  return Wrap(
    spacing: 10,
    direction: Axis.vertical,
    children: [
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
            onChanged: (text) {
              setPassword(text);
            },
            decoration: GlobalStyles.standardTextField(AppLocalizations.of(context).email)),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
            onChanged: (text) {
              setEmail(text);
            },
            obscureText: true,
            decoration: GlobalStyles.standardTextField(AppLocalizations.of(context).password)),
      )
    ],
  );
}

_buttons(context, validateInputs) {
  return Wrap(spacing: 10, direction: Axis.vertical, children: [
    Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () => validateInputs(),
        child: Text(AppLocalizations.of(context).login),
        style: GlobalStyles.standardButton,
      ),
    ),
    ElevatedButton(
      onPressed: () => Navigator.pop(context),
      child: Text(AppLocalizations.of(context).cancel),
      style: GlobalStyles.standardButton,
    )
  ]);
}

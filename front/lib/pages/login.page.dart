import 'package:front/global.style.dart';
import 'package:flutter/material.dart';

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

  setValidating(text) {
    setState(() {
      _isValidating = true;
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
            // pop
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
                          'Welcome to CTracker App!',
                          style: GlobalStyles.boldText,
                        ),
                      ),
                      _userInputs(context, setPassword, setEmail),
                      _buttons(setValidating)
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
            decoration: GlobalStyles.standardTextField),
      ),
      Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: TextField(
            onChanged: (text) {
              setEmail(text);
            },
            obscureText: true,
            decoration: GlobalStyles.standardTextField),
      )
    ],
  );
}

_buttons(setValidating) {
  return Wrap(spacing: 10, direction: Axis.vertical, children: [
    Padding(
      padding: const EdgeInsets.only(top: 20),
      child: ElevatedButton(
        onPressed: () => setValidating(),
        child: Text('Login'),
        style: GlobalStyles.standardButton,
      ),
    ),
    ElevatedButton(
      onPressed: () => setValidating(),
      child: Text('Cancel'),
      style: GlobalStyles.standardButton,
    )
  ]);
}

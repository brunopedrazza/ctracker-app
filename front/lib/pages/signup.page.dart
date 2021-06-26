import 'package:flutter/material.dart';
import 'package:front/localization/localizations.dart';

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
                        AppLocalizations.of(context).signUpMessage,
                        style: GlobalStyles.titleTextGradient,
                      ),
                    ),
                    TextFormField(
                      decoration:
                          GlobalStyles.standardTextField(AppLocalizations.of(context).nameInput),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          GlobalStyles.standardTextField(AppLocalizations.of(context).surnameInput),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          GlobalStyles.standardTextField(AppLocalizations.of(context).emailInput),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          GlobalStyles.standardTextField(AppLocalizations.of(context).birthdayInput),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration:
                          GlobalStyles.standardTextField(AppLocalizations.of(context).passwordInput),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: GlobalStyles.standardTextField(
                          AppLocalizations.of(context).reTypePassword),
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
                            child: Text(AppLocalizations.of(context).signUp)),
                        ElevatedButton(
                            style: GlobalStyles.standardButton,
                            onPressed: () => Navigator.pushNamed(context, '/'),
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

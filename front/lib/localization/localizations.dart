import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'welcome': 'Welcome to CTracker App!',
      'imInfected': 'I\'m infected!',
      'covidDataMessage': 'Here are some of the latest COVID-19 statistics. Click on the desired country to see more information.',
      'email': 'Email',
      'password': 'Password',
      'login': 'Login',
      'signUp': 'Sign Up',
      'signUpMessage': 'Sign Up to our Platform!',
      'goBack': 'Go Back',
      'cancel': 'Cancel',
      'nameInput': 'Type your name',
      'surnameInput': 'Type your surname',
      'emailInput': 'Type your email',
      'birthdayInput': 'Type your birthday',
      'passwordInput': 'Type your password',
      'reTypePassword': 'Re-type your password'
    },
    'es': {
      'welcome': 'Bienvenido a CTracker!',
      'imInfected': 'Estoy infectado!',
      'covidDataMessage': 'Estas son algunas de las últimas estadísticas de COVID-19. Haga clic en el país deseado para ver más información.',
      'email': 'Correo electrónico',
      'password': 'Contraseña',
      'login': 'Entrar',
      'signUp': 'Inscribirse',
      'signUpMessage': '¡Regístrese en nuestra plataforma!',
      'goBack': 'Regresa',
      'cancel': 'Cancelar',
      'nameInput': 'Digite seu nome',
      'surnameInput': 'Digite seu sobrenome',
      'emailInput': 'Digite seu email',
      'birthdayInput': 'Digite sua data de nascimento',
      'passwordInput': 'Digite sua senha',
      'reTypePassword': 'Digite novamente sua senha'
    },
    'pt': {
      'welcome': 'Bem-vindo ao CTracker!',
      'imInfected': 'Estou infectado!',
      'covidDataMessage': 'Aqui estão algumas das estatísticas mais recentes do COVID-19. Clique no país desejado para ver mais informações.',
      'email': 'Email',
      'password': 'Senha',
      'login': 'Entrar',
      'signUp': 'Inscrever-se',
      'signUpMessage': 'Cadastre-se em nossa plataforma!',
      'goBack': 'Voltar',
      'cancel': 'Cancelar',
      'nameInput': 'Escriba su nombre',
      'surnameInput': 'Escriba su apellido',
      'emailInput': 'Escriba su correo electrónico',
      'birthdayInput': 'Escriba su fecha de nacimiento',
      'passwordInput': 'Escribe tu contraseña',
      'reTypePassword': 'Reescribe tu contraseña'
    },
  };

  String get welcome {
    return _localizedValues[locale.languageCode]['welcome'];
  }

  String get imInfected {
    return _localizedValues[locale.languageCode]['imInfected'];
  }

  String get covidDataMessage {
    return _localizedValues[locale.languageCode]['covidDataMessage'];
  }

  String get email {
    return _localizedValues[locale.languageCode]['email'];
  }

  String get password {
    return _localizedValues[locale.languageCode]['password'];
  }

  String get login {
    return _localizedValues[locale.languageCode]['login'];
  }

  String get signUp {
    return _localizedValues[locale.languageCode]['signUp'];
  }

  String get signUpMessage {
    return _localizedValues[locale.languageCode]['signUpMessage'];
  }

  String get goBack {
    return _localizedValues[locale.languageCode]['goBack'];
  }

  String get cancel {
    return _localizedValues[locale.languageCode]['cancel'];
  }

  String get nameInput {
    return _localizedValues[locale.languageCode]['nameInput'];
  }

  String get surnameInput {
    return _localizedValues[locale.languageCode]['surnameInput'];
  }

  String get emailInput {
    return _localizedValues[locale.languageCode]['emailInput'];
  }

  String get birthdayInput {
    return _localizedValues[locale.languageCode]['birthdayInput'];
  }

  String get passwordInput {
    return _localizedValues[locale.languageCode]['passwordInput'];
  }

  String get reTypePassword {
    return _localizedValues[locale.languageCode]['reTypePassword'];
  }

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
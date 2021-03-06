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
      'welcomeName': 'Welcome, ',
      'imInfected': 'I\'m infected!',
      'covidDataMessage':
          'Here are some of the latest COVID-19 statistics. Click on the desired country to see more information.',
      'disabledNotifyMessage':
          'You have recently notified us that you were infected. You must wait at least 30 days until you can notify again.',
      'latestPlacesMessage':
          'Here are some of the latest places you have visited. If you had contact with any infected person, the place will be highlighted in red.',
      'registered': 'Successfully registered!',
      'error': 'An error has occurred. Please try again.',
      'email': 'Email',
      'password': 'Password',
      'invalidEmailPassword': 'Invalid email or password. Please try again.',
      'login': 'Login',
      'signUp': 'Sign Up',
      'signUpMessage': 'Sign Up to our Platform!',
      'goBack': 'Go Back',
      'cancel': 'Cancel',
      'nameInput': 'Type your name',
      'nameInputValidation': 'Please check your first name.',
      'surnameInput': 'Type your surname',
      'surnameInputValidation': 'Please check your last name.',
      'emailInput': 'Type your email',
      'emailInputValidation': 'Please check your email.',
      'birthdateInput': 'Type your birthday',
      'birthdateInputValidation': 'Please check your birthdate.',
      'passwordInput': 'Type your password',
      'passwordInputValidation': 'Please check your password.',
      'reTypePassword': 'Re-type your password',
      'onePlaceNeeded': 'Must have at least one place to notify.',
      'placesFetchError':
          'An error occurred while fetching your visited places.',
      'notificationError': 'An error occurred while trying to notify.',
      'alreadyNotified': 'You must await 30 days to notify again.',
      'successfullyNotified': 'Users were notified successfully.',
      'arrivalDepartureError': 'Arrival and Departure time must be specified.',
      'arrivalTime': 'Arrival time.',
      'departureTime': 'Departure time.',
      'registerPlace': 'Register a new place.',
      'registerPlaceHelper':
          'Here you can register a new place, based on your current location. \nIn case any user that has visited this place notify us that he | she  is infected, we will warn you.',
      'findNearbyPlaces': 'Find nearby places',
      'registerPlaceHeader': 'Register Place',
    },
    'es': {
      'welcome': 'Bienvenido a CTracker!',
      'welcomeName': 'Bienvenido, ',
      'imInfected': 'Estoy infectado!',
      'covidDataMessage':
          'Estas son algunas de las ??ltimas estad??sticas de COVID-19. Haga clic en el pa??s deseado para ver m??s informaci??n.',
      'disabledNotifyMessage':
          'Recientemente nos notific?? que estaba infectado. Debe esperar al menos 30 d??as hasta que pueda notificar nuevamente.',
      'latestPlacesMessage':
          'Estos son algunos de los ??ltimos lugares que ha visitado. Si tuvo contacto con alguna persona infectada, el lugar se resaltar?? en rojo.',
      'registered': 'Registrado exitosamente!',
      'error': 'Se ha producido un error. Int??ntalo de nuevo.',
      'email': 'Correo electr??nico',
      'password': 'Contrase??a',
      'invalidEmailPassword':
          'Correo electr??nico o contrase??a no v??lidos. Int??ntalo de nuevo.',
      'login': 'Entrar',
      'signUp': 'Inscribirse',
      'signUpMessage': '??Reg??strese en nuestra plataforma!',
      'goBack': 'Regresa',
      'cancel': 'Cancelar',
      'nameInput': 'Escriba su nombre',
      'nameInputValidation': 'Comprueba tu nombre.',
      'surnameInput': 'Escriba su apellido',
      'surnameInputValidation': 'Comprueba tu apellido.',
      'emailInput': 'Escriba su correo electr??nico',
      'emailInputValidation': 'Por favor revise su correo electr??nico.',
      'birthdateInput': 'Escriba su fecha de nacimiento',
      'birthdateInputValidation': 'Comprueba tu fecha de nacimiento.',
      'passwordInput': 'Escribe tu contrase??a',
      'passwordInputValidation': 'Por favor revise su contrase??a.',
      'reTypePassword': 'Reescribe tu contrase??a'
    },
    'pt': {
      'welcome': 'Bem-vindo ao CTracker!',
      'welcomeName': 'Bem-vindo, ',
      'imInfected': 'Estou infectado!',
      'covidDataMessage':
          'Aqui est??o algumas das estat??sticas mais recentes do COVID-19. Clique no pa??s desejado para ver mais informa????es.',
      'disabledNotifyMessage':
          'Voc?? nos notificou recentemente que estava infectado. Por favor, espere pelo menos 30 dias para poder notificar novamente.',
      'latestPlacesMessage':
          'Aqui est??o alguns dos lugares mais recentes que voc?? visitou. Se voc?? teve contato com alguma pessoa infectada, o local ficar?? destacado em vermelho.',
      'registered': 'Registrado com sucesso!',
      'error': 'Acorreu um erro. Por favor, tente novamente.',
      'email': 'Email',
      'password': 'Senha',
      'invalidEmailPassword':
          'E-mail ou senha incorretos. Por favor, tente novamente.',
      'login': 'Entrar',
      'signUp': 'Inscrever-se',
      'signUpMessage': 'Cadastre-se em nossa plataforma!',
      'goBack': 'Voltar',
      'cancel': 'Cancelar',
      'nameInput': 'Digite seu nome',
      'nameInputValidation': 'Por favor, verifique seu nome.',
      'surnameInput': 'Digite seu sobrenome',
      'surnameInputValidation': 'Por favor, verifique seu sobrenome.',
      'emailInput': 'Digite seu email',
      'emailInputValidation': 'Por favor verifique seu email.',
      'birthdateInput': 'Digite sua data de nascimento',
      'birthdateInputValidation': 'Verifique sua data de nascimento.',
      'passwordInput': 'Digite sua senha',
      'passwordInputValidation': 'Por favor, verifique sua senha.',
      'reTypePassword': 'Digite novamente sua senha',
      'onePlaceNeeded':
          'Deve ter cadastrado ao menos um estabelecimento para notificar.',
      'placesFetchError':
          'Ocorreu um erro ao buscar seus estabelecimnentos visitados.',
      'notificationError': 'Ocorreu um erro ao notificar.',
      'alreadyNotified':
          'Voc?? deve aguardar 30 dias at?? poder notificar novamente.',
      'successfullyNotified': 'Usu??rios foram notificados com sucesso.',
      'arrivalDepartureError':
          'Hor??rio de chegada e sa??da devem ser especificados.',
      'arrivalTime': 'Hora de chegada.',
      'departureTime': 'Hora de sa??da.',
      'registerPlace': 'Cadastrar um novo estabelecimento.',
      'registerPlaceHelper':
          'Aqui voc?? pode cadastrar um mestabelecimento ao qual voc?? visitou, baseado na localiza????o selecionada no mapa. \nCaso algum outro usu??rio que tenha visitado esse mesmo estabelecimento nos indique que est?? infectado, voc?? ser?? notificado.',
      'findNearbyPlaces': 'Buscar locais pr??ximos',
      'registerPlaceHeader': 'Cadastrar Estabelecimento',
    },
  };

  String get welcome {
    return _localizedValues[locale.languageCode]['welcome'];
  }

  String get welcomeName {
    return _localizedValues[locale.languageCode]['welcomeName'];
  }

  String get imInfected {
    return _localizedValues[locale.languageCode]['imInfected'];
  }

  String get covidDataMessage {
    return _localizedValues[locale.languageCode]['covidDataMessage'];
  }

  String get disabledNotifyMessage {
    return _localizedValues[locale.languageCode]['disabledNotifyMessage'];
  }

  String get latestPlacesMessage {
    return _localizedValues[locale.languageCode]['latestPlacesMessage'];
  }

  String get registered {
    return _localizedValues[locale.languageCode]['registered'];
  }

  String get error {
    return _localizedValues[locale.languageCode]['error'];
  }

  String get email {
    return _localizedValues[locale.languageCode]['email'];
  }

  String get password {
    return _localizedValues[locale.languageCode]['password'];
  }

  String get invalidEmailPassword {
    return _localizedValues[locale.languageCode]['invalidEmailPassword'];
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

  String get nameInputValidation {
    return _localizedValues[locale.languageCode]['nameInputValidation'];
  }

  String get surnameInput {
    return _localizedValues[locale.languageCode]['surnameInput'];
  }

  String get surnameInputValidation {
    return _localizedValues[locale.languageCode]['surnameInputValidation'];
  }

  String get emailInput {
    return _localizedValues[locale.languageCode]['emailInput'];
  }

  String get emailInputValidation {
    return _localizedValues[locale.languageCode]['emailInputValidation'];
  }

  String get birthdateInput {
    return _localizedValues[locale.languageCode]['birthdateInput'];
  }

  String get birthdateInputValidation {
    return _localizedValues[locale.languageCode]['birthdateInputValidation'];
  }

  String get passwordInput {
    return _localizedValues[locale.languageCode]['passwordInput'];
  }

  String get passwordInputValidation {
    return _localizedValues[locale.languageCode]['passwordInputValidation'];
  }

  String get reTypePassword {
    return _localizedValues[locale.languageCode]['reTypePassword'];
  }

  String get onePlaceNeeded {
    return _localizedValues[locale.languageCode]['onePlaceNeeded'];
  }

  String get placesFetchError {
    return _localizedValues[locale.languageCode]['placesFetchError'];
  }

  String get notificationError {
    return _localizedValues[locale.languageCode]['notificationError'];
  }

  String get alreadyNotified {
    return _localizedValues[locale.languageCode]['alreadyNotified'];
  }

  String get successfullyNotified {
    return _localizedValues[locale.languageCode]['successfullyNotified'];
  }

  String get arrivalDepartureError {
    return _localizedValues[locale.languageCode]['arrivalDepartureError'];
  }

  String get arrivalTime {
    return _localizedValues[locale.languageCode]['arrivalTime'];
  }

  String get departureTime {
    return _localizedValues[locale.languageCode]['departureTime'];
  }

  String get registerPlace {
    return _localizedValues[locale.languageCode]['registerPlace'];
  }

  String get registerPlaceHelper {
    return _localizedValues[locale.languageCode]['registerPlaceHelper'];
  }

  String get findNearbyPlaces {
    return _localizedValues[locale.languageCode]['findNearbyPlaces'];
  }

  String get registerPlaceHeader {
    return _localizedValues[locale.languageCode]['registerPlaceHeader'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'es', 'pt'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

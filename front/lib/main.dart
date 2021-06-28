import 'package:flutter/material.dart';
import 'package:front/localization/localizations.dart';
import 'package:front/pages/home/home.page.dart';
import 'package:front/pages/map.page.dart';
import 'package:front/pages/register-page/register-place.page.dart';
import 'package:front/pages/signup.page.dart';
import 'package:front/providers/user.provider.dart';
import 'package:provider/provider.dart';
import './pages/login.page.dart';
import './pages/splash.page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: CTracker(),
  ));
}

class CTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CTracker',
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('pt', 'BR'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/signup': (BuildContext context) => SignUpPage(),
        '/home': (BuildContext context) => HomePage(),
        '/register-place': (BuildContext context) => RegisterPlacePage(),
        '/map': (BuildContext context) => MapPage()
      },
    );
  }
}

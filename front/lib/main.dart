import 'package:flutter/material.dart';
import 'package:front/pages/home/home.page.dart';
import './pages/login.page.dart';
import './pages/splash.page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(CTracker());
}

class CTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage(),
        '/home': (BuildContext context) => HomePage()
      },
    );
  }
}

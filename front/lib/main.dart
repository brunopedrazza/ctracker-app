import 'package:flutter/material.dart';
import './pages/login.page.dart';
import './pages/splash.page.dart';

void main() {
  runApp(CTracker());
}

class CTracker extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginPage()
      },
    );
  }
}

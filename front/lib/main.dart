import 'package:flutter/material.dart';
import 'package:front/pages/home/home.page.dart';
import 'package:front/pages/signup.page.dart';
import 'package:front/providers/user.provider.dart';
import 'package:provider/provider.dart';
import './pages/login.page.dart';
import './pages/splash.page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(ChangeNotifierProvider(
    create: (context) => UserProvider(),
    child: CTracker(),
  ));
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
        '/signup': (BuildContext context) => SignUpPage(),
        '/home': (BuildContext context) => HomePage()
      },
    );
  }
}

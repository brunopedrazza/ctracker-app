import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../global.style.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({@required this.userId, @required this.id, @required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class _HomePageState extends State<HomePage> {
  Future<Album> futureAlbum;
  bool requestError = false;

  Future<Album> fetchAlbum() async {
    final response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'albums/1'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future fetchdata() async {
    final response = await http.get(
        Uri.https(
            'covid-19-data.p.rapidapi.com', '/country', {'name': 'italy'}),
        headers: {
          'x-rapidapi-key': '5b8957a382msh2d23f669b923e9ep150b64jsn1408a53a8c56'
        });
    print(response.body);
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      // futureAlbum = fetchAlbum();
      final response = fetchdata();
    } catch (e) {
      setState(() {
        requestError = true;
      });
    }

    print(futureAlbum);
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
      body: Container(
        decoration: BoxDecoration(gradient: GlobalStyles.standardGradient),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Welcome, Gui!',
                  style: GlobalStyles.titleTextGradient,
                ),
              ),
              Text('Here are the latest COVID-19 news.'),
              requestError ? Text('erro HTTP') : Text('dados buscados')
            ],
          ),
        ),
      ),
    );
  }
}

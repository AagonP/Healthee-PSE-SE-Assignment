import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

class Album {
  final List<int> id;
  final String title;
  final String name;

  Album({this.id, this.title, this.name});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['posts'] as List,
      title: json['posts']['title'],
      name: json['profile']['name'],
    );
  }
}

Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://my-json-server.typicode.com/AagonP/Healthee-PSE-SE-Assignment/db');

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Album.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class ScanScreen extends StatefulWidget {
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  Future<Album> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<Album>(
        future: futureAlbum,
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data.title);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

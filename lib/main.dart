//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi final",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  List data; //
  Future<List<Rest>> getData() async {
    var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/comments"),
        headers: {"Accept": "Application/json"});
    var data = json.decode(response.body);
    print(data);
    List<Rest> rests = [];
    for (var r in data) {
      Rest rest = Rest(r["postId"], r["email"], r["name"]);
      rests.add(rest);
    }
    return rests;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("José Gabriel Zeballos Quisbert"),
        ),
        body: Container(
            child: FutureBuilder(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot.data);
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Loading"),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int postId) {
                  return ListTile(
                    title: Text(snapshot.data[postId].email),
                    subtitle: Text(snapshot.data[postId].name),
                  );
                },
              );
            }
          },
        )));
  }
}

class Rest {
  final int postId;
  final String email;
  final String name;

  Rest(this.postId, this.email, this.name);
}

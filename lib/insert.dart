import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';

class addData extends StatefulWidget {
  @override
  _addDataState createState() => _addDataState();
}

class _addDataState extends State<addData> {
  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerPosition = new TextEditingController();
  TextEditingController controllerSalary = new TextEditingController();
  String api = MyApp.api;

  void addData(){
  var url="${api}insert.php";

  http.post(url, body: {
    "name": controllerName.text,
    "position": controllerPosition.text,
    "salary": controllerSalary.text
  });
}

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("add employee"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TextField(
                  controller: controllerName,
                  decoration: new InputDecoration(
                      hintText: "Someone", labelText: "name"),
                ),
                new TextField(
                  controller: controllerPosition,
                  decoration: new InputDecoration(
                      hintText: "The position", labelText: "position"),
                ),
                new TextField(
                  controller: controllerSalary,
                  decoration: new InputDecoration(
                      hintText: "ex : 5000000", labelText: "salary"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Add"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    addData();
                    Navigator.popAndPushNamed(context,'/dataemployee');
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
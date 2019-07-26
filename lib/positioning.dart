import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

class Position extends StatefulWidget {
  @override
  _PositionState createState() => _PositionState();
}

class _PositionState extends State<Position> {
  String api = MyApp.api;
  Future<List> getData() async {
    final response =
        await http.get("${api}getdata.php");
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(     
      appBar: new AppBar(
          title: new Text("Positioning"),
          backgroundColor: Color(0xff33313b),
        ),
      body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ItemList(list: snapshot.data,)
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        )
    );
  }
}
class ItemList extends StatelessWidget{
  final List list;
  ItemList({this.list});
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i){
        return new Container(
          padding: const EdgeInsets.all(1.0),          
              child: new Card(
                child: new ListTile(
              title: new Text(list[i]['jabatan']),
              leading: new Icon(Icons.person_pin_circle),
              subtitle: new Text("${list[i]['nama']}"),              
            ),
          ),          
        );
      },
    );
  
  }

}
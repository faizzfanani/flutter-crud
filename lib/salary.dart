import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

class Salary extends StatefulWidget {
  @override
  _SalaryState createState() => _SalaryState();
}

class _SalaryState extends State<Salary> {
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
          title: new Text("Salary"),
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
              title: new Text(list[i]['nama']),
              leading: new Icon(Icons.person),
              subtitle: new Text("${list[i]['gaji']}"),              
            ),
          ),          
        );
      },
    );
  
  }

}
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/help.dart';
import 'package:flutter_crud/login.dart';
import 'package:flutter_crud/message.dart';
import 'package:flutter_crud/positioning.dart';
import 'package:flutter_crud/profile.dart';
import 'package:flutter_crud/salary.dart';
import 'package:flutter_crud/setting.dart';
import 'package:flutter_crud/statistic.dart';
import 'package:flutter_crud/todolist.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'Detail.dart';
import 'insert.dart';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Login(),
      routes: <String,WidgetBuilder>{
        '/dataemployee': (BuildContext context)=> new MyHomePage(),
        '/profile': (BuildContext context)=> new Profile(),
        '/todolist': (BuildContext context)=> new ToDoList(),
        '/salary': (BuildContext context)=> new Salary(),
        '/positioning': (BuildContext context)=> new Position(),
        '/statistic': (BuildContext context)=> new Statistic(),
        '/about': (BuildContext context)=> new Help(),
        '/message': (BuildContext context)=> new Message(),
        '/setting': (BuildContext context)=> new Setting(),
      },
    );
  }
}
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List> getData() async {
    final response =
        await http.get("http://192.168.1.19/flutter_crud/getdata.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Employees's data"),
          backgroundColor: Color(0xff33313b),
        ),
        floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: ()=>Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context)=> new addData(),
          )
        ),
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
        ));
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
          child: new GestureDetector(
            onTap: ()=>Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (BuildContext context)=> new Detail(list: list, index: i)
              )
            ),
          
                  child: new Card(
                    child: new ListTile(
              title: new Text(list[i]['nama']),
              leading: new Icon(Icons.person),
              subtitle: new Text("${list[i]['jabatan']}"),              
            ),
          ),
          )
        );
      },
    );
  
  }

}

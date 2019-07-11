import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

class updateData extends StatefulWidget {

  final List list;
  final int index;

  updateData({this.list, this.index});
  
  @override
  _updateDataState createState() => _updateDataState();
}

class _updateDataState extends State<updateData> {

  TextEditingController controllerName = new TextEditingController();
  TextEditingController controllerPosition = new TextEditingController();
  TextEditingController controllerSalary = new TextEditingController();

  void updateData() {
      var url="http://192.168.1.3/flutter_crud/update.php";
      http.post(url,body: {
        "id": widget.list[widget.index]['id'],
        "name": controllerName.text,
        "position": controllerPosition.text,
        "salary": controllerSalary.text
      });
    }

   @override
    void initState() {
      controllerName= new TextEditingController(text: widget.list[widget.index]['nama'] );
      controllerPosition= new TextEditingController(text: widget.list[widget.index]['jabatan'] );
      controllerSalary= new TextEditingController(text: widget.list[widget.index]['gaji'] );
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("EDIT DATA"),
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
                      hintText: "Someone", labelText: "Name"),
                ),
                new TextField(
                  controller: controllerPosition,
                  decoration: new InputDecoration(
                      hintText: "Position", labelText: "Position"),
                ),
                new TextField(
                  controller: controllerSalary,
                  decoration: new InputDecoration(
                      hintText: "ex : 5000000", labelText: "Salary"),
                ),
                new Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                new RaisedButton(
                  child: new Text("Update"),
                  color: Colors.blueAccent,
                  onPressed: () {
                    updateData();
                    Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=> new MyHomePage(),
                      )
                    );
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
import 'package:flutter/material.dart';
import 'package:flutter_crud/edit.dart';
import 'package:flutter_crud/main.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  List list;
  int index;
  Detail({this.index, this.list});
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  String api = MyApp.api;
  void deleteData(){
  var url="${api}delete.php";
  http.post(url, body: {
    'id': widget.list[widget.index]['id']
  }); 
  Navigator.popAndPushNamed(context, '/dataemployee'); 
}

void confirm (){
  AlertDialog alertDialog = new AlertDialog(
    content: new Text("Are You sure want to delete '${widget.list[widget.index]['nama']}'"),
    actions: <Widget>[
      new RaisedButton(
        child: new Text("DELETE",style: new TextStyle(color: Colors.black),),
        color: Colors.red,
        onPressed: (){
          deleteData();                             
        },
      ),
      new RaisedButton(
        child: new Text("CANCEL",style: new TextStyle(color: Colors.black)),
        color: Colors.green,
        onPressed: ()=> Navigator.pop(context),
      ),
    ],
  );

  showDialog(context: context, child: alertDialog);
}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.list[widget.index]['nama']}"),
        backgroundColor: Color(0xff33313b),),
      body: new Container(
        height: 270.0, 
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[

                new Padding(padding: const EdgeInsets.only(top: 30.0),),
                new Text(widget.list[widget.index]['nama'], style: new TextStyle(fontSize: 20.0),),
                new Text("Position : ${widget.list[widget.index]['jabatan']}", style: new TextStyle(fontSize: 18.0),),
                new Text("Salary per month : Rp. ${widget.list[widget.index]['gaji']}", style: new TextStyle(fontSize: 18.0),),
                new Padding(padding: const EdgeInsets.only(top: 30.0),),

                new Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("EDIT"),
                      color: Colors.amber,
                      onPressed: ()=>Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (BuildContext context)=> new updateData(list: widget.list, index: widget.index),
                        )
                      ),                
                    ),
                    new RaisedButton(
                      child: new Text("DELETE"),
                      color: Colors.red,
                      onPressed: ()=>confirm(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
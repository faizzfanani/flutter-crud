import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
class Profile extends StatefulWidget {
  List list;
  int index;
  Profile({this.index, this.list});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Profile"),
        backgroundColor: Color(0xff33313b),),
      body: new Container(
        height: 270.0, 
        padding: const EdgeInsets.all(20.0),
        child: new Card(
          child: new Center(
            child: new Column(
              children: <Widget>[

                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
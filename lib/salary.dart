import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Salary extends StatefulWidget {
  @override
  _SalaryState createState() => _SalaryState();
}

class _SalaryState extends State<Salary> {
  Future<List> getData() async {
    final response =
        await http.get("http://192.168.1.19/flutter_crud/getdata.php");
    return json.decode(response.body);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(     
      body: Container(
        child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2.5,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xff33313b),
                    Color(0xff4592af)
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(90)
                )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Icon(Icons.money_off,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),                  
                ],
              ),
            ),
            new FutureBuilder<List>(
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
          ],
        ),)
      ),
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
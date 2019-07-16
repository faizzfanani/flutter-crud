import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud/Register.dart';
import 'package:flutter_crud/dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import 'main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  var url="http://192.168.1.19/flutter_crud/insertadmin.php";
  
  void login(){

  http.post(url, body: {
    "email": email.text,
    "password": password.text
  });
}
  String msg = '';
  Future<dynamic> getJson(Uri uri) async {
    http.Response response = await http.post(uri);
    return json.decode(response.body);
  }


  Future<List> _login() async {
    final response = await http.post(url, body: {
      "username": email.text,
      "password": password.text,
    });

    print(response);
    var datauser = json.decode(response.body);

    if (datauser.length == 0) {
      setState(() {
        msg = "Login Fail";
      });
    } else {
      if (datauser[0]['level'] == 'admin') {
        Navigator.pushReplacementNamed(context, '/AdminPage');
      } else if (datauser[0]['level'] == 'member') {
        Navigator.pushReplacementNamed(context, '/MemberPage');
      }

      setState(() {
        email = datauser[0]['username'];
      });
    }

    return datauser;
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
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
                    child: Icon(Icons.person_outline,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),                  
                ],
              ),
            ),

            Container(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.only(top: 62),
              child: Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    padding: EdgeInsets.only(
                      top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(50)
                      ),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 5
                        )
                      ]
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.email,
                            color: Colors.grey,
                        ),
                          hintText: 'Email',
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/1.2,
                    height: 45,
                    margin: EdgeInsets.only(top: 16),
                    padding: EdgeInsets.only(
                        top: 4,left: 16, right: 16, bottom: 4
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(50)
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5
                          )
                        ]
                    ),
                    child: TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(Icons.vpn_key,
                          color: Colors.grey,
                        ),
                        hintText: 'Password',
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 16, right: 32
                      ),
                      child: Text('Forgot Password ?',
                        style: TextStyle(
                          color: Colors.grey
                        ),
                      ),
                    ),
                  ),
                  Spacer(),

                  new GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=> new Dashboard(),
                      )
                    );
                    },
                    child: new Container(                  
                    height: 45,
                    width: MediaQuery.of(context).size.width/1.2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xff33313b),
                          Color(0xff4592af)
                        ],
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    child: Center(
                      child: Text('Login'.toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  ),
                  
                  Spacer(),
                  new Text('or',
                    style: TextStyle(
                      color: Colors.grey
                    ),),
                  Spacer(),
                  new GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                      new MaterialPageRoute(
                        builder: (BuildContext context)=> new Register(),
                      )
                    );
                    },
                    child: new Container(                  
                    height: 45,
                    width: MediaQuery.of(context).size.width/1.2,
                    decoration: BoxDecoration(
                      border: new Border.all(color: Color(0xff33313b)
                        ),                      
                      borderRadius: BorderRadius.all(
                        Radius.circular(10)
                      )
                    ),
                    child: Center(
                      child: Text('Register'.toUpperCase(),
                        style: TextStyle(
                          color: Color(0xff33313b),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  )
                ],
              ),
            )
          ],
        ),)
      ),
    );
  }
}
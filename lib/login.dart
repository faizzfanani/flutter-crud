import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud/Register.dart';
import 'package:flutter_crud/main.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> { 
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  var data;
  var _isSecured = true;
  String api = MyApp.api;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Future<String> getLogin(String email) async {
      var response = await http.get(
          Uri.encodeFull(
              "${api}login.php?PSEUDO=${email}"),
          headers: {"Accept": "application/json"});

      print(response.body);
      setState(() {
        var convertDataToJson = json.decode(response.body);
        data = convertDataToJson['result'];
      });
    }
    /*********************Alert Dialog Password******************************/
    void onSignedInErrorPassword() {
      var alert = new AlertDialog(
        title: new Text("Password incorrect"),
        content: new Text(
            "Use the correct password !"),
      );
      showDialog(context: context, child: alert);
    }

    /*********************Alert Dialog Pseudo******************************/
    void onSignedInErrorPseudo() {
      var alert = new AlertDialog(
        title: new Text("Email incorrect"),
        content:
            new Text("Email is wrong or not registered"),
      );
      showDialog(context: context, child: alert);
    }

    /******************* Check Data ****************************/    
    VerifData(String email, String password, var datadb) {
      getLogin(email);
      if (data[0]['email'] == email && data[0]['password'] == password) {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else if(data[0]['email'] != email){
        onSignedInErrorPseudo();
      }
      else {
        onSignedInErrorPassword();
      }
    }
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
                      keyboardType: TextInputType.emailAddress,
                      controller: email,
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
                      keyboardType: TextInputType.text,
                      controller: password,
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
                      VerifData(email.text, password.text, data);                      
                    },
                    behavior: HitTestBehavior.opaque,
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
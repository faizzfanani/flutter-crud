import 'package:flutter/material.dart';
import 'package:flutter_crud/login.dart';
 
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}
 
class _SplashScreenState extends State<SplashScreen> {
 
  /// NEW CODE.
  @override
  void initState() {
    super.initState();
 
    /// Initialize data, then navigator to Home screen.
    initData().then((value) {
      navigateToHomeScreen();
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
            colors: [
              Color(0xff33313b),
              Color(0xff4592af)
              ],
                ),
              ),
      child: Center(
        child: FlutterLogo(size: 200),
      ),
    );
  }
 
  /// NEW CODE.
  /// We can do long run task here.
  /// In this example, we just simply delay 3 seconds, nothing complicated.
  Future initData() async {
    await Future.delayed(Duration(seconds: 3));
  }
 
  /// NEW CODE.
  /// Navigate to Home screen.
  void navigateToHomeScreen() {
    /// Push home screen and replace (close/exit) splash screen.
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
  }
}
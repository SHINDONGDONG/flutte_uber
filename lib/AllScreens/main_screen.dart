import 'package:flutter/material.dart';
import 'package:flutter_uber/AllScreens/login_screen.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen="mainScreen";  //register 변수
  @override
  _MainScreenState createState() => _MainScreenState();
}



class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MainTitle'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.idScreen, (route) => false);
          },
          child: Text('Login'),
        ),
      )
    );
  }
}

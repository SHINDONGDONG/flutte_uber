import 'package:flutter/material.dart';

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
    );
  }
}

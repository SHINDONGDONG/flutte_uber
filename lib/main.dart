import 'package:flutter/material.dart';
import 'package:flutter_uber/AllScreens/login_screen.dart';

import 'AllScreens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Taxi Rider App',
      theme: ThemeData(
        fontFamily: "Brand-Regular", //Yamlファイルで追加したFontを呼び出して使う。
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,       //falseにするとdebugモードバナーが消える
    );
  }
}



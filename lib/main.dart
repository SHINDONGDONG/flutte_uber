import 'package:flutter/material.dart';
import 'package:flutter_uber/AllScreens/login_screen.dart';
import 'package:flutter_uber/AllScreens/registration_screen.dart';

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
      initialRoute: LoginScreen.idScreen,     //初期画面の設定
      routes: {
        RegistrationScreen.idScreen:(context) => RegistrationScreen(),          //RegistrationScreenのIdScreen変数が指定されたらRegistrationScreenへ移動
        LoginScreen.idScreen:(context) => LoginScreen(),
        MainScreen.idScreen:(context) => MainScreen(),
      },
      debugShowCheckedModeBanner: false,                                        //falseにするとdebugモードバナーが消える
    );
  }
}



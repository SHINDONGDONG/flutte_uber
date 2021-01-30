import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uber/AllScreens/login_screen.dart';
import 'package:flutter_uber/AllScreens/registration_screen.dart';

import 'AllScreens/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
DatabaseReference userRef = FirebaseDatabase.instance.reference().child("users"); //データベースを参照しUserRefに代入する

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
      initialRoute: MainScreen.idScreen,     //初期画面の設定
      routes: {
        RegistrationScreen.idScreen:(context) => RegistrationScreen(),          //RegistrationScreenのIdScreen変数が指定されたらRegistrationScreenへ移動
        LoginScreen.idScreen:(context) => LoginScreen(),
        MainScreen.idScreen:(context) => MainScreen(),
      },
      debugShowCheckedModeBanner: false,                                        //falseにするとdebugモードバナーが消える
    );
  }
}



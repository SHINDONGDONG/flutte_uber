import 'package:flutter/material.dart';
import 'package:flutter_uber/AllScreens/login_screen.dart';

class RegistrationScreen extends StatelessWidget {

  static const String idScreen="register";  //register 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(                                              //キーボードが上がってくる時Scroll可能になる
        child: Column(
          children: [
            SizedBox(height: 65.0),
            Image.asset(
              "images/logo.png",                                                //ロゴの画像をインポートする
              height: 250.0,
              width: double.infinity,                                           //幅のサイズを最大にする
              alignment: Alignment.center,                                      //ロゴを中央に配置する
            ),
            SizedBox(height: 1.0),
            Text(
              "Register as a Rider",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24.0,
                  fontFamily: "Brand-Bold"),
            ),
            Padding(                                                            //Paddingで全体を包む
              padding: EdgeInsets.all(20.0),
              child: Column(                                                    //Columnで上下にWidgetを配置する
                children: [
                  SizedBox(height: 1.0),
                  TextField(                                                    //TextFieldウィジェットはデータを打ち込めるField
                    keyboardType: TextInputType.text,                           //＠の含まれてるキーボードが出てくる
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 1.0),
                  TextField(                                                    //TextFieldウィジェットはデータを打ち込めるField
                    keyboardType: TextInputType.emailAddress,                   //＠の含まれてるキーボードが出てくる
                    decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 1.0),
                  TextField(
                    keyboardType: TextInputType.phone,                           //TextでInputしobscureで隠す
                    decoration: InputDecoration(
                      labelText: "Phone",
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 1.0),
                  TextField(
                    obscureText: true,                                          //テキストを隠す
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                        fontSize: 14.0,
                      ),
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0),
                    ),
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    onPressed: () {
                      print("Login button");
                    },
                    textColor: Colors.white,
                    color: Colors.yellow,
                    child: Container(
                      height: 50.0,                                             //ボタンの高さを50に設定
                      child: Center(                                            //テキストを中央に配置するためCenterWidget
                        child: Text(
                          "Create Account",
                          style:
                          TextStyle(fontSize: 18.0, fontFamily: "Brand-Bold"),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(                              //ボタンをRoundするため
                      borderRadius: BorderRadius.circular(24.0),                //Circular効果を与える
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(                                                         //TextButtonです。
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.idScreen, (route) => false);
              },
              child: Text("Already have an Account? Login Here",),
            )
          ],
        ),
      ),
    );
  }
}

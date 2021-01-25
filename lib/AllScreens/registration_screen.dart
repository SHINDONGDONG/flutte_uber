import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uber/AllScreens/login_screen.dart';
import 'package:flutter_uber/AllWidgets/progressDialog.dart';
import 'package:flutter_uber/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'main_screen.dart';

class RegistrationScreen extends StatelessWidget {
  static const String idScreen = "register"; //register 변수
  TextEditingController _nameTextEditingController =
      TextEditingController(); //入力を受ける変数の宣言TextEditingControllerで
  TextEditingController _emailTextEditingController = TextEditingController();
  TextEditingController _phoneTextEditingController = TextEditingController();
  TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //キーボードが上がってくる時Scroll可能になる
        child: Column(
          children: [
            SizedBox(height: 65.0),
            Image.asset(
              "images/logo.png", //ロゴの画像をインポートする
              height: 250.0,
              width: double.infinity, //幅のサイズを最大にする
              alignment: Alignment.center, //ロゴを中央に配置する
            ),
            SizedBox(height: 1.0),
            Text(
              "Register as a Rider",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.0, fontFamily: "Brand-Bold"),
            ),
            Padding(
              //Paddingで全体を包む
              padding: EdgeInsets.all(20.0),
              child: Column(
                //Columnで上下にWidgetを配置する
                children: [
                  SizedBox(height: 1.0),
                  TextField(
                    //TextFieldウィジェットはデータを打ち込めるField
                    keyboardType: TextInputType.text, //＠の含まれてるキーボードが出てくる
                    controller: _nameTextEditingController, //それぞれのコントローラーに代入する
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
                  TextField(
                    //TextFieldウィジェットはデータを打ち込めるField
                    keyboardType: TextInputType.emailAddress,
                    //＠の含まれてるキーボードが出てくる
                    controller: _emailTextEditingController,
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
                    keyboardType: TextInputType.phone, //TextでInputしobscureで隠す
                    controller: _phoneTextEditingController,
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
                    obscureText: true,
                    //テキストを隠す
                    keyboardType: TextInputType.text,
                    controller: _passwordTextEditingController,
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
                      if (_nameTextEditingController.text.length < 4) {
                        //4文字以上の場合
                        displayToastMessage(
                            "Name 3文字以上入力してください。", context); //メソッドを作成します。
                      } else if (!_emailTextEditingController.text
                          .contains("@")) {
                        //Emailに＠が含まれているかを確認
                        displayToastMessage("Emailを入力してください。", context);
                      } else if (_phoneTextEditingController.text.isEmpty) {
                        //Phoneナンバーが入力されてるかを確認
                        displayToastMessage("電話番号を入力してください。", context);
                      } else if (_passwordTextEditingController.text.length <
                              6 //パスワードが6文字以上かを確認
                          ||
                          _passwordTextEditingController.text.isEmpty) {
                        displayToastMessage("パスワードは6文字以上入力してください。", context);
                      } else {
                        registerNewUser(context);
                      }
                    },
                    textColor: Colors.white,
                    color: Colors.yellow,
                    child: Container(
                      height: 50.0, //ボタンの高さを50に設定
                      child: Center(
                        //テキストを中央に配置するためCenterWidget
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                              fontSize: 18.0, fontFamily: "Brand-Bold"),
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      //ボタンをRoundするため
                      borderRadius:
                          BorderRadius.circular(24.0), //Circular効果を与える
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              //TextButtonです。
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.idScreen, (route) => false);
              },
              child: Text(
                "Already have an Account? Login Here",
              ),
            )
          ],
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance; //firebaseのインスタンスを宣言
  registerNewUser(BuildContext context) async {
    //firebaseを利用し認証する
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return ProgressDialog(message: "作成中。。。。",);
        }
    );
    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: _emailTextEditingController.text,
                password: _passwordTextEditingController.text)
            .catchError((errMsg) {
      displayToastMessage("Error : ${errMsg.toString()}", context);
    }))
        .user;

    if (firebaseUser != null) {
      //user created
      Map userDataMap = {
        "name": _nameTextEditingController.text.trim(),
        "email": _emailTextEditingController.text.trim(),
        "phone": _phoneTextEditingController.text.trim(),
      };
      userRef.child(firebaseUser.uid).set(userDataMap); //データベースにユーザーの情報を入力する
      displayToastMessage("アカウント作成を成功しました！", context);
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.idScreen, (route) => false);
    } else {
      displayToastMessage("アカウント作成に失敗しました。", context);
    }
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT
    );
  }
}

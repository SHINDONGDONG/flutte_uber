import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_uber/AllScreens/main_screen.dart';
import 'package:flutter_uber/AllScreens/registration_screen.dart';
import 'package:flutter_uber/AllWidgets/progressDialog.dart';
import 'package:flutter_uber/main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatelessWidget {
  static const String idScreen = "login"; //login 변수
  TextEditingController _emailTextEditingController = TextEditingController();
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
              "Login as a Rider",
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
                    controller: _emailTextEditingController,
                    //TextFieldウィジェットはデータを打ち込めるField
                    keyboardType: TextInputType.emailAddress,
                    //＠の含まれてるキーボードが出てくる
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
                    controller: _passwordTextEditingController,
                    obscureText: true,
                    //テキストを隠す
                    keyboardType: TextInputType.text,
                    //TextでInputしobscureで隠す
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
                      if (!_emailTextEditingController.text.contains("@")) {
                        regi.displayToastMessage("Emailでログインしてください。", context);
                      } else if (_passwordTextEditingController.text.isEmpty) {
                        regi.displayToastMessage("パスワードは必須項目です。", context);
                      } else {
                        loginAndAuthenticateUser(context);
                      }
                    },
                    textColor: Colors.white,
                    color: Colors.yellow,
                    child: Container(
                      height: 50.0, //ボタンの高さを50に設定
                      child: Center(
                        //テキストを中央に配置するためCenterWidget
                        child: Text(
                          "Login Button",
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
                    RegistrationScreen.idScreen, (route) => false);
              },
              child: Text("Do not have an Account? Register Here"),
            )
          ],
        ),
      ),
    );
  }

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  RegistrationScreen regi = RegistrationScreen();

  void loginAndAuthenticateUser(BuildContext context) async {//ログインメソッドを作成
      //LoginScreen.Dartです。
    showDialog(                                                                //Login時認証を行うメソッドの頭に書き込み
      context: context,                                                         //ShowDialogはDialogを見せてくれる
      barrierDismissible: false,
      builder: (BuildContext context){
        return ProgressDialog(message: "認証中です。",);                        //Messageにぐるぐると出力したいMessageを書き込み
      }
    );
    final User firebase = (await _firebaseAuth //Userが入力さるれまで待機（await)
            .signInWithEmailAndPassword(
                //作成の時はCreate、Signの時はsignInWithEmailAndPasswordでEmail、Passwordを認証する
                email: _emailTextEditingController.text,
                password: _passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      regi.displayToastMessage("Error ${errMsg.toString()}", context);
    }))
        .user;

    if (firebase != null) {
      //入力されたUserがあれば
      userRef.child(firebase.uid).once().then((DataSnapshot snap) {
        //UserRef(firebaseDatabase)を一回DataSnapshotで照会
        if (snap.value != null) {
          //SanpValueが存在すれば次のPageへ移動
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.idScreen, (route) => false); //
          regi.displayToastMessage("ログインに成功しました", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          regi.displayToastMessage("アカウントが存在しません。", context);
        }
      });
    } else {
      Navigator.pop(context);
      regi.displayToastMessage("ログインすることができません。", context);
    }
  }
}

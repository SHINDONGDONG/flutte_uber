import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_uber/AllScreens/login_screen.dart';
import 'package:flutter_uber/AllWidgets/divider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MainScreen extends StatefulWidget {
  static const String idScreen = "mainScreen"; //register 변수
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer(); //
  GoogleMapController newGoogleMapController; //タクシーを呼んだ時ライダーの位置が見えるようにコントローラー追加

  GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey<ScaffoldState>();

  Position currentPosition;//現在位置を表すGeoLocator依存関係
  var geoLocator = Geolocator(); //地形Locator

  double bottomPaddingOfMap=0;

  void locatePosition () async {    //geoLocatorを利用し使用者の位置を把握
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;

    LatLng latLngPosition = LatLng(position.latitude, position.longitude);  //経度緯度の位置をCurrentから持ってくる

    CameraPosition cameraPosition = new CameraPosition(target: latLngPosition,zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }


  static final CameraPosition _kGooglePlex = CameraPosition(
    //下記の情報をKgooglePlexの変数に代入
    // target: LatLng(37.42796133580664, -122.085749655962),
    target: LatLng(35.6859346, 139.8828528), //現在の緯度経度
    // 35.6859346 139.8828528
    zoom: 14.4746, //ズームレベル
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
        appBar: AppBar(
          title: Text('MainTitle'),
        ),
        drawer: Container(
          color: Colors.white,
          width: 255.0,
          child: Drawer(
            child: ListView(
              children: [                             //Drawerヘッダー
                Container(
                  height: 165.0,
                  child: DrawerHeader(
                    decoration: BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Image.asset("images/user_icon.png",height: 65,width: 65.0,),
                        SizedBox(width: 16.0,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("名前",style: TextStyle(fontSize: 16.0,fontFamily: "Brand-Bold"),),
                            SizedBox(width: 16.0,),
                            Text("プロフィール",style: TextStyle(fontSize: 16.0,fontFamily: "Brand-Bold"),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                DividerWdiget(),
                SizedBox(height: 12.0,),
                //Drawer body Controller
                ListTile(
                  leading: Icon(Icons.history),
                  title: Text("履歴",style: TextStyle(fontSize: 15.0),),
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text("プロフィール",style: TextStyle(fontSize: 15.0),),
                ),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text("インフォメーション",style: TextStyle(fontSize: 15.0),),
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            // RaisedButton(onPressed: (){}),

            GoogleMap(
              padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
              mapType: MapType.normal,
              myLocationButtonEnabled: true,
              //自分の位置をボタンで表示
              myLocationEnabled: true,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              initialCameraPosition: _kGooglePlex,
              //カメラ位置
              onMapCreated: (GoogleMapController controller) {
                _controllerGoogleMap.complete(controller);
                newGoogleMapController = controller; //ライダーの位置
                setState(() {
                  bottomPaddingOfMap = 300.0;           //検索メニューが上がってきたらBottom300に変更される
                });
                locatePosition();
              },
            ),
            Positioned(
              top: 35.0,                      //基準は左上から
              left: 22.0,                     //基準は左上から
              child: GestureDetector(
                onTap: (){
                  scaffoldkey.currentState.openDrawer();  //GestureDetectorを押したらKeyがScaffoldkeyの現在状態Drawerを開く
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(22.0),//Boxの角を丸く
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 6.0,
                        spreadRadius: 0.5,
                        offset: Offset(0.7,0.7),
                      ),
                    ]
                  ),
                  child: CircleAvatar(                    //Box中のTypeをCircleAvatarに設定し丸くする
                    backgroundColor: Colors.white,
                    child: Icon(Icons.menu,color: Colors.black,), //アイコンをハンバーガーにしBlack
                    radius: 20.0,
                  ),
                ),
              ),
            ),
            Positioned(                             //ポジションをとる
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: Container(                       //サーチバーの全体枠
                height: 300.0,                        //バーの高さは320
                decoration: BoxDecoration(            //BoxDecorationで囲む
                    color: Colors.white,              //全体の色はホワイト
                    borderRadius: BorderRadius.only(  //一番上のContainerのRadiusをCircular設定
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0),
                    ),
                    boxShadow: [                      //Boxに影を作る
                      BoxShadow(
                        color: Colors.black,          //景の色は黒出
                        blurRadius: 16.0,             //Blur（透明度）16
                        spreadRadius: 0.5,
                        offset: Offset(0.7, 0.7),
                      ),
                    ]
                ),
                child: Padding(                       //BoxDecorationの中にPadding設定
                  padding: const EdgeInsets.symmetric(//BoxDecorationの中幅24、高さ18をPadding適用
                      horizontal: 24.0,
                      vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, //Columnを左に寄せる
                    children: [
                      SizedBox(height: 6.0,),
                      Text('こんにちは, ',style: TextStyle(fontSize: 12,),),
                      Text('どこへ？ ',style: TextStyle(fontSize: 20,fontFamily: "Brand-Bold"),),
                      SizedBox(height: 20.0,),
                      Container(
                        decoration: BoxDecoration(          //BoxDecorationに囲んで
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black54,
                                blurRadius: 6.0,
                                spreadRadius: 0.5,
                                offset: Offset(0.7, 0.7),
                              ),
                            ]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0), //BoxDecoration中から12値のPadding
                          child: Row(
                            children: [
                              Icon(Icons.search,color: Colors.blueAccent,),//サーチアイコン
                              SizedBox(width: 10.0,),
                              Text('検索'),

                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24.0,),
                      Row(
                        children: [
                          Icon(Icons.home,color: Colors.grey,),
                            SizedBox(width: 12.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('自宅追加'),
                              SizedBox(height: 4.0,),
                              Text('自宅住所',style: TextStyle(color: Colors.black45,fontSize: 12.0),)
                            ],
                          )
                        ],
                      ),
                            SizedBox(height: 10.0,),
                      DividerWdiget(),
                            SizedBox(height: 16.0,),
                      Row(
                        children: [
                          Icon(Icons.work,color: Colors.grey,),
                            SizedBox(width: 12.0,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('職場追加'),
                              SizedBox(height: 4.0,),
                              Text('職場住所',style: TextStyle(color: Colors.black45,fontSize: 12.0),)
                            ],
                          )
                        ],
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

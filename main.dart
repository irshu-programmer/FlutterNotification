import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  var text = "Welcome to ";

  @override
  void initState() {
    // TODO: implement initState
    firebaseMessaging.configure(
      
      onLaunch: (Map<String, dynamic> msg) {
      print("onLaunch called");
    },

    onResume: (Map<String, dynamic> msg) {
      print("OnResume called");
    },
    onMessage: (Map<String, dynamic> msg) {
      print("onMessage called");
    },
    
    
    );

firebaseMessaging.requestNotificationPermissions(
  const IosNotificationSettings(
    sound: true,
    alert: true,
    badge: true
  )
);


firebaseMessaging.onIosSettingsRegistered.listen((IosNotificationSettings settings) {
  print('IOS Setting Registerd');

});

firebaseMessaging.getToken().then((token){
 update(token);
});
    super.initState();
  }

  update(String token){
    text = token;
    print("Token - $token");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}

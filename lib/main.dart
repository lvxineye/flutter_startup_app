import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:startupapp/routers/application.dart';
import 'package:startupapp/routers/routers.dart';
import 'package:startupapp/views/home.dart';
import 'package:startupapp/views/login_page/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.`
  MyApp() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  int themeColor = 0xFFC9183A;
  bool _isLoading = true;
  bool _hasLogin = false;

  showWelcomePage() {
    if (_isLoading) {
      return Container(
        color: Color(this.themeColor),
        child: Center(
            child: Text(
          'Welcome!!!',
          style: TextStyle(color: Colors.white),
        )),
      );
    } else {
      if(_hasLogin) {
        return AppPage();
      } else {
        return LoginPage();
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      print('delay 5 seconds');
      setState(() {
        _isLoading = false;
      });
    });


  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Funny',
      theme: ThemeData(
        primaryColor: Color(this.themeColor),
        backgroundColor: Color(0xFFEFEFEF),
        accentColor: Color(0xFF888888),
        textTheme: TextTheme(
          body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0),
        ),
        iconTheme: IconThemeData(color: Color(this.themeColor), size: 35.0),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: showWelcomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

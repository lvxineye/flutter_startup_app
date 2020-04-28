

// app的首页
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:startupapp/views/home.dart';
import 'package:startupapp/views/login_page/login_page.dart';

var loginPageHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new LoginPage();
  }
);

var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new AppPage();
  }
);
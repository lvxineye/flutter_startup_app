// app的首页
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:startupapp/views/home.dart';
import 'package:startupapp/views/issuse_message_page/issuse_message_page.dart';
import 'package:startupapp/views/login_page/login_page.dart';
import 'package:startupapp/views/web_view/web_view_page.dart';

var loginPageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new LoginPage();
});

var homeHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new AppPage();
});

var webViewPageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String title = params['title']?.first;
  String url = params['url']?.first;
  return new WebViewPage(url, title);
});

var issuesMessageHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return new IssuesMessagePage();
});

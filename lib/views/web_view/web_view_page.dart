import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:startupapp/api/Api.dart';
import 'package:startupapp/event/event_bus.dart';

class WebViewPage extends StatefulWidget {
  final String url;
  final String title;

  WebViewPage(this.url, this.title);

  @override
  State createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    flutterWebViewPlugin.onUrlChanged.listen((String url) {
      print('url change: $url');
      if (-1 < url.indexOf('loginSuccess')) {
        String urlQuery = url.substring(url.indexOf('?') + 1);
        String loginName;
        String token;

        List<String> queryList = urlQuery.split('&');
        for (int i = 0; i < queryList.length; i++) {
          String queryNote = queryList[i];
          int eqIndex = queryNote.indexOf('=');
          if ('loginName' == queryNote.substring(0, eqIndex)) {
            loginName = queryNote.substring(eqIndex + 1);
          }
          if ('accessToken' == queryNote.substring(0, eqIndex)) {
            token = queryNote.substring(eqIndex + 1);
          }
        }
        if (null != ApplicationEvent.event) {
          // TODO
//            ApplicationEvent.event.fire()
        }

        print('ready close');
        flutterWebViewPlugin.close();
      } else if (0 == url.indexOf('${Api.BASE_URL}loginFail')) {
        // 验证失败
        if (null != ApplicationEvent.event) {
          // TODO
//            ApplicationEvent.event.fire()
        }

        flutterWebViewPlugin.close();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebviewScaffold(
        url: widget.url,
        withZoom: false,
        withLocalStorage: true,
        withJavascript: true,
        hidden: true,
      ),
    );
  }
}

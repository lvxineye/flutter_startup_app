import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  @override
  State createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        child: Text('First Page...'),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

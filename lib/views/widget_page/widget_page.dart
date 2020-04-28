import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WidgetPageState();
  }
}

class _WidgetPageState extends State<WidgetPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      color: Theme.of(context).backgroundColor,
      child: Text('Widget page'),
    );
  }
}

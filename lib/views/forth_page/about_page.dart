
import 'package:flutter/cupertino.dart';

class AboutPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AboutPageState();
  }
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: Text('Forth page'),
    );;
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupapp/routers/application.dart';
import 'package:startupapp/views/main_page/main_page.dart';
import 'package:startupapp/views/user_page/user_page.dart';
import 'package:startupapp/views/widget_page/widget_page.dart';

import 'forth_page/about_page.dart';

class AppPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<AppPage> {
  int _currentIndex = 0;
  List<Widget> _list = List();
  List _tabData = [
    {'text': 'WIDGET', 'icon': Icon(Icons.extension)},
    {'text': 'ABOUT', 'icon': Icon(Icons.import_contacts)},
    {'text': 'MINE', 'icon': Icon(Icons.account_circle)}
  ];
  List<BottomNavigationBarItem> _myTabs = [];

  String appBarTitle;

  @override
  void initState() {
    super.initState();
    print('widget.userInfo');
    // TODO init some data
    if (Application.pageIsOpen) {
      // 是否展开业界动态
      _tabData.insert(0, {'text': 'NEWS', 'icon': Icon(Icons.language)});
      _list..add(MainPage());
    }
    appBarTitle = _tabData[0]['text'];
    for (int i = 0; i < _tabData.length; i++) {
      _myTabs.add(BottomNavigationBarItem(
        icon: _tabData[i]['icon'],
        title: Text(
          _tabData[i]['text'],
        ),
      ));
    }
    _list..add(WidgetPage())..add(AboutPage())..add(UserPage());
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _list,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _myTabs,
        currentIndex: _currentIndex,
        onTap: _itemTapped,
        //shifting :按钮点击移动效果
        //fixed：固定
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).primaryColor,
      ),
    );
  }

  void _itemTapped(int index) {
    setState(() {
      _currentIndex = index;
      appBarTitle = _tabData[index]['text'];
    });
  }
}

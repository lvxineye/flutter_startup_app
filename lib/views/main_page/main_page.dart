import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupapp/model/user_info.dart';
import 'package:startupapp/routers/application.dart';
import 'package:startupapp/routers/routers.dart';
import 'package:startupapp/views/first_page/first_page.dart';
import 'package:startupapp/views/main_page/main_app_bar.dart';
import 'package:startupapp/views/user_page/drawer_page.dart';

DefaultTabController _tabController;

TabBar _tabBar;

class _Page {
  final String labelId;
  final int labelIndex;

  _Page(this.labelId, this.labelIndex);
}

final List<_Page> _allPages = <_Page>[
  _Page('热门资讯', 1),
  _Page('FG-官网', 2),
  _Page('FG-web版', 3),
];

class MainPage extends StatelessWidget {
  final UserInformation userInfo;

  MainPage({Key key, this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Main page is building...');

    _tabController = DefaultTabController(
      length: _allPages.length,
      child: Scaffold(
        appBar: MyAppBar(
          leading: Container(
            child: ClipOval(
              child: Image.network(
                'https://hbimg.huabanimg.com/9bfa0fad3b1284d652d370fa0a8155e1222c62c0bf9d-YjG0Vt_fw658',
                scale: 15.0,
              ),
            ),
          ),
          centerTitle: true,
          title: TabLayout(),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
//                  pushPage(context, SearchPage(), pageName: 'SearchPage');
              },
            )
          ],
        ),
        drawer: Drawer(
          child: DrawerPage(
            userInfo: userInfo,
          ),
        ),
        body: TabBarViewLayout(),
      ),
    );

    return _tabController;
  }
}

void pushPage(BuildContext context, Widget page, {String pageName}) {
  if (null == context || null == page) {
    return;
  }
  Navigator.push(context, CupertinoPageRoute<void>(builder: (ctx) => page));
}

class TabLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _tabBar = TabBar(
      isScrollable: true,
      labelPadding: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
      indicatorSize: TabBarIndicatorSize.label,
      tabs: _allPages.map((_Page page) => Tab(text: page.labelId)).toList(),
      onTap: (index) {
        if (1 == index) {
          DefaultTabController.of(context).animateTo(0);
          Application.router.navigateTo(context,
              '${Routes.webViewPage}?title=${Uri.encodeComponent('Flutter Go 官方网站')}&url=${Uri.encodeComponent('https://flutter-go.pub')}',
              transition: TransitionType.nativeModal);
        } else if (2 == index) {
          DefaultTabController.of(context).animateTo(0);
          Application.router.navigateTo(context,
              '${Routes.webViewPage}?title=${Uri.encodeComponent('Flutter Go Web版(H5)')}&url=${Uri.encodeComponent('https://flutter-go.pub/flutter_app_go_web')}',
              transition: TransitionType.nativeModal);
        }
      },
    );
    return _tabBar;
  }
}

class TabBarViewLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('TabBarViewLayout build....');
    return TabBarView(
        children: _allPages.map((_Page page) {
      return buildTabView(context, page);
    }).toList());
  }

  Widget buildTabView(BuildContext context, _Page page) {
    int labelIndex = page.labelIndex;
    switch (labelIndex) {
      case 1:
        return FirstPage();
        break;
      default:
        return Container();
        break;
    }
  }
}

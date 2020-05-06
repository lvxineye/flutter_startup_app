import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:startupapp/model/user_info.dart';
import 'package:startupapp/routers/application.dart';
import 'package:startupapp/routers/routers.dart';

class DrawerPage extends StatefulWidget {
  final UserInformation userInfo;

  DrawerPage({Key key, this.userInfo}) : super(key: key);

  @override
  State createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  final textStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w300);

  bool _hasLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (null != this.widget.userInfo && 0 != this.widget.userInfo.id) {
      _hasLogin = true;
    }
  }

  void showLogoutDialog(BuildContext context) {
    if (_hasLogin) {
    } else {
      Application.router.navigateTo(context, '${Routes.loginPage}',
          transition: TransitionType.native, clearStack: true);
    }
  }

  void onHandelFeedback(BuildContext context) {
    if (_hasLogin) {
//      Application.router.navigateTo(
//        context,
//        '${Routes.issuesMesagePage}',
//        transition: TransitionType.nativeModal,
//      );

      Application.router.navigateTo(
        context,
        '${Routes.loginPage}',
        transition: TransitionType.nativeModal,
      );
    } else {
//      Application.router.navigateTo(
//        context,
//        '${Routes.loginPage}',
//        transition: TransitionType.nativeModal,
//      );

      Application.router.navigateTo(
        context,
        '${Routes.issuesMessagePage}',
        transition: TransitionType.nativeModal,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountName: Text(''),
          accountEmail: Container(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Text(
              _hasLogin ? widget.userInfo.username : '',
              style: TextStyle(fontSize: 28),
            ),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: NetworkImage(_hasLogin
                  ? widget.userInfo.avatarPic
                  : 'https://hbimg.huabanimg.com/9bfa0fad3b1284d652d370fa0a8155e1222c62c0bf9d-YjG0Vt_fw658'),
            ),
          ),
        ),
        // new Divider(),
        ListTile(
          leading: Icon(
            Icons.search,
            size: 27.0,
          ),
          title: Text(
            '全网搜',
            style: textStyle,
          ),
          onTap: null,
        ),
        ListTile(
          leading: Icon(
            Icons.favorite,
            size: 27.0,
          ),
          title: Text(
            '我的收藏',
            style: textStyle,
          ),
          onTap: null,
        ),
        new Divider(),
        ListTile(
          leading: Icon(
            Icons.email,
            size: 27.0,
          ),
          title: Text(
            '反馈/建议',
            style: textStyle,
          ),
          onTap: () {
            onHandelFeedback(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.share,
            size: 27.0,
          ),
          title: Text(
            '分享App',
            style: textStyle,
          ),
          onTap: () {
            Share.share('https://flutter-go.pub/website/');
          },
        ),
        new Divider(),
        ListTile(
          leading: Icon(
            _hasLogin ? Icons.exit_to_app : Icons.supervised_user_circle,
            size: 27.0,
          ),
          title: Text(
            _hasLogin ? '退出登录' : '点击登录',
            style: textStyle,
          ),
          onTap: () {
            showLogoutDialog(context);
          },
        ),
      ],
    );
  }
}



import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:startupapp/routers/application.dart';
import 'package:startupapp/routers/routers.dart';

class UserPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserPageState();
  }
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 35.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'Sign Out',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          decoration: TextDecoration.underline),
                    ),
                    onPressed: () {
                      Application.router.navigateTo(
                        context,
                        Routes.loginPage,
                        clearStack: true,
                        transition: TransitionType.nativeModal,
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ],
      ),

    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  GlobalKey<FormState> _signInformKey = new GlobalKey();

  FocusNode _emailFocusNode = new FocusNode();
  FocusNode _passwordFocusNode = new FocusNode();
  FocusScopeNode _focusScopeNode = new FocusScopeNode();

  bool isShowPassword = false;
  String username = '';
  String password = '';

  // 创建登录界面的TextForm
  Widget buildSignInTextForm() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      height: 190,
      child: Form(
        key: _signInformKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 20, bottom: 20),
                child: TextFormField(
//                  controller: _userNameEditingController,
                  focusNode: _emailFocusNode,
                  onEditingComplete: () {
                    if (null == _focusScopeNode) {
                      _focusScopeNode = FocusScope.of(context);
                    }
                    _focusScopeNode.requestFocus(_passwordFocusNode);
                  },

                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      hintText: 'Github username',
                      border: InputBorder.none),
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  //验证
                  validator: (value) {
                    if (value.isEmpty) {
                      return "登录名不可为空!";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      username = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 25, right: 25, top: 20),
                child: TextFormField(
//                  controller: _userNameEditingController,
                  focusNode: _passwordFocusNode,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      hintText: 'Github password',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.black,
                        ),
                        onPressed: showPassword,
                      )),
                  //输入密码，需要用*****显示
                  obscureText: !isShowPassword,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  //验证
                  validator: (value) {
                    if (null == value || value.isEmpty) {
                      return "密码不可为空!";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignInButton() {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 42, right: 42, top: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Theme.of(context).primaryColor),
        child: Text(
          "LOGIN",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: null,
    );
  }

  void showPassword() {
    setState(() {
      isShowPassword = !isShowPassword;
    });
  }

  Widget buildLoading() {
    if (isLoading) {
      return Opacity(
        opacity: .5,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            color: Colors.black,
          ),
//          child: Spink,
        ),
      );
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                color: Colors.white,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/paimaiLogo.png',
                  ),
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(height: 35.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'assets/images/gitHub.png',
                            fit: BoxFit.contain,
                            width: 60.0,
                            height: 60.0,
                          ),
                          Image.asset(
                            'assets/images/arrow.png',
                            fit: BoxFit.contain,
                            width: 40.0,
                            height: 30.0,
                          ),
                          Image.asset(
                            'assets/images/FlutterGo.png',
                            fit: BoxFit.contain,
                            width: 60.0,
                            height: 60.0,
                          )
                        ],
                      ),
                      buildSignInTextForm(),
                      buildSignInButton(),
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width * 0.75,
                        color: Colors.grey[400],
                        margin: const EdgeInsets.only(bottom: 10.0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            child: Text(
                              'Github OAuth',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: null,
                          ),
                          FlatButton(
                            child: Text(
                              'Guest',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  decoration: TextDecoration.underline),
                            ),
                            onPressed: () {

                            },
                          )
                        ],
                      )
                    ],
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    bottom: 0,
                    child: buildLoading(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

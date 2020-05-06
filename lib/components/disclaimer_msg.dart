import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

const disclaimerText1 =
    '\r\r\r\r\r\r本APP属于个人的非赢利性开源项目，以供开源社区使用，凡本APP转载的所有的文章 、图片、音频、视频文件等资料的版权归版权所有人所有，本APP采用的非本站原创文章及图片等内容无法一一和版权者联系，如果本网所选内容的文章作者及编辑认为其作品不宜上网供大家浏览，或不应无偿使用请及时用电子邮件或电话通知我们，以迅速采取适当措施，避免给双方造成不必要的经济损失。';
const disclaimerText2 =
    '\n\r\r\r\r\r\r对于已经授权本APP独家使用并提供给本站资料的版权所有人的文章、图片等资料，如需转载使用，需取得本站和版权所有人的同意。本APP所刊发、转载的文章，其版权均归原作者所有，如其他媒体、网站或个人从本网下载使用，请在转载有关文章时务必尊重该文章的著作权，保留本网注明的“稿件来源”，并自负版权等法律责任。';

class DisclaimerMsg extends StatefulWidget {
  final State pWidget;

  DisclaimerMsg({Key key, this.pWidget}) : super(key: key);

  @override
  State createState() => DisclaimerMsgState();
}

class DisclaimerMsgState extends State<DisclaimerMsg> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _unKnow;

  var _valBool = false;
  var _read = false;

  void refs(bool value) async {
    final SharedPreferences prefs = await _prefs;
    final bool unKnow = value;
    _valBool = value;
    _read = value;
    if (mounted) {
      setState(() {
        _unKnow = prefs.setBool('keydisclaimer::Boolean', unKnow).then((bool success) {
          return unKnow;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // 获取SharedPreferences 存储结果
    _unKnow = _prefs.then((SharedPreferences prefs) {
      return (prefs.getBool('disclaimer::Boolean') ?? false);
    });
    _unKnow.then((bool value) {
      _valBool = value;
      _read = value;
    });
  }

  void showAlterDialog(BuildContext context) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return DisclaimerMsgDialog(_valBool, _read, (b) {
            refs(b);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAlterDialog(context);
      },
      child: Stack(
        children: <Widget>[
          Container(
            width: 90.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
              color: Colors.black45,
            ),
            child: Text(
              '免责声明',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DisclaimerMsgDialog extends StatefulWidget {
  final bool valBool;
  final bool read;
  final ValueChanged<bool> onValueChanged;

  DisclaimerMsgDialog(this.valBool, this.read, this.onValueChanged);

  @override
  State createState() => _DisclaimerMsgDialogState();
}

class _DisclaimerMsgDialogState extends State<DisclaimerMsgDialog> {
  bool readBool;

  @override
  void initState() {
    super.initState();

    readBool = widget.valBool;
  }

  Row _create() {
    //已读
    if (widget.read) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FlatButton(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              '已阅读知晓',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            // 可点击
            color: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          SizedBox(
            width: 10.0,
          ),
        ],
      );
    }

    /// 选中状态更新, 病返回数据
    checkChanged() {
      if (mounted) {
        setState(() {
          readBool = !readBool;
        });
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            checkChanged();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Checkbox(
                activeColor: Theme.of(context).primaryColor,
                tristate: false,
                value: readBool,
                onChanged: (bool bol) {
                  checkChanged();
                },
              ),
              Text(
                '不再自动提示',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        FlatButton(
          child: Text(
            '知道了',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          //可点击
          color: readBool ? Theme.of(context).primaryColor : Theme.of(context).primaryColor.withAlpha(80),
          onPressed: () {
            widget.onValueChanged(readBool);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 10.0),
              height: 35,
              child: Text(
                '免责声明',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: AssetImage('assets/images/paimaiLogo.png'),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(disclaimerText1),
            Text(disclaimerText2),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(20.0),
      ),
      actions: <Widget>[
        new Container(
          width: 250,
          child: _create(),
        )
      ],
    );
  }
}

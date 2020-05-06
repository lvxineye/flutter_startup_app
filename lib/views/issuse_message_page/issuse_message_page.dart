import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:startupapp/utils/data_utils.dart';
import 'package:zefyr/zefyr.dart';
import 'package:notus/convert.dart';

class IssuesMessagePage extends StatefulWidget {
  @override
  State createState() => _IssuesMessagePageState();
}

class _IssuesMessagePageState extends State<IssuesMessagePage> {
  final _focusNode = new FocusNode();
  final TextEditingController _controller = new TextEditingController();
  final ZefyrController _zefyrController = new ZefyrController(NotusDocument());

  String _title = '';
  var _delta;

  @override
  void initState() {
    _controller.addListener(() {
      print('_controller.text: ${_controller.text}');
      setState(() {
        _title = _controller.text;
      });
    });

    _zefyrController.document.changes.listen((change) {
      setState(() {
        _delta = _zefyrController.document.toDelta();
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _zefyrController.dispose();
  }

  Widget _descriptionEditor() {
    final theme = new ZefyrThemeData(
      toolbarTheme: ToolbarTheme.fallback(context).copyWith(
        color: Colors.grey.shade800,
        toggleColor: Colors.grey.shade900,
        iconColor: Colors.white,
        disabledIconColor: Colors.grey.shade500,
      ),
    );
    return ZefyrTheme(
      data: theme,
      child: ZefyrField(
        height: 400.0,
        decoration: InputDecoration(labelText: 'Description'),
        controller: _zefyrController,
        focusNode: _focusNode,
        autofocus: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('反馈/意见'),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {
              _submit();
            },
            icon: Icon(
              Icons.near_me,
              color: Colors.white,
              size: 12,
            ),
            label: Text(
              '发送',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        elevation: 1.0,
      ),
      body: ZefyrScaffold(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView(
            children: <Widget>[
              Text('输入标题'),
              new TextFormField(
                maxLength: 50,
                controller: _controller,
                decoration: new InputDecoration(
                  hintText: 'Title',
                ),
              ),
              Text('内容：'),
              _descriptionEditor(),
            ],
          ),
        ),
      ),
    );
  }

  _submit() {
    if (_title.trim().isEmpty) {
      _show('标题不能为空！');
    } else {
      String mk = (_delta == null)
          ? 'No description provided.'
          : notusMarkdown.encode(_delta);
      // TODO: 网络请求
      DataUtils.feedback(context, {'title': _title, 'body': mk}).then((result) {
        print('result=${result}');
        _show('提交成功,${result}');
        Navigator.maybePop(context);
      });
    }
  }

  _show(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

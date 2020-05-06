import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupapp/components/disclaimer_msg.dart';
import 'package:startupapp/components/list_refresh.dart';
import 'package:startupapp/components/list_view_item.dart';
import 'package:startupapp/components/pagination.dart';
import 'package:startupapp/utils/net_utils.dart';
import 'package:startupapp/views/first_page/first_page_item.dart';

class FirstPage extends StatefulWidget {
  @override
  State createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with AutomaticKeepAliveClientMixin {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<bool> _unKnow;
  GlobalKey<DisclaimerMsgState> key;

  @override
  void initState() {
    super.initState();

    if (null == key) {
      key = GlobalKey<DisclaimerMsgState>();
      // 获取sharePre
      _unKnow = _prefs.then((SharedPreferences prefs) {
        return (prefs.getBool('keydisclaimer::Boolean') ?? false);
      });

      /// 判断是否需要弹出免责声明, 已经勾选过的不再显示，就不会自动弹出
      _unKnow.then((bool value) {
        Future.delayed(const Duration(seconds: 1), () {
          if (!value && key.currentState is DisclaimerMsgState && key.currentState.showAlterDialog is Function) {
            key.currentState.showAlterDialog(context);
          }
        });
      });
    }
  }

  Future<Map> getIndexListData(Map<String, dynamic> params) async {
    const juejin_flutter =
        'https://fluttergo.pub:9527/juejin.im/v1/get_tag_entry?src=web&tagId=5a96291f6fb9a0535b535438';
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    final _param = {'page': pageIndex, 'pageSize': 20, 'sort': 'rankIndex'};
    var responseList = [];
    var pageTotal = 0;

    try {
      var response = await NetUtils.get(juejin_flutter, _param);
      responseList = response['d']['entrylist'];
      pageTotal = response['d']['total'];
      if (!(pageTotal is int) || pageTotal <= 0) {
        pageTotal = 0;
      }
    } catch (e) {}
    pageIndex += 1;
    List resultList = new List();
    for (int i = 0; i < responseList.length; i++) {
      try {
        FirstPageItem cellData = new FirstPageItem.fromJson(responseList[i]);
        resultList.add(cellData);
      } catch (e) {}
    }
    Map<String, dynamic> result = {
      'list': resultList,
      'total': pageTotal,
      'pageIndex': pageIndex,
    };
    return result;
  }

  Widget makeCard(index, item) {
    var myTitle = '${item.title}';
    var myUsername = '${'👲'}: ${item.username} ';
    var codeUrl = '${item.detailUrl}';
    return ListViewItem(
      itemUrl: codeUrl,
      itemTitle: myTitle,
      data: myUsername,
    );
  }

  Widget headerView() {
    return Column(
      children: <Widget>[
        Stack(
//          alignment: const FractionalOffset(0.9, 0.1),//方法一
          children: <Widget>[
            // TODO
            Pagination(),
            Positioned(
              //方法二
              top: 10.0,
              left: 0.0,
              child: DisclaimerMsg(
                key: key,
                pWidget: this,
              ),
            )
          ],
        ),
        SizedBox(
          height: 1,
          child: Container(
            color: Theme.of(context).primaryColor,
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        Expanded(child: ListRefresh(getIndexListData, makeCard, headerView)),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

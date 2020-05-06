import 'package:flutter/material.dart';

class ListRefresh extends StatefulWidget {
  final renderItem;
  final requestApi;
  final headerView;

  const ListRefresh([this.requestApi, this.renderItem, this.headerView]) : super();

  @override
  State createState() => _ListRefreshState();
}

class _ListRefreshState extends State<ListRefresh> {
  // 是否正在请求数据中
  bool isLoading = false;

  // 是否还有更多数据可加载
  bool _hasMore = true;

  // 页面的索引
  int _pageIndex = 0;
  int _pageTotal = 0;
  List items = new List();
  ScrollController _scrollController = new ScrollController();

  /// 回弹效果
  backElasticEffect() {
//    double edge = 50.0;
//    double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
//    if (offsetFromBottom < edge) { // 添加一个动画没有更多数据的时候 ListView 向下移动覆盖正在加载更多数据的标志
//      _scrollController.animateTo(
//          _scrollController.offset - (edge - offsetFromBottom),
//          duration: new Duration(milliseconds: 1000),
//          curve: Curves.easeOut);
//    }
  }

  @override
  void initState() {
    super.initState();
    _getMoreData();
    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll最下面 自动加载更多
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future<Null> _handleRefresh() async {
    List newEntries = await mokeHttpRequest();
    if (this.mounted) {
      setState(() {
        items.clear();
        items.addAll(newEntries);
        isLoading = false;
        _hasMore = true;
        return null;
      });
    }
  }

  /// 加载中的提示
  Widget _buildLoadText() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Text('没有更多数据。。。'),
        ),
      ),
    );
  }

  /// 上拉加载loading的widget, 如果数据达到极限, 显示没有更多
  Widget _buildProgressIndicator() {
    if (_hasMore) {
      return new Padding(
        padding: const EdgeInsets.all(8.0),
        child: new Center(
          child: Column(
            children: <Widget>[
              new Opacity(
                opacity: isLoading ? 1.0 : 0.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.blue),
                ),
              ),
              SizedBox(height: 20.0),
              Text('稍等片刻更精彩...', style: TextStyle(fontSize: 14.0)),
            ],
          ),
        ),
      );
    } else {
      return _buildLoadText();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: ListView.builder(
        itemCount: items.length + 1,
        itemBuilder: (context, index) {
          if (0 == index && items.length != index) {
            if (widget.headerView is Function) {
              return widget.headerView();
            } else {
              return Container(height: 0.0);
            }
          }
          if (items.length == index) {
            return _buildProgressIndicator();
          } else {
            if (widget.renderItem is Function) {
              return widget.renderItem(index, items[index]);
            }
          }
          return null;
        },
        controller: _scrollController,
      ),
      onRefresh: _handleRefresh,
    );
  }

  Future _getMoreData() async {
    if (!isLoading && _hasMore) {
      // 如果上一次异步请求数据完成，同时又有数据可以加载
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      List newEntries = await mokeHttpRequest();
      _hasMore = (_pageIndex <= _pageTotal);
      if (this.mounted) {
        setState(() {
          items.addAll(newEntries);
          isLoading = false;
        });
      }
      backElasticEffect();
    } else if (!isLoading && !_hasMore) {
      // 这样判断，减少以后的绘制
      _pageIndex = 0;
      backElasticEffect();
    }
  }

  /// 假数据
  Future<List> mokeHttpRequest() async {
    if (widget.requestApi is Function) {
      final listObj = await widget.requestApi({'pageIndex': _pageIndex});
      _pageIndex = listObj['pageIndex'];
      _pageTotal = listObj['total'];
      return listObj['list'];
    } else {
      return Future.delayed(Duration(seconds: 2), () {
        return [];
      });
    }
  }
}

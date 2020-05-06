import 'package:startupapp/utils/util.dart';

class FirstPageItem {
  bool hot;
  String isCollection;
  String tag;
  String username;
  int collectionCount;
  int commentCount;
  String title;
  String createdTime;
  String detailUrl;

  FirstPageItem({
    this.hot,
    this.isCollection,
    this.tag,
    this.username,
    this.collectionCount,
    this.commentCount,
    this.title,
    this.createdTime,
    this.detailUrl,
  });

  factory FirstPageItem.fromJson(Map<String, dynamic> json) {
    String _tag = '';
    if (json['tags'].length > 0) {
      _tag = '${json['tags'][0]['title']}/';
    }
    return FirstPageItem(
      hot: json['hot'],
      collectionCount: json['collectionCount'],
      commentCount: json['commentsCount'],
      tag: '$_tag${json['category']['name']}',
      username: json['user']['username'],
      createdTime: Util.getTimeDuration(json['createdAt']),
      title: json['title'],
      detailUrl: json['originalUrl'],
      isCollection: json['type'],
    );
  }
}
